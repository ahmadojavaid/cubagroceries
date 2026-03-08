import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../data/complaint_model.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final ComplaintModel complaint;

  const ComplaintDetailScreen({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        children: [
          // Status + date header
          _buildStatusHeader(context),
          const SizedBox(height: AppDimens.lg),

          // Subject
          _buildSection(
            context,
            label: 'Subject',
            child: Text(
              complaint.subject,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: AppDimens.md),

          // Message
          _buildSection(
            context,
            label: 'Description',
            child: Text(
              complaint.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: AppColors.textSecondary,
                  ),
            ),
          ),

          // Order reference
          if (complaint.orderNumber != null) ...[
            const SizedBox(height: AppDimens.md),
            _buildSection(
              context,
              label: 'Related Order',
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.md,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.receipt_long_outlined,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppDimens.sm + 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          complaint.orderNumber!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (complaint.orderStatus != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              complaint.orderStatus!,
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textHint,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: AppDimens.xxl),
        ],
      ),
    );
  }

  Widget _buildStatusHeader(BuildContext context) {
    final dateStr = DateFormat('d MMM, yyyy  •  h:mm a').format(complaint.createdAt);
    final (color, bgColor, icon) = _statusStyle(complaint.status);

    return Container(
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          const SizedBox(width: AppDimens.md - 2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  complaint.displayStatus,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 12,
                    color: color.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String label, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.md),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textHint,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          child,
        ],
      ),
    );
  }

  (Color, Color, IconData) _statusStyle(String status) {
    return switch (status) {
      'pending' => (
          AppColors.statusPending,
          AppColors.statusPending.withValues(alpha: 0.08),
          Icons.schedule_rounded,
        ),
      'in_progress' => (
          AppColors.info,
          AppColors.info.withValues(alpha: 0.08),
          Icons.autorenew_rounded,
        ),
      'resolved' => (
          AppColors.statusDelivered,
          AppColors.statusDelivered.withValues(alpha: 0.08),
          Icons.check_circle_outline_rounded,
        ),
      'closed' => (
          AppColors.textSecondary,
          AppColors.textSecondary.withValues(alpha: 0.08),
          Icons.archive_outlined,
        ),
      _ => (
          AppColors.textSecondary,
          AppColors.surfaceBg,
          Icons.help_outline_rounded,
        ),
    };
  }
}
