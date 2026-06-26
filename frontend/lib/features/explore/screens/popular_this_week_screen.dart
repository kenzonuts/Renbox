import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../main/widgets/premium_bottom_nav.dart';

class PopularThisWeekScreen extends StatefulWidget {
  const PopularThisWeekScreen({super.key});

  static const routePath = '/popular-this-week';

  @override
  State<PopularThisWeekScreen> createState() => _PopularThisWeekScreenState();
}

class _PopularThisWeekScreenState extends State<PopularThisWeekScreen> {
  final Set<String> _saved = {};
  String _selectedCategory = 'Semua';
  String _sort = 'Paling Populer';

  static const _categories = [
    _PopularCategory('Semua', Icons.grid_view_rounded),
    _PopularCategory('Gunung', Icons.terrain_rounded),
    _PopularCategory('Air Terjun', Icons.waterfall_chart_rounded),
    _PopularCategory('Pantai', Icons.waves_rounded),
    _PopularCategory('Camping', Icons.change_history_rounded),
  ];

  static const _destinations = [
    TrendingDestinationData(
      rank: 1,
      title: 'Gunung Rinjani',
      slug: 'gunung-rinjani',
      location: 'Lombok, NTB',
      rating: '4.9',
      reviews: '1.234 ulasan',
      explorers: '128 explorer minggu ini',
      saved: '3.2K disimpan',
      viewed: '15.4K dilihat',
      shared: '2.1K dibagikan',
      weather: '18°C - 26°C',
      weatherLabel: 'Cerah Berawan',
      difficulty: 'Sulit',
      difficultyLabel: 'Level Pendakian',
      imageBadge: 'Paling Ramai',
      imageBadgeIcon: Icons.local_fire_department_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=900&q=88',
    ),
    TrendingDestinationData(
      rank: 2,
      title: 'Curug Lawe',
      slug: 'curug-lawe',
      location: 'Semarang, Jawa Tengah',
      rating: '4.8',
      reviews: '896 ulasan',
      explorers: '96 explorer minggu ini',
      saved: '2.1K disimpan',
      viewed: '8.7K dilihat',
      shared: '1.3K dibagikan',
      weather: '21°C - 28°C',
      weatherLabel: 'Cerah',
      difficulty: 'Mudah',
      difficultyLabel: 'Level Pendakian',
      imageBadge: 'Air Terjun Favorit',
      imageBadgeIcon: Icons.water_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=900&q=88',
    ),
    TrendingDestinationData(
      rank: 3,
      title: 'Pantai Kelingking',
      slug: 'pantai-kelingking',
      location: 'Nusa Penida, Bali',
      rating: '4.8',
      reviews: '756 ulasan',
      explorers: '85 explorer minggu ini',
      saved: '1.8K disimpan',
      viewed: '7.6K dilihat',
      shared: '1.1K dibagikan',
      weather: '24°C - 30°C',
      weatherLabel: 'Cerah',
      difficulty: 'Mudah',
      difficultyLabel: 'Level Aktivitas',
      imageBadge: 'Pantai Favorit',
      imageBadgeIcon: Icons.beach_access_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?auto=format&fit=crop&w=900&q=88',
    ),
    TrendingDestinationData(
      rank: 4,
      title: 'Ranca Upas Camping Ground',
      slug: 'ranca-upas-camping-ground',
      location: 'Ciwidey, Jawa Barat',
      rating: '4.7',
      reviews: '642 ulasan',
      explorers: '74 explorer minggu ini',
      saved: '1.5K disimpan',
      viewed: '6.1K dilihat',
      shared: '890 dibagikan',
      weather: '15°C - 22°C',
      weatherLabel: 'Cerah Berawan',
      difficulty: 'Mudah',
      difficultyLabel: 'Level Aktivitas',
      imageBadge: 'Camping Populer',
      imageBadgeIcon: Icons.change_history_rounded,
      imageUrl:
          'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?auto=format&fit=crop&w=900&q=88',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 130;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F5F0),
        bottomNavigationBar: const RenbokBottomNav(currentIndex: 1),
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _Header(
                  onSearchTap: _showSearchSheet,
                  onFilterTap: _showFilterSheet,
                ),
              ),
              const SliverToBoxAdapter(child: PopularHeroBanner()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 58,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return CategoryChip(
                        label: category.label,
                        icon: category.icon,
                        selected: category.label == _selectedCategory,
                        onTap: () {
                          setState(() => _selectedCategory = category.label);
                        },
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SortRow(
                  sort: _sort,
                  onSortTap: _showSortSheet,
                  onPeriodTap: _showPeriodSheet,
                ),
              ),
              SliverList.separated(
                itemCount: _destinations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final destination = _destinations[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      index == 0 ? 4 : 0,
                      16,
                      index == _destinations.length - 1 ? bottomPadding : 0,
                    ),
                    child: TrendingDestinationCard(
                      data: destination,
                      saved: _saved.contains(destination.slug),
                      onSaveTap: () => _toggleSaved(destination.slug),
                      onGuideTap: () =>
                          context.push('/location/${destination.slug}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleSaved(String slug) {
    setState(() {
      if (!_saved.add(slug)) {
        _saved.remove(slug);
      }
    });
  }

  void _showSearchSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: TextField(
            autofocus: true,
            cursorColor: const Color(0xFF006B4F),
            decoration: InputDecoration(
              hintText: 'Cari destinasi populer...',
              prefixIcon: const Icon(Icons.search_rounded),
              filled: true,
              fillColor: const Color(0xFFF8F5F0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterSheet() {
    _showInfoSheet(
      title: 'Filter Populer',
      message:
          'Filter kategori, rating, dan statistik popularitas akan tersedia di versi berikutnya.',
    );
  }

  void _showPeriodSheet() {
    _showInfoSheet(
      title: 'Periode',
      message: 'Saat ini daftar menampilkan tren untuk minggu ini.',
    );
  }

  void _showSortSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        const options = ['Paling Populer', 'Paling Banyak Disimpan', 'Rating'];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Urutkan',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                for (final option in options)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      option,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF12372A),
                        fontWeight:
                            _sort == option ? FontWeight.w800 : FontWeight.w600,
                      ),
                    ),
                    trailing: _sort == option
                        ? const Icon(Icons.check_rounded,
                            color: Color(0xFF006B4F))
                        : null,
                    onTap: () {
                      setState(() => _sort = option);
                      context.pop();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showInfoSheet({required String title, required String message}) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.onSearchTap,
    required this.onFilterTap,
  });

  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/main/explore');
              }
            },
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Populer Minggu Ini',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Destinasi paling ramai dan banyak disukai minggu ini',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleIconButton(icon: Icons.search_rounded, onTap: onSearchTap),
          const SizedBox(width: 9),
          CircleIconButton(icon: Icons.tune_rounded, onTap: onFilterTap),
        ],
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({super.key, required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: const Color(0xFF12372A), size: 25),
        ),
      ),
    );
  }
}

