import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/constants/categories.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/dummy_data.dart';
import '../../../core/widgets/category_chip.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../core/widgets/renbok_logo.dart';
import '../../../models/location_model.dart';
import '../../../services/api_service.dart';
import '../widgets/explore_destination_card.dart';
import '../widgets/explore_popular_carousel.dart';

final exploreLocationsProvider =
    FutureProvider.autoDispose<List<LocationModel>>((ref) async {
  final api = ref.watch(apiServiceProvider);
  final locations = await api.getLocations();
  return locations.isNotEmpty ? locations : DummyData.otherDestinations;
});

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _searchController = TextEditingController();
  String? _selectedCategory = 'mountain';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LocationModel> _filter(List<LocationModel> list) {
    if (_selectedCategory == null || _selectedCategory == 'hidden') {
      return list;
    }
    return list.where((l) => l.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(exploreLocationsProvider);
    final weekly = DummyData.weeklyPopular;
    final others = locationsAsync.maybeWhen(
      data: (l) => l.isNotEmpty ? l : DummyData.otherDestinations,
      orElse: () => DummyData.otherDestinations,
    );
    final filteredOthers = _filter(others);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Row(
                  children: [
                    const RenbokLogo(size: 20),
                    const Spacer(),
                    _IconButton(
                      icon: Icons.search_rounded,
                      onTap: () {},
                    ),
                    const SizedBox(width: 8),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _IconButton(
                          icon: Icons.notifications_outlined,
                          onTap: () => context.go('/main/activity'),
                        ),
                        Positioned(
                          right: 9,
                          top: 9,
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.notificationDot,
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(
                                BorderSide(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AppColors.deepForest,
                          height: 1.15,
                        ),
                        children: const [
                          TextSpan(text: 'Explore '),
                          TextSpan(
                            text: 'Alam 🌿',
                            style: TextStyle(color: AppColors.forestGreen),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Temukan destinasi alam terbaik untuk petualangan berikutnya.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5,
                        color: AppColors.textSecondary,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Material(
                    color: Colors.white,
                    elevation: 0,
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Cari gunung, air terjun...',
                        hintStyle: GoogleFonts.plusJakartaSans(
                          color: AppColors.textMuted,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          color: AppColors.deepForest.withValues(alpha: 0.65),
                          size: 22,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.tune_rounded,
                            color: AppColors.deepForest.withValues(alpha: 0.8),
                            size: 21,
                          ),
                          onPressed: () {},
                          splashRadius: 22,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.stone.withValues(alpha: 0.55),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: AppColors.stone.withValues(alpha: 0.55),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: AppColors.forestGreen,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onSubmitted: (q) async {
                        if (q.isEmpty) return;
                        await ref.read(apiServiceProvider).searchLocations(q);
                        ref.invalidate(exploreLocationsProvider);
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  clipBehavior: Clip.none,
                  itemCount: exploreCategories.length,
                  itemBuilder: (context, index) {
                    final cat = exploreCategories[index];
                    final selected = _selectedCategory == cat.apiValue;
                    return CategoryChip(
                      category: cat,
                      selected: selected,
                      onTap: () {
                        setState(() {
                          _selectedCategory = selected ? null : cat.apiValue;
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 14),
                child: _SectionHeader(
                  title: 'Populer Minggu Ini',
                  onSeeAll: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: locationsAsync.when(
                loading: () => const SizedBox(
                  height: 220,
                  child: LoadingView(message: 'Memuat destinasi...'),
                ),
                error: (_, __) => ExplorePopularCarousel(locations: weekly),
                data: (_) => ExplorePopularCarousel(locations: weekly),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
                child: _SectionHeader(
                  title: 'Destinasi Lainnya',
                  onSeeAll: () {},
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: locationsAsync.when(
                loading: () => const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: LoadingView(),
                  ),
                ),
                error: (_, __) => _OtherDestinationsGrid(
                  locations: filteredOthers,
                ),
                data: (_) => _OtherDestinationsGrid(
                  locations: filteredOthers,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: AppLayout.bottomContentPadding(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.onSeeAll});

  final String title;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.deepForest,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Lihat semua',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.forestGreen,
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 18,
                color: AppColors.forestGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OtherDestinationsGrid extends StatelessWidget {
  const _OtherDestinationsGrid({required this.locations});

  final List<LocationModel> locations;

  @override
  Widget build(BuildContext context) {
    if (locations.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Center(
            child: Text(
              'Belum ada destinasi',
              style: GoogleFonts.plusJakartaSans(color: AppColors.textMuted),
            ),
          ),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        childAspectRatio: 0.58,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => ExploreDestinationCard(location: locations[index]),
        childCount: locations.length,
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.deepForest.withValues(alpha: 0.14),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, color: AppColors.deepForest, size: 19),
        ),
      ),
    );
  }
}
