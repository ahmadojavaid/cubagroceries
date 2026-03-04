import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/banner_model.dart';
import '../data/featured_section_model.dart';
import '../data/holiday_model.dart';

/// Home screen state
class HomeState {
  final List<BannerModel> banners;
  final List<FeaturedSection> featuredSections;
  final HolidayModel? holiday;
  final bool isLoading;
  final String? error;
  final DateTime? lastFetchedAt;

  const HomeState({
    this.banners = const [],
    this.featuredSections = const [],
    this.holiday,
    this.isLoading = false,
    this.error,
    this.lastFetchedAt,
  });

  HomeState copyWith({
    List<BannerModel>? banners,
    List<FeaturedSection>? featuredSections,
    HolidayModel? holiday,
    bool clearHoliday = false,
    bool? isLoading,
    String? error,
    DateTime? lastFetchedAt,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      featuredSections: featuredSections ?? this.featuredSections,
      holiday: clearHoliday ? null : (holiday ?? this.holiday),
      isLoading: isLoading ?? this.isLoading,
      error: error,
      lastFetchedAt: lastFetchedAt ?? this.lastFetchedAt,
    );
  }

  bool get hasData => banners.isNotEmpty || featuredSections.isNotEmpty;
  bool get isStoreOffline => holiday != null && holiday!.isOffline;

  /// Data is stale if older than 5 minutes
  bool get isStale {
    if (lastFetchedAt == null) return true;
    return DateTime.now().difference(lastFetchedAt!).inMinutes >= 5;
  }
}

/// Home notifier — fetches combined /home data
class HomeNotifier extends StateNotifier<HomeState> {
  final ApiClient _api;

  HomeNotifier(this._api) : super(const HomeState());

  Future<void> fetchHome({bool forceRefresh = false}) async {
    if (state.hasData && !forceRefresh && !state.isStale) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _api.get('/home');
      final data = response.data;

      if (data['success'] == true) {
        final homeData = data['data'];

        final banners = (homeData['banners'] as List)
            .map((b) => BannerModel.fromJson(Map<String, dynamic>.from(b)))
            .toList();

        final sections = (homeData['featured_sections'] as List)
            .map((s) =>
                FeaturedSection.fromJson(Map<String, dynamic>.from(s)))
            .toList();

        final holiday = homeData['holiday'] != null
            ? HolidayModel.fromJson(
                Map<String, dynamic>.from(homeData['holiday']))
            : null;

        state = HomeState(
          banners: banners,
          featuredSections: sections,
          holiday: holiday,
          lastFetchedAt: DateTime.now(),
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: data['message'] ?? 'Failed to load home data',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load home data. Please try again.',
      );
    }
  }
}

/// Home provider
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final api = ref.watch(apiClientProvider);
  return HomeNotifier(api);
});
