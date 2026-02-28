import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/api/api_client.dart';
import '../../core/api/api_exception.dart';
import '../../core/providers/api_provider.dart';

/// Represents the current auth state
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final Map<String, dynamic>? user;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    Map<String, dynamic>? user,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}

/// Auth state notifier — manages login, register, logout, and token persistence
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiClient _api;

  AuthNotifier(this._api) : super(const AuthState());

  /// Check if user has a stored token on app start
  Future<void> checkAuth() async {
    final hasToken = await _api.hasToken();
    if (hasToken) {
      try {
        final response = await _api.get('/auth/user');
        final data = response.data;
        if (data['success'] == true) {
          state = AuthState(
            isAuthenticated: true,
            user: Map<String, dynamic>.from(data['data']),
          );
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
        state = AuthState(
          isAuthenticated: true,
          user: Map<String, dynamic>.from(data['data']['user']),
        );
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
        state = AuthState(
          isAuthenticated: true,
          user: Map<String, dynamic>.from(data['data']['user']),
        );
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
  return AuthNotifier(api);
});
