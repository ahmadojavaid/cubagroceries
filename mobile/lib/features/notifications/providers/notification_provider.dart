import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/notification_model.dart';

/// State for notification list
class NotificationListState {
  final List<NotificationModel> notifications;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final int lastPage;

  const NotificationListState({
    this.notifications = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  bool get hasMore => currentPage < lastPage;

  NotificationListState copyWith({
    List<NotificationModel>? notifications,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    int? lastPage,
  }) {
    return NotificationListState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

/// Notification list notifier — paginated fetch, mark read
class NotificationListNotifier extends StateNotifier<NotificationListState> {
  final ApiClient _api;

  NotificationListNotifier(this._api) : super(const NotificationListState());

  /// Fetch first page of notifications
  Future<void> fetchNotifications({bool forceRefresh = false}) async {
    if (state.isLoading) return;
    if (state.notifications.isNotEmpty && !forceRefresh) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/notifications', queryParameters: {
        'page': 1,
        'per_page': 20,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((n) =>
                NotificationModel.fromJson(Map<String, dynamic>.from(n)))
            .toList();

        state = NotificationListState(
          notifications: list,
          currentPage: data['meta']?['current_page'] ?? 1,
          lastPage: data['meta']?['last_page'] ?? 1,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load notifications',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load notifications. Please try again.',
      );
    }
  }

  /// Load next page
  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _api.get('/notifications', queryParameters: {
        'page': nextPage,
        'per_page': 20,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((n) =>
                NotificationModel.fromJson(Map<String, dynamic>.from(n)))
            .toList();

        state = state.copyWith(
          notifications: [...state.notifications, ...list],
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

  /// Mark a single notification as read (optimistic update)
  Future<void> markAsRead(String id) async {
    // Optimistic: update UI immediately
    state = state.copyWith(
      notifications: state.notifications.map((n) {
        return n.id == id ? n.markAsRead() : n;
      }).toList(),
    );

    try {
      await _api.put('/notifications/$id/read');
    } catch (_) {
      // Revert on failure by re-fetching
      await fetchNotifications(forceRefresh: true);
    }
  }

  /// Mark all notifications as read (optimistic update)
  Future<void> markAllAsRead() async {
    // Optimistic: update UI immediately
    state = state.copyWith(
      notifications:
          state.notifications.map((n) => n.markAsRead()).toList(),
    );

    try {
      await _api.put('/notifications/read-all');
    } catch (_) {
      await fetchNotifications(forceRefresh: true);
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Notification list provider
final notificationListProvider =
    StateNotifierProvider<NotificationListNotifier, NotificationListState>(
        (ref) {
  final api = ref.watch(apiClientProvider);
  return NotificationListNotifier(api);
});

/// Unread notification count (derived provider)
final unreadNotificationCountProvider = Provider<int>((ref) {
  final state = ref.watch(notificationListProvider);
  return state.notifications.where((n) => !n.isRead).length;
});
