import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/renbok_feature_theme.dart';
import '../models/weekend_destination.dart';
import '../widgets/weekend_recommendation_widgets.dart';

class WeekendRecommendationsListScreen extends StatefulWidget {
  const WeekendRecommendationsListScreen({super.key});

  @override
  State<WeekendRecommendationsListScreen> createState() =>
      _WeekendRecommendationsListScreenState();
}

class _WeekendRecommendationsListScreenState
    extends State<WeekendRecommendationsListScreen> {
  static const _categories = [
    _CategoryData('Semua', Icons.explore_rounded),
    _CategoryData('Gunung', Icons.terrain_rounded),
    _CategoryData('Pantai', Icons.beach_access_rounded),
    _CategoryData('Camping', Icons.cabin_rounded),
    _CategoryData('Air Terjun', Icons.water_drop_rounded),
  ];

  static const _destinations = [
    WeekendDestination(
      title: 'Gunung Prau',
      location: 'Dieng, Jawa Tengah',
      rating: '4.9',
      reviews: '1.248',
      duration: '1 Hari',
      difficulty: 'Sedang',
      budget: 'Rp150k - Rp300k',
      weather: '18°C - 26°C',
      description:
          'Cocok untuk menikmati sunrise yang spektakuler dengan jalur yang relatif singkat.',
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=800&q=85',
      imageLabel: 'Cocok untuk Sunrise',
      imageLabelIcon: Icons.landscape_rounded,
    ),
    WeekendDestination(
      title: 'Pantai Menganti',
      location: 'Kebumen, Jawa Tengah',
      rating: '4.8',
      reviews: '890',
      duration: '1 Hari',
      difficulty: 'Mudah',
      budget: 'Rp50k - Rp150k',
      weather: '24°C - 30°C',
      description:
          'Pantai dengan tebing hijau yang indah dan suasana tenang untuk relaksasi.',
      imageUrl:
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=85',
      imageLabel: 'Cocok untuk Healing',
      imageLabelIcon: Icons.eco_rounded,
    ),
    WeekendDestination(
      title: 'Curug Cimahi',
      location: 'Bandung, Jawa Barat',
      rating: '4.7',
      reviews: '760',
      duration: '1 Hari',
      difficulty: 'Mudah',
      budget: 'Rp25k - Rp75k',
      weather: '16°C - 23°C',
      description:
          'Air terjun tertinggi di Bandung dengan pemandangan yang memukau.',
      imageUrl:
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=800&q=85',
      imageLabel: 'Cocok untuk Petualangan',
      imageLabelIcon: Icons.terrain_rounded,
    ),
    WeekendDestination(
      title: 'Ranca Upas Camping Ground',
      location: 'Ciwidey, Jawa Barat',
      rating: '4.6',
      reviews: '620',
      duration: '2 Hari',
      difficulty: 'Mudah',
      budget: 'Rp100k - Rp250k',
      weather: '15°C - 22°C',
      description:
          'Camping ground populer dengan udara sejuk dan suasana alam yang tenang.',
      imageUrl:
          'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?auto=format&fit=crop&w=800&q=85',
      imageLabel: 'Cocok untuk Camping',
      imageLabelIcon: Icons.cabin_rounded,
    ),
  ];

  String _selectedCategory = 'Semua';
  final Set<String> _saved = <String>{};

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBody: true,
        backgroundColor: colors.background,
        bottomNavigationBar: const RenbokBottomNav(),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _WeekendHeader(
                  onSearchTap: _openSearchPlaceholder,
                  onFilterTap: _openFilterSheet,
                ),
              ),
              SliverToBoxAdapter(
                child: _CategoryStrip(
                  categories: _categories,
                  selectedCategory: _selectedCategory,
                  onSelected: (value) =>
                      setState(() => _selectedCategory = value),
                ),
              ),
              const SliverToBoxAdapter(child: WeekendHeroBanner()),
              SliverToBoxAdapter(
                child: SortRow(
                  onSortTap: _openSortSheet,
                  onLocationTap: _showLocationPlaceholder,
                ),
              ),
              SliverList.builder(
                itemCount: _destinations.length,
                itemBuilder: (context, index) {
                  final destination = _destinations[index];

                  return WeekendDestinationCard(
                    destination: destination,
                    saved: _saved.contains(destination.title),
                    onSaveTap: () {
                      setState(() {
                        if (_saved.contains(destination.title)) {
                          _saved.remove(destination.title);
                        } else {
                          _saved.add(destination.title);
                        }
                      });
                    },
                  );
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.paddingOf(context).bottom + 138,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSearchPlaceholder() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PlaceholderSheet(
        title: 'Cari Rekomendasi',
        subtitle: 'Pencarian destinasi akhir pekan akan tersedia di sini.',
        icon: Icons.search_rounded,
      ),
    );
  }

  void _openFilterSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PlaceholderSheet(
        title: 'Filter Destinasi',
        subtitle: 'Filter kategori, budget, durasi, dan cuaca.',
        icon: Icons.tune_rounded,
      ),
    );
  }

  void _openSortSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PlaceholderSheet(
        title: 'Urutkan Destinasi',
        subtitle: 'Pilihan sort: terdekat, rating tertinggi, dan termurah.',
        icon: Icons.keyboard_arrow_down_rounded,
      ),
    );
  }

  void _showLocationPlaceholder() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Lokasi Saya belum diaktifkan.')),
    );
  }
}

class _WeekendHeader extends StatelessWidget {
  const _WeekendHeader({
    required this.onSearchTap,
    required this.onFilterTap,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 18),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_rounded,
            semanticLabel: 'Kembali',
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/main');
              }
            },
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rekomendasi Akhir Pekan',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.textPrimary,
                    fontSize: 21,
                    height: 1.12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Destinasi terbaik untuk liburan singkatmu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.textSecondary,
                    fontSize: 13,
                    height: 1.15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          CircleIconButton(
            icon: Icons.search_rounded,
            iconSize: 32,
            semanticLabel: 'Cari',
            onTap: onSearchTap,
          ),
          const SizedBox(width: 9),
          CircleIconButton(
            icon: Icons.tune_rounded,
            semanticLabel: 'Filter',
            onTap: onFilterTap,
          ),
        ],
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
  });

  final List<_CategoryData> categories;
  final String selectedCategory;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 11),
        itemBuilder: (context, index) {
          final category = categories[index];

          return WeekendCategoryChip(
            label: category.label,
            icon: category.icon,
            selected: selectedCategory == category.label,
            onTap: () => onSelected(category.label),
          );
        },
      ),
    );
  }
}

class _PlaceholderSheet extends StatelessWidget {
  const _PlaceholderSheet({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        10,
        24,
        MediaQuery.paddingOf(context).bottom + 28,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE5E7EB),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: colors.primaryLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: colors.primary, size: 30),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: colors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: colors.textSecondary,
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryData {
  const _CategoryData(this.label, this.icon);

  final String label;
  final IconData icon;
}
