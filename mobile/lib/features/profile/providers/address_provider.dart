import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../core/providers/api_provider.dart';
import '../data/address_model.dart';

/// Address list state
class AddressState {
  final List<AddressModel> addresses;
  final bool isLoading;
  final String? error;

  const AddressState({
    this.addresses = const [],
    this.isLoading = false,
    this.error,
  });

  AddressState copyWith({
    List<AddressModel>? addresses,
    bool? isLoading,
    String? error,
  }) {
    return AddressState(
      addresses: addresses ?? this.addresses,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Address state notifier — full CRUD + set default
class AddressNotifier extends StateNotifier<AddressState> {
  final ApiClient _api;

  AddressNotifier(this._api) : super(const AddressState());

  /// Fetch all addresses
  Future<void> fetchAddresses() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.get('/addresses');
      final data = response.data;
      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        state = AddressState(addresses: list);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load addresses',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
    }
  }

  /// Add a new address
  Future<bool> addAddress(Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.post('/addresses', data: data);
      final result = response.data;
      if (result['success'] == true) {
        await fetchAddresses(); // Refresh list
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: result['message'] ?? 'Failed to add address',
      );
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
      return false;
    }
  }

  /// Update an existing address
  Future<bool> updateAddress(int id, Map<String, dynamic> data) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.put('/addresses/$id', data: data);
      final result = response.data;
      if (result['success'] == true) {
        await fetchAddresses(); // Refresh list
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: result['message'] ?? 'Failed to update address',
      );
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
      return false;
    }
  }

  /// Delete an address
  Future<bool> deleteAddress(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.delete('/addresses/$id');
      final result = response.data;
      if (result['success'] == true) {
        await fetchAddresses(); // Refresh list
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: result['message'] ?? 'Failed to delete address',
      );
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _extractError(e));
      return false;
    }
  }

  /// Set an address as default
  Future<bool> setDefault(int id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _api.put('/addresses/$id/default');
      final result = response.data;
      if (result['success'] == true) {
        await fetchAddresses(); // Refresh list
        return true;
      }
      state = state.copyWith(
        isLoading: false,
        error: result['message'] ?? 'Failed to set default address',
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

/// Address provider
final addressProvider =
    StateNotifierProvider<AddressNotifier, AddressState>((ref) {
  final api = ref.watch(apiClientProvider);
  return AddressNotifier(api);
});
