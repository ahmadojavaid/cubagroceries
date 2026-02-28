import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/complaint_model.dart';
import '../providers/complaint_provider.dart';

class ComplaintsHistoryScreen extends ConsumerStatefulWidget {
  const ComplaintsHistoryScreen({super.key});

  @override
  ConsumerState<ComplaintsHistoryScreen> createState() =>
      _ComplaintsHistoryScreenState();
}

class _ComplaintsHistoryScreenState
    extends ConsumerState<ComplaintsHistoryScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(complaintListProvider.notifier)
          .fetchComplaints(forceRefresh: true),
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
      ref.read(complaintListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(complaintListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Complaints'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => context.push('/complaints/new'),
            tooltip: 'New Complaint',
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null && state.complaints.isEmpty
              ? ErrorStateWidget(
                  message: state.error!,
                  onRetry: () => ref
                      .read(complaintListProvider.notifier)
                      .fetchComplaints(forceRefresh: true),
                )
              : state.complaints.isEmpty
                  ? const EmptyStateWidget(
                      icon: Icons.chat_bubble_outline,
                      message:
                          'No complaints yet\nWe hope everything is going well!',
                    )
                  : RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: () => ref
                          .read(complaintListProvider.notifier)
                          .fetchComplaints(forceRefresh: true),
                      child: ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(AppDimens.pagePadding),
                        itemCount: state.complaints.length +
                            (state.isLoadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == state.complaints.length) {
                            return const Padding(
                              padding: EdgeInsets.all(AppDimens.md),
                              child: Center(
                                  child: CircularProgressIndicator()),
                            );
                          }
                          final complaint = state.complaints[index];
                          return _ComplaintCard(
                            complaint: complaint,
                            onTap: () => context.push(
                              '/complaints/detail',
                              extra: complaint,
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;
  final VoidCallback onTap;

  const _ComplaintCard({required this.complaint, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateStr = DateFormat('MMM d, yyyy').format(complaint.createdAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.sm),
      child: Material(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          child: Container(
            padding: const EdgeInsets.all(AppDimens.md),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject + status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        complaint.subject,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.sm),
                    _statusBadge(complaint.status, complaint.displayStatus),
                  ],
                ),

                const SizedBox(height: AppDimens.sm),

                // Order reference + date + chevron
                Row(
                  children: [
                    if (complaint.orderNumber != null) ...[
                      Icon(Icons.receipt_outlined,
                          size: 14, color: AppColors.textHint),
                      const SizedBox(width: 4),
                      Text(
                        complaint.orderNumber!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: AppDimens.md),
                    ],
                    Icon(Icons.calendar_today_outlined,
                        size: 14, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(
                      dateStr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textHint,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.chevron_right_rounded,
                      size: 20,
                      color: AppColors.textHint,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(String status, String label) {
    final (color, bgColor) = switch (status) {
      'pending' => (
          AppColors.statusPending,
          AppColors.statusPending.withOpacity(0.12)
        ),
      'in_progress' => (AppColors.info, AppColors.info.withOpacity(0.12)),
      'resolved' => (
          AppColors.statusDelivered,
          AppColors.statusDelivered.withOpacity(0.12)
        ),
      'closed' => (
          AppColors.textSecondary,
          AppColors.textSecondary.withOpacity(0.12)
        ),
      _ => (AppColors.textSecondary, AppColors.surfaceBg),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
