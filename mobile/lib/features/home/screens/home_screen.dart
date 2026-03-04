import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimens.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../../categories/providers/category_provider.dart';
import '../../notifications/providers/notification_provider.dart';
import '../../profile/providers/address_provider.dart';
import '../../profile/data/address_model.dart';
import '../providers/home_provider.dart';
import '../widgets/banner_slider.dart';
import '../widgets/category_slider.dart';
import '../widgets/featured_section_widget.dart';
import '../widgets/survey_prompt_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(homeProvider.notifier).fetchHome();
      ref.read(categoriesProvider.notifier).fetchCategories();
      ref.read(notificationListProvider.notifier).fetchNotifications();
      ref.read(addressProvider.notifier).fetchAddresses();
    });
  }

  Future<void> _refresh() async {
    await Future.wait([
      ref.read(homeProvider.notifier).fetchHome(forceRefresh: true),
      ref.read(categoriesProvider.notifier).fetchCategories(forceRefresh: true),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);
    final catState = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: AppDimens.pagePadding,
        title: _buildLocationHeader(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () => context.push('/search'),
          ),
          _buildNotificationBell(context),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: _refresh,
        child: _buildBody(homeState, catState),
      ),
    );
  }

  Widget _buildLocationHeader() {
    final addrState = ref.watch(addressProvider);
    final addresses = addrState.addresses;
    final selected = addresses.where((a) => a.isDefault).firstOrNull ?? addresses.firstOrNull;

    return GestureDetector(
      onTap: addresses.isEmpty ? () => context.push('/addresses') : () => _showAddressPicker(addresses, selected),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.location_on_rounded,
            size: 22,
            color: AppColors.primary,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selected?.label ?? 'Set delivery location',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
                if (selected != null)
                  Text(
                    selected.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressPicker(List<AddressModel> addresses, AddressModel? selected) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimens.md),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Deliver to',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.push('/addresses');
                        },
                        icon: const Icon(Icons.edit_outlined, size: 16),
                        label: const Text('Manage'),
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.divider),
                ...addresses.map((addr) {
                  final isSelected = addr.id == selected?.id;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimens.pagePadding,
                      vertical: 2,
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primarySurface
                            : AppColors.surfaceBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        addr.label?.toLowerCase() == 'office'
                            ? Icons.business_rounded
                            : Icons.home_rounded,
                        size: 20,
                        color: isSelected ? AppColors.primary : AppColors.textHint,
                      ),
                    ),
                    title: Text(
                      addr.displayName,
                      style: TextStyle(
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      addr.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22)
                        : null,
                    onTap: () {
                      Navigator.pop(ctx);
                      if (!isSelected) {
                        ref.read(addressProvider.notifier).setDefault(addr.id);
                      }
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotificationBell(BuildContext context) {
    final unreadCount = ref.watch(unreadNotificationCountProvider);

    return IconButton(
      icon: unreadCount > 0
          ? Badge(
              label: Text(
                unreadCount > 99 ? '99+' : '$unreadCount',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.error,
              child: const Icon(Icons.notifications_outlined),
            )
          : const Icon(Icons.notifications_outlined),
      onPressed: () => context.push('/notifications'),
    );
  }

  Widget _buildBody(HomeState homeState, CategoriesState catState) {
    // Loading
    if (homeState.isLoading && !homeState.hasData) {
      return ListView(
        padding: const EdgeInsets.all(AppDimens.pagePadding),
        children: const [
          SizedBox(height: AppDimens.sm),
          ShimmerBox(width: double.infinity, height: 170, borderRadius: AppDimens.radiusMd),
          SizedBox(height: AppDimens.lg),
          ShimmerBox(width: 100, height: 18),
          SizedBox(height: AppDimens.sm),
          ShimmerBox(width: double.infinity, height: 100),
          SizedBox(height: AppDimens.lg),
          ShimmerBox(width: 140, height: 18),
          SizedBox(height: AppDimens.sm),
          ShimmerBox(width: double.infinity, height: 195),
        ],
      );
    }

    // Error
    if (homeState.error != null && !homeState.hasData) {
      return ErrorStateWidget(
        message: homeState.error!,
        onRetry: _refresh,
      );
    }

    // Content
    return ListView(
      children: [
        const SizedBox(height: AppDimens.sm),

        // 1. Banner slider
        if (homeState.banners.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding),
            child: BannerSlider(banners: homeState.banners),
          ),

        if (homeState.banners.isNotEmpty)
          const SizedBox(height: AppDimens.lg),

        // 2. Categories horizontal slider
        if (catState.categories.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.pagePadding),
            child: Text(
              'Categories',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: AppDimens.sm),
          CategorySlider(
            categories: catState.categories,
            onTap: (cat) {
              if (cat.hasChildren) {
                context.push('/categories/${cat.id}');
              } else {
                context.push('/categories/${cat.id}/products');
              }
            },
          ),
          const SizedBox(height: AppDimens.lg),
        ],

        // 3. Survey prompt
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
          child: SurveyPromptCard(),
        ),

        // 4. Featured category sections
        ...homeState.featuredSections.map((section) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.lg),
              child: FeaturedSectionWidget(section: section),
            )),

        // Empty state if nothing at all
        if (homeState.banners.isEmpty &&
            catState.categories.isEmpty &&
            homeState.featuredSections.isEmpty)
          const EmptyStateWidget(
            icon: Icons.storefront_outlined,
            message: 'No content available yet',
          ),

        const SizedBox(height: AppDimens.xl),
      ],
    );
  }
}
