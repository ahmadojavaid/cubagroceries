import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../core/providers/api_provider.dart';
import '../data/complaint_model.dart';

/// State for complaint list
class ComplaintListState {
  final List<ComplaintModel> complaints;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final int lastPage;

  const ComplaintListState({
    this.complaints = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  bool get hasMore => currentPage < lastPage;

  ComplaintListState copyWith({
    List<ComplaintModel>? complaints,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    int? lastPage,
  }) {
    return ComplaintListState(
      complaints: complaints ?? this.complaints,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

/// State for submitting a complaint
class SubmitComplaintState {
  final bool isLoading;
  final String? error;
  final ComplaintModel? submitted;

  const SubmitComplaintState({
    this.isLoading = false,
    this.error,
    this.submitted,
  });

  SubmitComplaintState copyWith({
    bool? isLoading,
    String? error,
    ComplaintModel? submitted,
  }) {
    return SubmitComplaintState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      submitted: submitted ?? this.submitted,
    );
  }
}

/// Complaint list notifier — paginated fetch
class ComplaintListNotifier extends StateNotifier<ComplaintListState> {
  final ApiClient _api;

  ComplaintListNotifier(this._api) : super(const ComplaintListState());

  /// Fetch first page
  Future<void> fetchComplaints({bool forceRefresh = false}) async {
    if (state.isLoading) return;
    if (state.complaints.isNotEmpty && !forceRefresh) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/complaints', queryParameters: {
        'page': 1,
        'per_page': 20,
      });
      final data = response.data;

      if (data['success'] == true) {
        final rawList = data['data'] as List;
        final list = <ComplaintModel>[];
        for (final c in rawList) {
          try {
            list.add(ComplaintModel.fromJson(Map<String, dynamic>.from(c)));
          } catch (parseErr) {
            // Skip malformed entries rather than crashing
            debugPrint('Failed to parse complaint: $parseErr');
          }
        }

        state = ComplaintListState(
          complaints: list,
          currentPage: data['meta']?['current_page'] ?? 1,
          lastPage: data['meta']?['last_page'] ?? 1,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load complaints',
        );
      }
    } catch (e) {
      debugPrint('Complaints fetch error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load complaints. Please try again.',
      );
    }
  }

  /// Load next page
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _api.get('/complaints', queryParameters: {
        'page': nextPage,
        'per_page': 20,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((c) =>
                ComplaintModel.fromJson(Map<String, dynamic>.from(c)))
            .toList();

        state = state.copyWith(
          complaints: [...state.complaints, ...list],
          isLoadingMore: false,
          currentPage: data['meta']?['current_page'] ?? nextPage,
          lastPage: data['meta']?['last_page'] ?? state.lastPage,
        );
      } else {
        state = state.copyWith(isLoadingMore: false);
      }
    } catch (_) {
      state = state.copyWith(isLoadingMore: false);
    }
  }

  /// Add a newly submitted complaint to the top of the list
  void addComplaint(ComplaintModel complaint) {
    state = state.copyWith(
      complaints: [complaint, ...state.complaints],
    );
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Submit complaint notifier
class SubmitComplaintNotifier extends StateNotifier<SubmitComplaintState> {
  final ApiClient _api;

  SubmitComplaintNotifier(this._api) : super(const SubmitComplaintState());

  /// Submit a new complaint
  Future<ComplaintModel?> submitComplaint({
    required String subject,
    required String message,
    int? orderId,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.post('/complaints', data: {
        'subject': subject,
        'message': message,
        'order_id': ?orderId,
      });
      final data = response.data;

      if (data['success'] == true) {
        final complaint = ComplaintModel.fromJson(
            Map<String, dynamic>.from(data['data']));
        state = SubmitComplaintState(submitted: complaint);
        return complaint;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to submit complaint',
        );
        return null;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _extractError(e),
      );
      return null;
    }
  }

  void reset() {
    state = const SubmitComplaintState();
  }

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

/// Complaint list provider
final complaintListProvider =
    StateNotifierProvider<ComplaintListNotifier, ComplaintListState>((ref) {
  final api = ref.watch(apiClientProvider);
  return ComplaintListNotifier(api);
});

/// Submit complaint provider
final submitComplaintProvider =
    StateNotifierProvider<SubmitComplaintNotifier, SubmitComplaintState>((ref) {
  final api = ref.watch(apiClientProvider);
  return SubmitComplaintNotifier(api);
});
