import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/category_provider.dart';

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
            icon: const Icon(Icons.search_rounded),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
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
      padding: const EdgeInsets.all(AppDimens.pagePadding),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Parent category row
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
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      // Circular image
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: AppNetworkImage(
                                imageUrl: category.image,
                                width: 52,
                                height: 52,
                                fit: BoxFit.cover,
                                errorWidget: const ImageFallback(size: 52),
                              ),
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
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            if (category.hasChildren)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  '${category.children.length} sub-categories',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColors.textHint),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: AppColors.textHint, size: 20),
                    ],
                  ),
                ),
              ),

              // Sub-categories chips
              if (category.hasChildren) ...[
                const SizedBox(height: AppDimens.sm),
                Padding(
                  padding: const EdgeInsets.only(left: 52 + AppDimens.md * 2),
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
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