class PopularHeroBanner extends StatelessWidget {
  const PopularHeroBanner({super.key});

  static const _imageUrl =
      'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=88';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 230,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: _imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(color: AppColors.stone),
                errorWidget: (_, __, ___) => Container(color: AppColors.stone),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.82),
                      Colors.black.withValues(alpha: 0.42),
                      Colors.black.withValues(alpha: 0.06),
                    ],
                    stops: const [0, 0.52, 1],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_fire_department_rounded,
                            color: AppColors.starGold, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Trending di Indonesia',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'Destinasi Favorit\nMinggu Ini',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                        height: 1.13,
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: 220,
                      child: Text(
                        'Temukan tempat paling populer\ndan banyak dikunjungi minggu ini.',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white.withValues(alpha: 0.92),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          height: 1.45,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        const _AvatarStack(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '12K+ explorer',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              'menjelajah minggu ini',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white.withValues(alpha: 0.88),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  @override
  Widget build(BuildContext context) {
    const urls = [
      'https://i.pravatar.cc/80?img=11',
      'https://i.pravatar.cc/80?img=32',
      'https://i.pravatar.cc/80?img=48',
    ];

    return SizedBox(
      width: 54,
      height: 28,
      child: Stack(
        children: [
          for (var i = 0; i < urls.length; i++)
            Positioned(
              left: i * 16,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(urls[i]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF006B4F) : Colors.white,
      borderRadius: BorderRadius.circular(26),
      elevation: 7,
      shadowColor: Colors.black.withValues(alpha: 0.08),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : const Color(0xFF006B4F),
                size: 21,
              ),
              const SizedBox(width: 9),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: selected ? Colors.white : const Color(0xFF12372A),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SortRow extends StatelessWidget {
  const SortRow({
    super.key,
    required this.sort,
    required this.onSortTap,
    required this.onPeriodTap,
  });

  final String sort;
  final VoidCallback onSortTap;
  final VoidCallback onPeriodTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          Text(
            'Urutkan:',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF7A8494),
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 12),
          _PillButton(
            label: sort,
            trailing: Icons.keyboard_arrow_down_rounded,
            onTap: onSortTap,
          ),
          const Spacer(),
          _PillButton(
            label: 'Periode: Minggu Ini',
            leading: Icons.calendar_month_rounded,
            onTap: onPeriodTap,
          ),
        ],
      ),
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.onTap,
    this.leading,
    this.trailing,
  });

  final String label;
  final VoidCallback onTap;
  final IconData? leading;
  final IconData? trailing;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.07),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                Icon(leading, color: const Color(0xFF006B4F), size: 20),
                const SizedBox(width: 7),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF12372A),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 7),
                Icon(trailing, color: const Color(0xFF12372A), size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class TrendingDestinationCard extends StatelessWidget {
  const TrendingDestinationCard({
    super.key,
    required this.data,
    required this.saved,
    required this.onSaveTap,
    required this.onGuideTap,
  });

  final TrendingDestinationData data;
  final bool saved;
  final VoidCallback onSaveTap;
  final VoidCallback onGuideTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.055),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TrendingImage(data: data),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 155,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF12372A),
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            height: 1.12,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onSaveTap,
                        child: Icon(
                          saved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: const Color(0xFF006B4F),
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  _IconText(
                    icon: Icons.location_on_outlined,
                    text: data.location,
                    iconColor: const Color(0xFF12372A),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.starGold, size: 17),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${data.rating} (${data.reviews})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _smallMetaStyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: PopularityStatItem(
                          icon: Icons.groups_rounded,
                          label: data.explorers,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: PopularityStatItem(
                          icon: Icons.bookmark_border_rounded,
                          label: data.saved,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: InfoChip(
                          icon: Icons.cloud_queue_rounded,
                          title: data.weather,
                          subtitle: data.weatherLabel,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: InfoChip(
                          icon: Icons.terrain_rounded,
                          title: data.difficulty,
                          subtitle: data.difficultyLabel,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _GuideButton(onTap: onGuideTap),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _smallMetaStyle => GoogleFonts.plusJakartaSans(
        color: const Color(0xFF6B7280),
        fontSize: 10.5,
        fontWeight: FontWeight.w800,
      );
}

class _IconText extends StatelessWidget {
  const _IconText({
    required this.icon,
    required this.text,
    required this.iconColor,
  });

  final IconData icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 13),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF6B7280),
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _TrendingImage extends StatelessWidget {
  const _TrendingImage({required this.data});

  final TrendingDestinationData data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: 150,
        height: 155,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: data.imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.stone),
              errorWidget: (_, __, ___) => Container(color: AppColors.stone),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.06),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.58),
                  ],
                  stops: const [0, 0.48, 1],
                ),
              ),
            ),
            Positioned(left: 0, top: 0, child: RankBadge(rank: data.rank)),
            Positioned(
              left: 10,
              bottom: 10,
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.56),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(data.imageBadgeIcon,
                        color: AppColors.starGold, size: 14),
                    const SizedBox(width: 5),
                    Text(
                      data.imageBadge,
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RankBadge extends StatelessWidget {
  const RankBadge({super.key, required this.rank});

  final int rank;

  Color get _color {
    switch (rank) {
      case 1:
        return const Color(0xFFFFC21A);
      case 2:
        return const Color(0xFF8A95A8);
      case 3:
        return const Color(0xFFE99B14);
      default:
        return const Color(0xFF006B4F);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(26),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, top: 9),
      child: Text(
        '#$rank',
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class PopularityStatItem extends StatelessWidget {
  const PopularityStatItem({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF006B4F), size: 14),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF6B7280),
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF006B4F), size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF12372A),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuideButton extends StatelessWidget {
  const _GuideButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF006B4F),
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(21),
        child: SizedBox(
          height: 40,
          width: 138,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lihat Panduan',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 17),
            ],
          ),
        ),
      ),
    );
  }
}

class RenbokBottomNav extends StatelessWidget {
  const RenbokBottomNav({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return PremiumBottomNav(
      currentIndex: currentIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/main');
          case 1:
            context.go('/main/explore');
          case 2:
            context.go('/main/create');
          case 3:
            context.go('/main/activity');
          case 4:
            context.go('/main/profile');
        }
      },
    );
  }
}

class TrendingDestinationData {
  const TrendingDestinationData({
    required this.rank,
    required this.title,
    required this.slug,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.explorers,
    required this.saved,
    required this.viewed,
    required this.shared,
    required this.weather,
    required this.weatherLabel,
    required this.difficulty,
    required this.difficultyLabel,
    required this.imageBadge,
    required this.imageBadgeIcon,
    required this.imageUrl,
  });

  final int rank;
  final String title;
  final String slug;
  final String location;
  final String rating;
  final String reviews;
  final String explorers;
  final String saved;
  final String viewed;
  final String shared;
  final String weather;
  final String weatherLabel;
  final String difficulty;
  final String difficultyLabel;
  final String imageBadge;
  final IconData imageBadgeIcon;
  final String imageUrl;
}

class _PopularCategory {
  const _PopularCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}
