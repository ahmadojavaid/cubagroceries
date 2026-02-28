import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../core/providers/api_provider.dart';
import '../data/user_model.dart';

/// Profile state
class ProfileState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const ProfileState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  ProfileState copyWith({
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Profile state notifier — fetch and update profile
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ApiClient _api;

  ProfileNotifier(this._api) : super(const ProfileState());

  /// Fetch profile from API
  Future<void> fetchProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.get('/profile');
      final data = response.data;
      if (data['success'] == true) {
        state = ProfileState(
          user: UserModel.fromJson(Map<String, dynamic>.from(data['data'])),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load profile',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractError(e),
      );
    }
  }

  /// Update profile via API
  Future<bool> updateProfile({
    required String firstname,
    required String lastname,
    required String email,
    String? dateOfBirth,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.put('/profile', data: {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      });

      final data = response.data;
      if (data['success'] == true) {
        state = ProfileState(
          user: UserModel.fromJson(Map<String, dynamic>.from(data['data'])),
        );
        return true;
      }

      state = state.copyWith(
        isLoading: false,
        error: data['message'] ?? 'Failed to update profile',
      );
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
      return false;
    }
  }

  /// Clear error
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

/// Profile provider
final profileProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final api = ref.watch(apiClientProvider);
  return ProfileNotifier(api);
});
