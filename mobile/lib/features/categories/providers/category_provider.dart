import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/category_model.dart';

/// State for the categories list
class CategoriesState {
  final List<CategoryModel> categories;
  final bool isLoading;
  final String? error;
  final DateTime? lastFetchedAt;

  const CategoriesState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.lastFetchedAt,
  });

  CategoriesState copyWith({
    List<CategoryModel>? categories,
    bool? isLoading,
    String? error,
    DateTime? lastFetchedAt,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastFetchedAt: lastFetchedAt ?? this.lastFetchedAt,
    );
  }

  /// Data is stale if older than 5 minutes
  bool get isStale {
    if (lastFetchedAt == null) return true;
    return DateTime.now().difference(lastFetchedAt!).inMinutes >= 5;
  }
}

/// Categories notifier — fetches and caches top-level categories with children
class CategoriesNotifier extends StateNotifier<CategoriesState> {
  final ApiClient _api;

  CategoriesNotifier(this._api) : super(const CategoriesState());

  /// Fetch all top-level categories with nested children
  Future<void> fetchCategories({bool forceRefresh = false}) async {
    // Skip if recently fetched and not forcing refresh
    if (state.categories.isNotEmpty && !forceRefresh && !state.isStale) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/categories');
      final data = response.data;

      if (data['success'] == true) {
        final list = (data['data'] as List)
            .map((c) => CategoryModel.fromJson(Map<String, dynamic>.from(c)))
            .toList();

        state = CategoriesState(categories: list, lastFetchedAt: DateTime.now());
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load categories',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load categories. Please try again.',
      );
    }
  }

  /// Find a category by ID (searches top-level and children)
  CategoryModel? findById(int id) {
    for (final category in state.categories) {
      if (category.id == id) return category;
      for (final child in category.children) {
        if (child.id == id) return child;
      }
    }
    return null;
  }

  /// Get all sub-categories for a given parent ID
  List<CategoryModel> getChildren(int parentId) {
    final parent = state.categories.where((c) => c.id == parentId).firstOrNull;
    return parent?.children ?? [];
  }
}

/// Categories provider
final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, CategoriesState>((ref) {
  final api = ref.watch(apiClientProvider);
  return CategoriesNotifier(api);
});
