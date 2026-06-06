import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/constants/categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/dummy_data.dart';
import '../../../core/widgets/category_chip.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../models/location_model.dart';
import '../../../services/api_service.dart';

final exploreLocationsProvider =
    FutureProvider.autoDispose<List<LocationModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final locations = await api.getLocations();
  return locations.isNotEmpty ? locations : DummyData.popularLocations;
});

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(exploreLocationsProvider);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jelajahi',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.deepForest,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Cari gunung, pantai, danau...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.tune),
                          onPressed: () {},
                        ),
                      ),
                      onSubmitted: (q) async {
                        if (q.isEmpty) return;
                        await ref.read(apiServiceProvider).searchLocations(q);
                        ref.invalidate(exploreLocationsProvider);
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 40,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: natureCategories.map((cat) {
                          final selected = _selectedCategory == cat.apiValue;
                          return CategoryChip(
                            category: cat,
                            selected: selected,
                            onTap: () {
                              setState(() {
                                _selectedCategory =
                                    selected ? null : cat.apiValue;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Text(
                  'Destinasi Populer',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ),
            locationsAsync.when(
              loading: () => const SliverFillRemaining(
                child: LoadingView(),
              ),
              error: (_, __) => SliverToBoxAdapter(
                child: _LocationList(
                  locations: DummyData.popularLocations,
                  filter: _selectedCategory,
                ),
              ),
              data: (locations) => SliverToBoxAdapter(
                child: _LocationList(
                  locations: locations,
                  filter: _selectedCategory,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                child: Text(
                  'Dekat Kamu',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final loc = DummyData.popularLocations[index % 3];
                    return _NearbyCard(location: loc);
                  },
                  childCount: 3,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: AppLayout.bottomContentPadding(context)),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationList extends StatelessWidget {
  const _LocationList({required this.locations, this.filter});

  final List<LocationModel> locations;
  final String? filter;

  @override
  Widget build(BuildContext context) {
    final filtered = filter == null
        ? locations
        : locations.where((l) => l.category == filter).toList();

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filtered.length,
        itemBuilder: (_, i) => _PopularCard(location: filtered[i]),
      ),
    );
  }
}

class _PopularCard extends StatelessWidget {
  const _PopularCard({required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/location/${location.slug}'),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: AppColors.cardShadow, blurRadius: 12),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (location.coverImageUrl != null)
                CachedNetworkImage(
                  imageUrl: location.coverImageUrl!,
                  fit: BoxFit.cover,
                ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                  ),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      location.categoryLabel,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NearbyCard extends StatelessWidget {
  const _NearbyCard({required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: () => context.push('/location/${location.slug}'),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 56,
            height: 56,
            child: location.coverImageUrl != null
                ? CachedNetworkImage(
                    imageUrl: location.coverImageUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(color: AppColors.stone),
          ),
        ),
        title: Text(location.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(location.locationLine),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
