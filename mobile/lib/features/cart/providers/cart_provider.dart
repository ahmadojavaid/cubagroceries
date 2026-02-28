import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/cart_item_model.dart';

/// Cart state holding all cart items
class CartState {
  final List<CartItemModel> items;

  const CartState({this.items = const []});

  /// Total number of unique items in cart
  int get itemCount => items.length;

  /// Total quantity across all items
  int get totalQuantity =>
      items.fold(0, (sum, item) => sum + item.quantity);

  /// Subtotal (sum of all line totals)
  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.lineTotal);

  /// Formatted subtotal
  String get displaySubtotal => 'Rs ${subtotal.toStringAsFixed(2)}';

  /// Whether cart is empty
  bool get isEmpty => items.isEmpty;

  CartState copyWith({List<CartItemModel>? items}) {
    return CartState(items: items ?? this.items);
  }
}

/// Cart notifier — manages cart items with Hive persistence
class CartNotifier extends StateNotifier<CartState> {
  static const String _boxName = 'cart';
  static const String _cartKey = 'cart_items';
  Box? _box;

  CartNotifier() : super(const CartState()) {
    _init();
  }

  /// Initialize Hive box and load saved cart
  Future<void> _init() async {
    _box = await Hive.openBox(_boxName);
    _loadFromHive();
  }

  /// Load cart items from Hive
  void _loadFromHive() {
    final raw = _box?.get(_cartKey);
    if (raw != null) {
      try {
        final List<dynamic> decoded = jsonDecode(raw as String);
        final items = decoded
            .map((e) => CartItemModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();
        state = CartState(items: items);
      } catch (_) {
        // Corrupted data — start fresh
        _box?.delete(_cartKey);
      }
    }
  }

  /// Persist cart items to Hive
  Future<void> _saveToHive() async {
    final encoded = jsonEncode(state.items.map((e) => e.toJson()).toList());
    await _box?.put(_cartKey, encoded);
  }

  /// Add item to cart (or increment quantity if same product+unit exists)
  void addItem(CartItemModel item) {
    final items = [...state.items];
    final index = items.indexWhere((e) => e.cartKey == item.cartKey);

    if (index >= 0) {
      items[index] = items[index].copyWith(
        quantity: items[index].quantity + item.quantity,
      );
    } else {
      items.add(item);
    }

    state = state.copyWith(items: items);
    _saveToHive();
  }

  /// Remove item from cart by cartKey
  void removeItem(String cartKey) {
    final items = state.items.where((e) => e.cartKey != cartKey).toList();
    state = state.copyWith(items: items);
    _saveToHive();
  }

  /// Update quantity of a specific item
  void updateQuantity(String cartKey, int quantity) {
    if (quantity <= 0) {
      removeItem(cartKey);
      return;
    }

    final items = state.items.map((e) {
      if (e.cartKey == cartKey) {
        return e.copyWith(quantity: quantity);
      }
      return e;
    }).toList();

    state = state.copyWith(items: items);
    _saveToHive();
  }

  /// Increment quantity by 1
  void incrementQuantity(String cartKey) {
    final item = state.items.firstWhere(
      (e) => e.cartKey == cartKey,
      orElse: () => throw StateError('Item not found'),
    );
    updateQuantity(cartKey, item.quantity + 1);
  }

  /// Decrement quantity by 1 (removes if reaches 0)
  void decrementQuantity(String cartKey) {
    final item = state.items.firstWhere(
      (e) => e.cartKey == cartKey,
      orElse: () => throw StateError('Item not found'),
    );
    updateQuantity(cartKey, item.quantity - 1);
  }

  /// Clear all items from cart
  void clearCart() {
    state = const CartState();
    _saveToHive();
  }

  /// Check if a product+unit combination is in cart
  bool isInCart(int productId, int unitId) {
    final key = '${productId}_$unitId';
    return state.items.any((e) => e.cartKey == key);
  }

  /// Get quantity of a specific product+unit in cart
  int getQuantity(int productId, int unitId) {
    final key = '${productId}_$unitId';
    final item = state.items.where((e) => e.cartKey == key).firstOrNull;
    return item?.quantity ?? 0;
  }
}

/// Cart provider
final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});
