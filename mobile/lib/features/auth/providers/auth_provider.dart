import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/api_provider.dart';
import '../../../core/services/fcm_service.dart';
import '../../../core/services/fcm_notification_handler.dart';
import '../../../core/providers/fcm_provider.dart';

/// Represents the current auth state
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final Map<String, dynamic>? user;
  final String? error;
  final String role; // 'customer' or 'rider'

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.error,
    this.role = 'customer',
  });

  bool get isRider => role == 'rider';
  bool get isCustomer => role == 'customer';

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    Map<String, dynamic>? user,
    String? error,
    String? role,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
      role: role ?? this.role,
    );
  }
}

/// Auth state notifier — manages login, register, logout, and token persistence
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _api;
  final FcmService _fcm;
  final FcmNotificationHandler _fcmHandler;

  AuthNotifier(this._api, this._fcm, this._fcmHandler) : super(const AuthState());

  /// Check if user has a stored token on app start
  Future<void> checkAuth() async {
    final hasToken = await _api.hasToken();
    if (hasToken) {
      try {
        final response = await _api.get('/auth/user');
        final data = response.data;
        if (data['success'] == true) {
          final userData = Map<String, dynamic>.from(data['data']);
          state = AuthState(
            isAuthenticated: true,
            user: userData,
            role: userData['role'] as String? ?? 'customer',
          );
          // Send FCM token after auth verification
          _fcm.initialize();
          _fcmHandler.initialize();
          return;
        }
      } catch (_) {
        await _api.clearToken();
      }
    }
    state = const AuthState(isAuthenticated: false);
  }

  /// Register a new customer
  Future<bool> register({
    required String identity,
    required String email,
    required String firstname,
    required String lastname,
    required String password,
    required String passwordConfirmation,
    String? dateOfBirth,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.post('/auth/register', data: {
        'identity': identity,
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'password': password,
        'password_confirmation': passwordConfirmation,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      });

      final data = response.data;
      if (data['success'] == true) {
        await _api.saveToken(data['data']['token']);
        final userData = Map<String, dynamic>.from(data['data']['user']);
        state = AuthState(
          isAuthenticated: true,
          user: userData,
          role: userData['role'] as String? ?? 'customer',
        );
        _fcm.initialize();
        _fcmHandler.initialize();
        return true;
      }

      state = state.copyWith(isLoading: false, error: data['message']);
      return false;
    } catch (e) {
      final message = _extractError(e);
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }

  /// Login with email and password
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final data = response.data;
      if (data['success'] == true) {
        await _api.saveToken(data['data']['token']);
        final userData = Map<String, dynamic>.from(data['data']['user']);
        state = AuthState(
          isAuthenticated: true,
          user: userData,
          role: userData['role'] as String? ?? 'customer',
        );
        _fcm.initialize();
        _fcmHandler.initialize();
        return true;
      }

      state = state.copyWith(isLoading: false, error: data['message']);
      return false;
    } catch (e) {
      final message = _extractError(e);
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }

  /// Google Sign-In
  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final googleSignIn = GoogleSignIn(
        serverClientId: AppConfig.googleWebClientId,
      );

      final account = await googleSignIn.signIn();
      if (account == null) {
        // User cancelled
        state = state.copyWith(isLoading: false);
        return false;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        state = state.copyWith(isLoading: false, error: 'Could not get Google token.');
        return false;
      }

      // Send token to our backend
      final response = await _api.post('/auth/google', data: {
        'id_token': idToken,
      });

      final data = response.data;
      if (data['success'] == true) {
        await _api.saveToken(data['data']['token']);
        final userData = Map<String, dynamic>.from(data['data']['user']);
        state = AuthState(
          isAuthenticated: true,
          user: userData,
          role: userData['role'] as String? ?? 'customer',
        );
        _fcm.initialize();
        _fcmHandler.initialize();
        return true;
      }

      state = state.copyWith(isLoading: false, error: data['message']);
      return false;
    } catch (e) {
      final message = _extractError(e);
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }

  /// Phone OTP — Step 1: Send verification code
  Future<bool> sendPhoneOtp({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onError,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await fb.FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (fb.PhoneAuthCredential credential) async {
          // Auto-retrieval on Android
          await _completePhoneAuth(credential, phoneNumber);
        },
        verificationFailed: (fb.FirebaseAuthException e) {
          state = state.copyWith(isLoading: false, error: e.message);
          onError(e.message ?? 'Verification failed');
        },
        codeSent: (String verificationId, int? resendToken) {
          state = state.copyWith(isLoading: false);
          onCodeSent(verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          debugPrint('Phone OTP auto-retrieval timeout: $verificationId');
        },
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to send OTP');
      onError('Failed to send OTP');
      return false;
    }
  }

  /// Phone OTP — Step 2: Verify code and authenticate
  Future<bool> verifyPhoneOtp({
    required String verificationId,
    required String smsCode,
    required String phoneNumber,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final credential = fb.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return await _completePhoneAuth(credential, phoneNumber);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Invalid OTP code');
      return false;
    }
  }

  /// Complete phone auth: sign in with Firebase, send token to backend
  Future<bool> _completePhoneAuth(fb.PhoneAuthCredential credential, String phoneNumber) async {
    try {
      final userCredential = await fb.FirebaseAuth.instance.signInWithCredential(credential);
      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        state = state.copyWith(isLoading: false, error: 'Could not get verification token');
        return false;
      }

      // Send to our backend
      final response = await _api.post('/auth/phone-verify', data: {
        'id_token': idToken,
        'phone': phoneNumber,
      });

      final data = response.data;
      if (data['success'] == true) {
        await _api.saveToken(data['data']['token']);
        final userData = Map<String, dynamic>.from(data['data']['user']);
        state = AuthState(
          isAuthenticated: true,
          user: userData,
          role: userData['role'] as String? ?? 'customer',
        );
        _fcm.initialize();
        _fcmHandler.initialize();

        // Sign out of Firebase (we use our own Sanctum tokens)
        await fb.FirebaseAuth.instance.signOut();
        return true;
      }

      state = state.copyWith(isLoading: false, error: data['message']);
      return false;
    } catch (e) {
      final message = _extractError(e);
      state = state.copyWith(isLoading: false, error: message);
      return false;
    }
  }

  /// Logout and clear token
  Future<void> logout() async {
    try {
      await _api.post('/auth/logout');
    } catch (_) {
      // Ignore errors — still clear local state
    }
    await _api.clearToken();
    FcmService.clearToken();
    state = const AuthState(isAuthenticated: false);
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  String _extractError(dynamic e) {
    if (e is Exception) {
      final dioError = e as dynamic;
      if (dioError.error is ApiException) {
        return (dioError.error as ApiException).firstError;
      }
    }
    return 'Something went wrong. Please try again.';
  }
}

/// Auth provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final api = ref.watch(apiClientProvider);
  final fcm = ref.watch(fcmServiceProvider);
  final fcmHandler = ref.watch(fcmNotificationHandlerProvider);
  return AuthNotifier(api, fcm, fcmHandler);
});

/// Derived provider: current user role
final userRoleProvider = Provider<String>((ref) {
  return ref.watch(authProvider).role;
});

/// Derived provider: is the user a rider?
final isRiderProvider = Provider<bool>((ref) {
  return ref.watch(authProvider).isRider;
});
