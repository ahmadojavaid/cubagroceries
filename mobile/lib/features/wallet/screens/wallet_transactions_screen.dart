import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../profile/providers/profile_provider.dart';
import '../data/wallet_transaction_model.dart';
import '../providers/wallet_provider.dart';

class WalletTransactionsScreen extends ConsumerStatefulWidget {
  const WalletTransactionsScreen({super.key});

  @override
  ConsumerState<WalletTransactionsScreen> createState() =>
      _WalletTransactionsScreenState();
}

class _WalletTransactionsScreenState
    extends ConsumerState<WalletTransactionsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(walletTransactionProvider.notifier).fetch());
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
      ref.read(walletTransactionProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(walletTransactionProvider);
    final profileState = ref.watch(profileProvider);
    final walletAmount = profileState.user?.walletAmount ?? '0';

    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () =>
            ref.read(walletTransactionProvider.notifier).fetch(forceRefresh: true),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Balance header
            SliverToBoxAdapter(child: _buildBalanceHeader(walletAmount)),

            // Summary row
            if (state.transactions.isNotEmpty)
              SliverToBoxAdapter(child: _buildSummary(state.transactions)),

            // Section title
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    AppDimens.pagePadding, AppDimens.md, AppDimens.pagePadding, AppDimens.sm),
                child: Text(
                  'Transaction History',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),

            // Loading
            if (state.isLoading && state.transactions.isEmpty)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),

            // Error
            if (state.error != null && state.transactions.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 40, color: AppColors.textHint),
                      const SizedBox(height: 12),
                      Text(state.error!,
                          style: const TextStyle(
                              color: AppColors.textSecondary)),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => ref
                            .read(walletTransactionProvider.notifier)
                            .fetch(forceRefresh: true),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),

            // Empty
            if (!state.isLoading &&
                state.error == null &&
                state.transactions.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long_outlined,
                          size: 48, color: AppColors.textHint),
                      SizedBox(height: 12),
                      Text('No transactions yet',
                          style: TextStyle(
                              fontSize: 15, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
              ),

            // Transaction list
            if (state.transactions.isNotEmpty)
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.pagePadding),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= state.transactions.length) {
                        return state.isLoadingMore
                            ? const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2)),
                              )
                            : const SizedBox.shrink();
                      }
                      return _TransactionTile(
                        transaction: state.transactions[index],
                        isLast: index == state.transactions.length - 1,
                      );
                    },
                    childCount: state.transactions.length +
                        (state.hasMore ? 1 : 0),
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceHeader(String walletAmount) {
    return Container(
      margin: const EdgeInsets.all(AppDimens.pagePadding),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryDark,
            AppColors.primary,
          ],
        ),
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: Column(
        children: [
          const Icon(Icons.account_balance_wallet_rounded,
              size: 36, color: Colors.white70),
          const SizedBox(height: 10),
          Text(
            'Rs. $walletAmount',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Available Balance',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(List<WalletTransactionModel> transactions) {
    double totalIn = 0;
    double totalOut = 0;
    for (final txn in transactions) {
      if (txn.isCredit) {
        totalIn += txn.amount;
      } else {
        totalOut += txn.amount;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
      child: Row(
        children: [
          Expanded(
            child: _SummaryCard(
              icon: Icons.arrow_downward_rounded,
              label: 'Total In',
              amount: 'Rs. ${totalIn.toStringAsFixed(0)}',
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: AppDimens.sm),
          Expanded(
            child: _SummaryCard(
              icon: Icons.arrow_upward_rounded,
              label: 'Total Out',
              amount: 'Rs. ${totalOut.toStringAsFixed(0)}',
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Summary Card ───────────────────────────────────────────

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;
  final Color color;

  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.amount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 11,
                        color: color.withOpacity(0.7),
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(amount,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Transaction Tile ───────────────────────────────────────

class _TransactionTile extends StatelessWidget {
  final WalletTransactionModel transaction;
  final bool isLast;

  const _TransactionTile({
    required this.transaction,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isCredit = transaction.isCredit;
    final color = isCredit ? AppColors.success : AppColors.error;
    final dateStr =
        DateFormat('MMM d, yyyy • h:mm a').format(transaction.createdAt);

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 1),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isCredit
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 12),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.sourceLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction.note ?? dateStr,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (transaction.note != null) ...[
                  const SizedBox(height: 1),
                  Text(
                    dateStr,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Amount + balance
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                transaction.displayAmount,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Bal: ${transaction.displayBalance}',
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
