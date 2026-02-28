import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/product_provider.dart';
import '../widgets/product_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(searchProductsProvider.notifier).reset());
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        ref.read(searchProductsProvider.notifier).search(query.trim());
      } else {
        ref.read(searchProductsProvider.notifier).reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            fillColor: Colors.transparent,
            filled: true,
          ),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          if (_controller.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_rounded, size: 20),
              onPressed: () {
                _controller.clear();
                ref.read(searchProductsProvider.notifier).reset();
                setState(() {});
              },
            ),
        ],
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, ProductsState state) {
    if (!state.isLoading &&
        state.products.isEmpty &&
        state.error == null &&
        _controller.text.isEmpty) {
      return _buildInitial(context);
    }

    if (state.isLoading) {
      return const ProductGridShimmer(itemCount: 4);
    }

    if (state.error != null && state.products.isEmpty) {
      return ErrorStateWidget(message: state.error!);
    }

    if (state.products.isEmpty) {
      return EmptyStateWidget(
        icon: Icons.search_off_rounded,
        message: 'No products found for "${_controller.text}"',
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimens.md,
        mainAxisSpacing: AppDimens.md,
        childAspectRatio: 0.68,
      ),
      itemCount: state.products.length,
      itemBuilder: (context, index) {
        final product = state.products[index];
        return ProductCard(
          product: product,
          onTap: () => context.push('/products/${product.id}'),
        );
      },
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.surfaceBg,
              shape: BoxShape.circle,
            ),
            child:
                const Icon(Icons.search_rounded, size: 36, color: AppColors.textHint),
          ),
          const SizedBox(height: AppDimens.lg),
          Text(
            'Search for products',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
