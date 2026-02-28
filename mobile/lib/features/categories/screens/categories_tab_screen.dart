import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/app_network_image.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../providers/category_provider.dart';
import '../data/category_model.dart';

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

  /// Soft background tints per category index for visual variety
  static const List<Color> _categoryTints = [
    Color(0xFFE8F5E9), // green tint
    Color(0xFFFFF8E1), // amber tint
    Color(0xFFE3F2FD), // blue tint
    Color(0xFFFCE4EC), // pink tint
    Color(0xFFF3E5F5), // purple tint
    Color(0xFFE0F7FA), // cyan tint
    Color(0xFFFFF3E0), // orange tint
    Color(0xFFE8EAF6), // indigo tint
  ];

  /// Accent colors that complement the tints
  static const List<Color> _categoryAccents = [
    Color(0xFF2E7D32), // green
    Color(0xFFF9A825), // amber
    Color(0xFF1565C0), // blue
    Color(0xFFC62828), // red/pink
    Color(0xFF6A1B9A), // purple
    Color(0xFF00838F), // cyan
    Color(0xFFE65100), // orange
    Color(0xFF283593), // indigo
  ];

  Color _tintForIndex(int index) =>
      _categoryTints[index % _categoryTints.length];

  Color _accentForIndex(int index) =>
      _categoryAccents[index % _categoryAccents.length];

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
      return const _CategoriesShimmer();
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
      padding: const EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        AppDimens.sm,
        AppDimens.pagePadding,
        AppDimens.xl,
      ),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.md + 4),
          child: _CategoryExpandedCard(
            category: category,
            tintColor: _tintForIndex(index),
            accentColor: _accentForIndex(index),
            onTap: () {
              if (category.hasChildren) {
                context.push('/categories/${category.id}');
              } else {
                context.push('/categories/${category.id}/products');
              }
            },
            onSubCategoryTap: (sub) {
              context.push(
                '/categories/${category.id}/products',
                extra: {'sub_category_id': sub.id},
              );
            },
          ),
        );
      },
    );
  }
}

/// A single category card with integrated sub-categories
class _CategoryExpandedCard extends StatelessWidget {
  final CategoryModel category;
  final Color tintColor;
  final Color accentColor;
  final VoidCallback onTap;
  final void Function(CategoryModel sub) onSubCategoryTap;

  const _CategoryExpandedCard({
    required this.category,
    required this.tintColor,
    required this.accentColor,
    required this.onTap,
    required this.onSubCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(AppDimens.radiusLg),
            border: Border.all(color: AppColors.border.withOpacity(0.5)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section: Tinted banner with image + title
              Container(
                padding: const EdgeInsets.all(AppDimens.md),
                decoration: BoxDecoration(
                  color: tintColor.withOpacity(0.45),
                ),
                child: Row(
                  children: [
                    // Category image — larger, rounded rect
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusMd),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AppNetworkImage(
                        imageUrl: category.image,
                        width: 68,
                        height: 68,
                        fit: BoxFit.cover,
                        errorWidget: _ImageFallbackColored(
                          color: accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimens.md),
                    // Title + count
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                          ),
                          if (category.hasChildren)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${category.children.length} sub-categories',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: accentColor.withOpacity(0.75),
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Arrow
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: accentColor.withOpacity(0.7),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),

              // Sub-categories section
              if (category.hasChildren)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimens.md,
                    AppDimens.sm + 2,
                    AppDimens.md,
                    AppDimens.md,
                  ),
                  child: Wrap(
                    spacing: AppDimens.sm,
                    runSpacing: AppDimens.sm,
                    children: category.children.map((sub) {
                      return _SubCategoryChip(
                        label: sub.title,
                        accentColor: accentColor,
                        onTap: () => onSubCategoryTap(sub),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Styled sub-category chip with accent color
class _SubCategoryChip extends StatelessWidget {
  final String label;
  final Color accentColor;
  final VoidCallback onTap;

  const _SubCategoryChip({
    required this.label,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: accentColor.withOpacity(0.08),
            borderRadius: BorderRadius.circular(AppDimens.radiusFull),
            border: Border.all(
              color: accentColor.withOpacity(0.18),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: accentColor.withOpacity(0.85),
              letterSpacing: 0.1,
            ),
          ),
        ),
      ),
    );
  }
}

/// Colored image fallback
class _ImageFallbackColored extends StatelessWidget {
  final Color color;

  const _ImageFallbackColored({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(0.08),
      child: Icon(
        Icons.eco_outlined,
        size: 30,
        color: color.withOpacity(0.4),
      ),
    );
  }
}

/// Custom shimmer for the categories tab
class _CategoriesShimmer extends StatelessWidget {
  const _CategoriesShimmer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.pagePadding,
        AppDimens.sm,
        AppDimens.pagePadding,
        AppDimens.xl,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.md + 4),
          child: ShimmerBox(
            width: double.infinity,
            height: 140,
            borderRadius: AppDimens.radiusLg,
          ),
        );
      },
    );
  }
}
