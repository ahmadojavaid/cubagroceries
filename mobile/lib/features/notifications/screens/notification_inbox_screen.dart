import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
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
              ? ErrorStateWidget(
                  message: state.error!,
                  onRetry: () => ref
                      .read(notificationListProvider.notifier)
                      .fetchNotifications(forceRefresh: true),
                )
              : state.notifications.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.notifications_none_rounded,
                      message:
                          'No notifications yet\nYou\'ll be notified about order updates here',
                    )
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
                              child:
                                  Center(child: CircularProgressIndicator()),
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

    // Navigate based on notification type
    if (notification.isOrderStatusChange &&
        notification.orderNumber != null) {
      context.push('/orders/${notification.orderNumber}');
    } else if (notification.isComplaintStatusChange) {
      context.push('/complaints');
    }
    // Manual push notifications don't navigate anywhere — just mark as read
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
            : AppColors.primarySurface.withValues(alpha: 0.3),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.pagePadding,
          vertical: AppDimens.md,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                        maxLines: 3,
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

            // Campaign image (if present)
            if (notification.imageUrl != null) ...[
              const SizedBox(height: AppDimens.sm),
              Padding(
                padding: const EdgeInsets.only(left: 52), // align with text
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: notification.imageUrl!,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => Container(
                      height: 140,
                      color: AppColors.surfaceBg,
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
                    errorWidget: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    // Manual / campaign push
    if (notification.isManualPush) {
      return Icons.campaign_outlined;
    }

    // Complaint updates
    if (notification.isComplaintStatusChange) {
      final status = notification.data['new_status'] as String?;
      return switch (status) {
        'resolved' => Icons.check_circle_outline,
        'in_progress' => Icons.search_rounded,
        'closed' => Icons.archive_outlined,
        _ => Icons.chat_bubble_outline_rounded,
      };
    }

    // Order status updates
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
    if (notification.isManualPush) {
      return AppColors.accent;
    }

    if (notification.isComplaintStatusChange) {
      final status = notification.data['new_status'] as String?;
      return switch (status) {
        'resolved' => AppColors.statusDelivered,
        'in_progress' => AppColors.info,
        'closed' => AppColors.textHint,
        _ => AppColors.warning,
      };
    }

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

  Color get _iconBgColor => _iconColor.withValues(alpha: 0.12);

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
