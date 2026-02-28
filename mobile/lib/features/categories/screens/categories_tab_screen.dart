import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/category_provider.dart';

/// Full-screen categories tab: shows all top-level categories with their
/// sub-categories in an expandable list. Tapping navigates to products.
class CategoriesTabScreen extends ConsumerStatefulWidget {
  const CategoriesTabScreen({super.key});

  @override
  ConsumerState<CategoriesTabScreen> createState() =>
      _CategoriesTabScreenState();
}

class _CategoriesTabScreenState extends ConsumerState<CategoriesTabScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(categoriesProvider.notifier).fetchCategories(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(categoriesProvider.notifier)
            .fetchCategories(forceRefresh: true),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(CategoriesState state) {
    if (state.isLoading) {
      return const CategoryGridShimmer(itemCount: 8);
    }

    if (state.error != null) {
      return ErrorStateWidget(
        message: state.error!,
        onRetry: () => ref
            .read(categoriesProvider.notifier)
            .fetchCategories(forceRefresh: true),
      );
    }

    if (state.categories.isEmpty) {
      return const EmptyStateWidget(
        icon: Icons.category_outlined,
        message: 'No categories available',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimens.md),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Parent category header
            InkWell(
              onTap: () {
                if (category.hasChildren) {
                  context.push('/categories/${category.id}');
                } else {
                  context.push('/categories/${category.id}/products');
                }
              },
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              child: Container(
                padding: const EdgeInsets.all(AppDimens.md),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppDimens.radiusSm),
                      child: category.image != null
                          ? CachedNetworkImage(
                              imageUrl: category.image!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) =>
                                  const ImageFallback(size: 48),
                            )
                          : const ImageFallback(size: 48),
                    ),
                    const SizedBox(width: AppDimens.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          if (category.hasChildren)
                            Text(
                              '${category.children.length} sub-categories',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.textSecondary),
                            ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        color: AppColors.textHint),
                  ],
                ),
              ),
            ),

            // Sub-categories chips
            if (category.hasChildren) ...[
              const SizedBox(height: AppDimens.sm),
              Padding(
                padding:
                    const EdgeInsets.only(left: AppDimens.md + 48 + AppDimens.md),
                child: Wrap(
                  spacing: AppDimens.sm,
                  runSpacing: AppDimens.xs,
                  children: category.children.map((sub) {
                    return ActionChip(
                      label: Text(sub.title),
                      onPressed: () => context.push(
                        '/categories/${category.id}/products',
                        extra: {'sub_category_id': sub.id},
                      ),
                      backgroundColor: AppColors.primarySurface,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.primaryDark),
                    );
                  }).toList(),
                ),
              ),
            ],

            const SizedBox(height: AppDimens.md),
          ],
        );
      },
    );
  }
}
