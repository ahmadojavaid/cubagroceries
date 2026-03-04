import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/wallet_transaction_model.dart';

class WalletTransactionState {
  final List<WalletTransactionModel> transactions;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int currentPage;
  final int lastPage;

  const WalletTransactionState({
    this.transactions = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  bool get hasMore => currentPage < lastPage;

  WalletTransactionState copyWith({
    List<WalletTransactionModel>? transactions,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? currentPage,
    int? lastPage,
  }) {
    return WalletTransactionState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}

class WalletTransactionNotifier extends StateNotifier<WalletTransactionState> {
  final ApiClient _api;

  WalletTransactionNotifier(this._api) : super(const WalletTransactionState());

  Future<void> fetch({bool forceRefresh = false}) async {
    if (state.isLoading) return;
    if (state.transactions.isNotEmpty && !forceRefresh) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/wallet/transactions', queryParameters: {
        'page': 1,
        'per_page': 30,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((t) =>
                WalletTransactionModel.fromJson(Map<String, dynamic>.from(t)))
            .toList();

        state = WalletTransactionState(
          transactions: list,
          currentPage: data['meta']?['current_page'] ?? 1,
          lastPage: data['meta']?['last_page'] ?? 1,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load transactions',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load transactions',
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final response = await _api.get('/wallet/transactions', queryParameters: {
        'page': nextPage,
        'per_page': 30,
      });
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((t) =>
                WalletTransactionModel.fromJson(Map<String, dynamic>.from(t)))
            .toList();

        state = state.copyWith(
          transactions: [...state.transactions, ...list],
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
}

final walletTransactionProvider = StateNotifierProvider<
    WalletTransactionNotifier, WalletTransactionState>((ref) {
  final api = ref.watch(apiClientProvider);
  return WalletTransactionNotifier(api);
});
