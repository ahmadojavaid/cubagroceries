import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
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
              ? _buildError(state.error!)
              : state.complaints.isEmpty
                  ? _buildEmpty()
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
                          return _ComplaintCard(
                              complaint: state.complaints[index]);
                        },
                      ),
                    ),
    );
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
                .read(complaintListProvider.notifier)
                .fetchComplaints(forceRefresh: true),
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
          Icon(Icons.chat_bubble_outline,
              size: 64, color: AppColors.textHint.withOpacity(0.5)),
          const SizedBox(height: AppDimens.md),
          const Text(
            'No complaints yet',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimens.xs),
          const Text(
            'We hope everything is going well!',
            style: TextStyle(fontSize: 13, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }
}

class _ComplaintCard extends StatelessWidget {
  final ComplaintModel complaint;

  const _ComplaintCard({required this.complaint});

  @override
  Widget build(BuildContext context) {
    final dateStr =
        DateFormat('MMM d, yyyy').format(complaint.createdAt);

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimens.sm),
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
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

          // Order reference + date
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
            ],
          ),
        ],
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
