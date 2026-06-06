import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/dummy_data.dart';
import '../../../models/location_model.dart';
import '../../../models/post_model.dart';
import '../../../services/api_service.dart';

class HomeState {
  const HomeState({
    this.featured,
    this.featuredList = const [],
    this.posts = const [],
    this.isLoading = true,
    this.useFallback = false,
    this.selectedCategory = 'mountain',
  });

  final LocationModel? featured;
  final List<LocationModel> featuredList;
  final List<PostModel> posts;
  final bool isLoading;
  final bool useFallback;
  final String? selectedCategory;

  HomeState copyWith({
    LocationModel? featured,
    List<LocationModel>? featuredList,
    List<PostModel>? posts,
    bool? isLoading,
    bool? useFallback,
    String? selectedCategory,
  }) {
    return HomeState(
      featured: featured ?? this.featured,
      featuredList: featuredList ?? this.featuredList,
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      useFallback: useFallback ?? this.useFallback,
      selectedCategory: selectedCategory,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier(this._api) : super(const HomeState()) {
    load();
  }

  final ApiService _api;

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    final featured = await _api.getFeaturedLocation();
    final posts = await _api.getFeed();

    if (featured == null && posts.isEmpty) {
      state = HomeState(
        featured: DummyData.featuredLocation,
        featuredList: DummyData.featuredLocations,
        posts: DummyData.feedPosts,
        isLoading: false,
        useFallback: true,
      );
    } else {
      final featuredLoc = featured ?? DummyData.featuredLocation;
      state = HomeState(
        featured: featuredLoc,
        featuredList: featured != null
            ? [featuredLoc, ...DummyData.featuredLocations.skip(1)]
            : DummyData.featuredLocations,
        posts: posts.isNotEmpty ? posts : DummyData.feedPosts,
        isLoading: false,
        useFallback: featured == null || posts.isEmpty,
      );
    }
  }

  void selectCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  Future<void> refresh() => load();
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref.watch(apiServiceProvider));
});
