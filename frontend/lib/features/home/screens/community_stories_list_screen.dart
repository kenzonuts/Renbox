import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main/widgets/premium_bottom_nav.dart';
import 'community_story_detail_screen.dart';

class CommunityStoriesListScreen extends StatefulWidget {
  const CommunityStoriesListScreen({super.key});

  static const routePath = '/community-stories';

  @override
  State<CommunityStoriesListScreen> createState() =>
      _CommunityStoriesListScreenState();
}

class _CommunityStoriesListScreenState
    extends State<CommunityStoriesListScreen> {
  String _selectedCategory = 'Semua';
  bool _featuredSaved = false;
  final Set<String> _savedStoryIds = <String>{};

  static const _categories = [
    CategoryData('Semua', Icons.public_rounded),
    CategoryData('Gunung', Icons.terrain_rounded),
    CategoryData('Air Terjun', Icons.water_drop_rounded),
    CategoryData('Camping', Icons.festival_rounded),
    CategoryData('Pantai', Icons.waves_rounded),
  ];

  static const _stories = [
    StoryListData(
      id: 'andong',
      title: 'Kabut Pagi di Gunung Andong',
      author: 'budi.pndk',
      time: '5 jam lalu',
      location: 'Magelang, Jawa Tengah',
      excerpt:
          'Pendakian via Sawit. Jalur cukup landai dan cocok untuk pemula. Kabut pagi bikin suasana syahdu...',
      rating: '4.8',
      comments: 18,
      imageAlignment: Alignment(-0.05, -0.06),
      avatarAlignment: Alignment(-0.3, 0.38),
    ),
    StoryListData(
      id: 'cimahi',
      title: 'Curug Cimahi di Musim Hujan',
      author: 'rita.outdoor',
      time: '1 hari lalu',
      location: 'Bandung, Jawa Barat',
      excerpt:
          'Airnya deras banget! Suasana sejuk dan jalurnya aman. Jangan lupa bawa jas hujan ya...',
      rating: '4.7',
      comments: 12,
      imageAlignment: Alignment(-0.85, 0.12),
      avatarAlignment: Alignment(0.2, 0.34),
    ),
    StoryListData(
      id: 'menganti',
      title: 'Pantai Menganti Hidden Gem Kebumen',
      author: 'explorejawa',
      time: '2 hari lalu',
      location: 'Kebumen, Jawa Tengah',
      excerpt:
          'Pantai yang masih alami dengan tebing hijau yang keren banget. Wajib masuk bucket list!',
      rating: '4.6',
      comments: 30,
      imageAlignment: Alignment(0.95, 0.12),
      avatarAlignment: Alignment(0.36, 0.36),
    ),
    StoryListData(
      id: 'ranca-upas',
      title: 'Camping di Ranca Upas',
      author: 'alam.sejati',
      time: '3 hari lalu',
      location: 'Ciwidey, Jawa Barat',
      excerpt:
          'Udara dingin, ditemani rusa-rusa jinak di pagi hari. Pengalaman camping yang nggak terlupakan.',
      rating: '4.9',
      comments: 22,
      imageAlignment: Alignment(0.22, 0.52),
      avatarAlignment: Alignment(-0.16, 0.28),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = StoriesListColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: _Header(
                  colors: colors,
                  onBack: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/main');
                    }
                  },
                  onSearch: () => _showSearchPlaceholder(context),
                  onFilter: () => _showFilterSheet(context),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 18),
                child: SizedBox(
                  height: 56,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return CategoryChip(
                        data: category,
                        selected: category.label == _selectedCategory,
                        colors: colors,
                        onTap: () {
                          setState(() {
                            _selectedCategory = category.label;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 148),
              sliver: SliverList.list(
                children: [
                  _SectionHeading(
                    colors: colors,
                    icon: Icons.star_rounded,
                    title: 'Cerita Pilihan',
                    subtitle: 'Cerita paling populer minggu ini',
                  ),
                  const SizedBox(height: 14),
                  FeaturedStoryCard(
                    colors: colors,
                    saved: _featuredSaved,
                    onTap: () =>
                        context.push(CommunityStoryDetailScreen.routePath),
                    onSaveTap: () {
                      setState(() {
                        _featuredSaved = !_featuredSaved;
                      });
                    },
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Terbaru dari Komunitas',
                          style: GoogleFonts.plusJakartaSans(
                            color: colors.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _showSortSheet(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Urutkan:',
                                style: GoogleFonts.plusJakartaSans(
                                  color: colors.textSecondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Terbaru',
                                style: GoogleFonts.plusJakartaSans(
                                  color: colors.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: colors.primary,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < _stories.length; i++) ...[
                    StoryListCard(
                      story: _stories[i],
                      colors: colors,
                      saved: _savedStoryIds.contains(_stories[i].id),
                      onTap: () =>
                          context.push(CommunityStoryDetailScreen.routePath),
                      onSaveTap: () {
                        setState(() {
                          final id = _stories[i].id;
                          if (_savedStoryIds.contains(id)) {
                            _savedStoryIds.remove(id);
                          } else {
                            _savedStoryIds.add(id);
                          }
                        });
                      },
                    ),
                    if (i < _stories.length - 1) const SizedBox(height: 14),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const RenbokBottomNav(currentIndex: 0),
    );
  }

  void _showSearchPlaceholder(BuildContext context) {
    _showActionSheet(
      context,
      title: 'Pencarian Cerita',
      message:
          'Search screen placeholder. Nantinya bisa diarahkan ke pencarian komunitas.',
      icon: Icons.search_rounded,
    );
  }

  void _showFilterSheet(BuildContext context) {
    _showActionSheet(
      context,
      title: 'Filter Cerita',
      message:
          'Filter bottom sheet placeholder untuk kategori, lokasi, dan durasi perjalanan.',
      icon: Icons.tune_rounded,
    );
  }

  void _showSortSheet(BuildContext context) {
    _showActionSheet(
      context,
      title: 'Urutkan Cerita',
      message:
          'Sort bottom sheet placeholder: Terbaru, Terpopuler, Rating tertinggi.',
      icon: Icons.sort_rounded,
    );
  }

  void _showActionSheet(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
  }) {
    final colors = StoriesListColors.of(context);

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.surface,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: colors.primary, size: 22),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.textSecondary,
                    fontSize: 13,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
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
    required this.colors,
    required this.onBack,
    required this.onSearch,
    required this.onFilter,
  });

  final StoriesListColors colors;
  final VoidCallback onBack;
  final VoidCallback onSearch;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_rounded,
            colors: colors,
            onTap: onBack,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cerita Komunitas',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.primaryText,
                    fontSize: 23,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  'Temukan cerita inspiratif dari para petualang',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.textSecondary,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          CircleIconButton(
            icon: Icons.search_rounded,
            colors: colors,
            onTap: onSearch,
          ),
          const SizedBox(width: 8),
          CircleIconButton(
            icon: Icons.tune_rounded,
            colors: colors,
            onTap: onFilter,
          ),
        ],
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.colors,
    required this.onTap,
  });

  final IconData icon;
  final StoriesListColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface,
      shape: const CircleBorder(),
      shadowColor: Colors.black.withValues(alpha: 0.08),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, color: colors.textPrimary, size: 23),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.data,
    required this.selected,
    required this.colors,
    required this.onTap,
  });

  final CategoryData data;
  final bool selected;
  final StoriesListColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? colors.primary : colors.surface,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            boxShadow: selected
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.055),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!selected) ...[
                Icon(data.icon, color: colors.primary, size: 20),
                const SizedBox(width: 9),
              ],
              Text(
                data.label,
                style: GoogleFonts.plusJakartaSans(
                  color: selected ? Colors.white : colors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.colors,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final StoriesListColors colors;
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFFFFC247), size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  color: colors.textPrimary,
                  fontSize: 17,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: GoogleFonts.plusJakartaSans(
                  color: colors.textSecondary,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FeaturedStoryCard extends StatelessWidget {
  const FeaturedStoryCard({
    super.key,
    required this.colors,
    required this.saved,
    required this.onTap,
    required this.onSaveTap,
  });

  final StoriesListColors colors;
  final bool saved;
  final VoidCallback onTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 230,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'img/home/home.png',
                  fit: BoxFit.cover,
                  alignment: const Alignment(0.35, -0.08),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.08),
                        Colors.black.withValues(alpha: 0.18),
                        Colors.black.withValues(alpha: 0.78),
                      ],
                      stops: const [0, 0.44, 1],
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.trending_up_rounded,
                            color: Colors.white, size: 15),
                        const SizedBox(width: 7),
                        Text(
                          'Paling Populer',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 11.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: _SaveButton(
                    saved: saved,
                    colors: colors,
                    onTap: onSaveTap,
                  ),
                ),
                Positioned(
                  left: 18,
                  right: 18,
                  bottom: 18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Sunrise di Gunung Prau',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.05,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 11),
                      Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'img/home/home.png',
                              width: 28,
                              height: 28,
                              fit: BoxFit.cover,
                              alignment: const Alignment(-0.92, 0.45),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'adventure.kay',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.verified_rounded,
                              color: colors.primary, size: 15),
                          const SizedBox(width: 8),
                          Text(
                            '•  2 jam lalu',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          const Icon(Icons.location_on_rounded,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Dieng, Jawa Tengah',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Row(
                        children: [
                          StoryStatItem(
                            icon: Icons.star_rounded,
                            label: '4.9',
                            bright: true,
                          ),
                          SizedBox(width: 22),
                          StoryStatItem(
                            icon: Icons.visibility_outlined,
                            label: '1.248 views',
                            bright: true,
                          ),
                          SizedBox(width: 22),
                          StoryStatItem(
                            icon: Icons.chat_bubble_outline_rounded,
                            label: '24 komentar',
                            bright: true,
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
      ),
    );
  }
}

