import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/api/api_response.dart';
import '../../../core/providers/api_provider.dart';
import '../data/product_model.dart';

/// State for paginated product lists
class ProductsState {
  final List<ProductModel> products;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final PaginationMeta? meta;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.meta,
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    PaginationMeta? meta,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      meta: meta ?? this.meta,
    );
  }

  bool get hasMore => meta?.hasMore ?? false;
  int get nextPage => (meta?.currentPage ?? 0) + 1;
}

/// Products notifier — paginated fetch, filterable by category
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ApiClient _api;

  ProductsNotifier(this._api) : super(const ProductsState());

  /// Fetch first page of products, optionally filtered by category
  Future<void> fetchProducts({
    int? categoryId,
    int? subCategoryId,
    int perPage = 20,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final params = <String, dynamic>{
        'page': 1,
        'per_page': perPage,
        if (categoryId != null) 'category_id': categoryId,
        if (subCategoryId != null) 'sub_category_id': subCategoryId,
      };

      final response = await _api.get('/products', queryParameters: params);
      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
        response.data,
        fromData: (data) => (data as List)
            .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
            .toList(),
      );

      state = ProductsState(
        products: apiResponse.data ?? [],
        meta: apiResponse.meta,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load products. Please try again.',
      );
    }
  }

  /// Load next page (for infinite scroll)
  Future<void> loadMore({
    int? categoryId,
    int? subCategoryId,
    int perPage = 20,
  }) async {
    if (!state.hasMore || state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final params = <String, dynamic>{
        'page': state.nextPage,
        'per_page': perPage,
        if (categoryId != null) 'category_id': categoryId,
        if (subCategoryId != null) 'sub_category_id': subCategoryId,
      };

      final response = await _api.get('/products', queryParameters: params);
      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
        response.data,
        fromData: (data) => (data as List)
            .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
            .toList(),
      );

      state = ProductsState(
        products: [...state.products, ...(apiResponse.data ?? [])],
        meta: apiResponse.meta,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingMore: false,
        error: 'Failed to load more products.',
      );
    }
  }

  /// Search products by name
  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = const ProductsState();
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/products/search', queryParameters: {
        'q': query,
      });
      final apiResponse = ApiResponse<List<ProductModel>>.fromJson(
        response.data,
        fromData: (data) => (data as List)
            .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
            .toList(),
      );

      state = ProductsState(
        products: apiResponse.data ?? [],
        meta: apiResponse.meta,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Search failed. Please try again.',
      );
    }
  }

  /// Reset state
  void reset() {
    state = const ProductsState();
  }
}

/// Products provider
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final api = ref.watch(apiClientProvider);
  return ProductsNotifier(api);
});

/// Separate provider for search results (so browsing and searching don't collide)
final searchProductsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final api = ref.watch(apiClientProvider);
  return ProductsNotifier(api);
});

/// Related products provider
final relatedProductsProvider =
    FutureProvider.family<List<ProductModel>, int>((ref, productId) async {
  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get('/products/$productId/related');
    final data = response.data;
    if (data['success'] == true && data['data'] != null) {
      return (data['data'] as List)
          .map((p) => ProductModel.fromJson(Map<String, dynamic>.from(p)))
          .toList();
    }
    return [];
  } catch (_) {
    return [];
  }
});

/// Single product detail provider
final productDetailProvider = FutureProvider.family<ProductModel?, int>(
  (ref, productId) async {
    final api = ref.watch(apiClientProvider);
    try {
      final response = await api.get('/products/$productId');
      final data = response.data;
      if (data['success'] == true) {
        return ProductModel.fromJson(Map<String, dynamic>.from(data['data']));
      }
      return null;
    } catch (_) {
      return null;
    }
  },
);
