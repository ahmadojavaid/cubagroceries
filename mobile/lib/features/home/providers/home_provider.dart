import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/api/api_client.dart';
import '../../../core/providers/api_provider.dart';
import '../data/banner_model.dart';
import '../data/featured_section_model.dart';

/// Home screen state
class HomeState {
  final List<BannerModel> banners;
  final List<FeaturedSection> featuredSections;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.banners = const [],
    this.featuredSections = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<BannerModel>? banners,
    List<FeaturedSection>? featuredSections,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      featuredSections: featuredSections ?? this.featuredSections,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  bool get hasData => banners.isNotEmpty || featuredSections.isNotEmpty;
}

/// Home notifier — fetches combined /home data
class HomeNotifier extends StateNotifier<HomeState> {
  final ApiClient _api;

  HomeNotifier(this._api) : super(const HomeState());

  Future<void> fetchHome({bool forceRefresh = false}) async {
    if (state.hasData && !forceRefresh) return;

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

        state = HomeState(
          banners: banners,
          featuredSections: sections,
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
