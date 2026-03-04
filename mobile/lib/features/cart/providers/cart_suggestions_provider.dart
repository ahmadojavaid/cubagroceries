import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/api_provider.dart';
import '../../products/data/product_model.dart';
import 'cart_provider.dart';

/// Fetches product suggestions based on cart item categories.
/// Auto-refreshes when cart product IDs change.
final cartSuggestionsProvider =
    FutureProvider.autoDispose<List<ProductModel>>((ref) async {
  final cart = ref.watch(cartProvider);
  if (cart.isEmpty) return [];

  // Unique product IDs in cart
  final ids = cart.items.map((e) => e.productId).toSet().toList();
  if (ids.isEmpty) return [];

  final api = ref.watch(apiClientProvider);
  try {
    final response = await api.get('/products/suggestions', queryParameters: {
      'ids': ids.join(','),
    });
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
