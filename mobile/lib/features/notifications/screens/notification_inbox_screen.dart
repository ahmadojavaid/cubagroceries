import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationInboxScreen extends ConsumerStatefulWidget {
  const NotificationInboxScreen({super.key});

  @override
  ConsumerState<NotificationInboxScreen> createState() =>
      _NotificationInboxScreenState();
}

class _NotificationInboxScreenState
    extends ConsumerState<NotificationInboxScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(notificationListProvider.notifier)
          .fetchNotifications(forceRefresh: true),
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(notificationListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(notificationListProvider);
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () => ref
                  .read(notificationListProvider.notifier)
                  .markAllAsRead(),
              child: const Text('Mark all read'),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null && state.notifications.isEmpty
              ? _buildError(state.error!)
              : state.notifications.isEmpty
                  ? _buildEmpty()
                  : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () => ref
                          .read(notificationListProvider.notifier)
                          .fetchNotifications(forceRefresh: true),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimens.sm),
                        itemCount: state.notifications.length +
                            (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.notifications.length) {
                            return const Padding(
                              padding: EdgeInsets.all(AppDimens.md),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                          return _NotificationTile(
                            notification: state.notifications[index],
                            onTap: () =>
                                _onNotificationTap(state.notifications[index]),
                          );
                        },
                      ),
                    ),
    );
  }

  void _onNotificationTap(NotificationModel notification) {
    // Mark as read
    if (!notification.isRead) {
      ref
          .read(notificationListProvider.notifier)
          .markAsRead(notification.id);
    }

    // Navigate to order detail if it's an order notification
    if (notification.isOrderStatusChange &&
        notification.orderNumber != null) {
      context.push('/orders/${notification.orderNumber}');
    }
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,
              size: 48, color: AppColors.textHint),
          const SizedBox(height: AppDimens.md),
          Text(error,
              style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: AppDimens.md),
          TextButton(
            onPressed: () => ref
                .read(notificationListProvider.notifier)
                .fetchNotifications(forceRefresh: true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_rounded,
              size: 64, color: AppColors.textHint.withOpacity(0.5)),
          const SizedBox(height: AppDimens.md),
          const Text(
            'No notifications yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
          const Text(
            'You\'ll be notified about order updates here',
            style: TextStyle(fontSize: 13, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isRead
            ? Colors.transparent
            : AppColors.primarySurface.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.pagePadding,
          vertical: AppDimens.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(_icon, size: 20, color: _iconColor),
            ),
            const SizedBox(width: AppDimens.md),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: notification.isRead
                          ? FontWeight.w400
                          : FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTimeAgo(notification.createdAt),
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),

            // Unread dot
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 6, left: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    if (notification.newStatus != null) {
      return switch (notification.newStatus!) {
        'confirmed' => Icons.check_circle_outline,
        'dispatched' => Icons.local_shipping_outlined,
        'delivered' => Icons.check_circle,
        'cancelled' => Icons.cancel_outlined,
        _ => Icons.notifications_outlined,
      };
    }
    return Icons.notifications_outlined;
  }

  Color get _iconColor {
    if (notification.newStatus != null) {
      return switch (notification.newStatus!) {
        'confirmed' => AppColors.statusConfirmed,
        'dispatched' => AppColors.statusDispatched,
        'delivered' => AppColors.statusDelivered,
        'cancelled' => AppColors.statusCancelled,
        _ => AppColors.primary,
      };
    }
    return AppColors.primary;
  }

  Color get _iconBgColor => _iconColor.withOpacity(0.12);

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}