class StoryListCard extends StatelessWidget {
  const StoryListCard({
    super.key,
    required this.story,
    required this.colors,
    required this.saved,
    required this.onTap,
    required this.onSaveTap,
  });

  final StoryListData story;
  final StoriesListColors colors;
  final bool saved;
  final VoidCallback onTap;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(24),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          height: 156,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.055),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'img/home/home.png',
                  width: 116,
                  height: 136,
                  fit: BoxFit.cover,
                  alignment: story.imageAlignment,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            story.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: colors.textPrimary,
                              fontSize: 14.5,
                              height: 1.2,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        _SaveButton(
                          saved: saved,
                          colors: colors,
                          compact: true,
                          onTap: onSaveTap,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'img/home/home.png',
                            width: 26,
                            height: 26,
                            fit: BoxFit.cover,
                            alignment: story.avatarAlignment,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Flexible(
                          child: Text(
                            story.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: colors.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.verified_rounded,
                            color: colors.primary, size: 14),
                        const SizedBox(width: 5),
                        Text(
                          '• ${story.time}',
                          style: GoogleFonts.plusJakartaSans(
                            color: colors.textSecondary,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on_rounded,
                            color: colors.textSecondary, size: 13),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            story.location,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: colors.textSecondary,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        story.excerpt,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: colors.textSecondary,
                          fontSize: 11.5,
                          height: 1.38,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        StoryStatItem(
                          icon: Icons.star_rounded,
                          label: story.rating,
                          colors: colors,
                        ),
                        const SizedBox(width: 18),
                        StoryStatItem(
                          icon: Icons.chat_bubble_outline_rounded,
                          label: '${story.comments}',
                          colors: colors,
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

class StoryStatItem extends StatelessWidget {
  const StoryStatItem({
    super.key,
    required this.icon,
    required this.label,
    this.colors,
    this.bright = false,
  });

  final IconData icon;
  final String label;
  final StoriesListColors? colors;
  final bool bright;

  @override
  Widget build(BuildContext context) {
    final colorSet = colors ?? StoriesListColors.of(context);
    final iconColor = icon == Icons.star_rounded
        ? const Color(0xFFFFC247)
        : bright
            ? Colors.white
            : colorSet.textSecondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 17),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: bright ? Colors.white : colorSet.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.saved,
    required this.colors,
    required this.onTap,
    this.compact = false,
  });

  final bool saved;
  final StoriesListColors colors;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: compact
          ? colors.background.withValues(alpha: 0.95)
          : Colors.white.withValues(alpha: 0.95),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: compact ? 38 : 42,
          height: compact ? 38 : 42,
          child: Icon(
            saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            color: colors.primary,
            size: compact ? 21 : 23,
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
    const routes = [
      '/main',
      '/main/explore',
      '/main/create',
      '/main/activity',
      '/main/profile',
    ];

    return PremiumBottomNav(
      currentIndex: currentIndex,
      onTap: (index) => context.go(routes[index]),
    );
  }
}

class StoriesListColors {
  const StoriesListColors({
    required this.background,
    required this.surface,
    required this.primary,
    required this.primaryText,
    required this.textPrimary,
    required this.textSecondary,
  });

  final Color background;
  final Color surface;
  final Color primary;
  final Color primaryText;
  final Color textPrimary;
  final Color textSecondary;

  factory StoriesListColors.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return const StoriesListColors(
        background: Color(0xFF07130F),
        surface: Color(0xFF101F19),
        primary: Color(0xFF5BD6B0),
        primaryText: Color(0xFFF3F7F4),
        textPrimary: Color(0xFFF3F7F4),
        textSecondary: Color(0xFFBAC5BF),
      );
    }

    return const StoriesListColors(
      background: Color(0xFFF8F5F0),
      surface: Colors.white,
      primary: Color(0xFF006B4F),
      primaryText: Color(0xFF12372A),
      textPrimary: Color(0xFF12372A),
      textSecondary: Color(0xFF6B7280),
    );
  }
}

class CategoryData {
  const CategoryData(this.label, this.icon);

  final String label;
  final IconData icon;
}

class StoryListData {
  const StoryListData({
    required this.id,
    required this.title,
    required this.author,
    required this.time,
    required this.location,
    required this.excerpt,
    required this.rating,
    required this.comments,
    required this.imageAlignment,
    required this.avatarAlignment,
  });

  final String id;
  final String title;
  final String author;
  final String time;
  final String location;
  final String excerpt;
  final String rating;
  final int comments;
  final Alignment imageAlignment;
  final Alignment avatarAlignment;
}
