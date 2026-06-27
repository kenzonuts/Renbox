import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';

class HiddenGemsScreen extends StatelessWidget {
  const HiddenGemsScreen({super.key});

  static const routePath = '/main/explore/hidden-gems';

  static const _heroImage =
      'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1200&q=92';
  static const _andongImage =
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=90';
  static const _waterfallImage =
      'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=800&q=90';
  static const _lakeImage =
      'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=crop&w=800&q=90';

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          bottom: false,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  const SliverToBoxAdapter(child: _HiddenGemsHeader()),
                  const SliverToBoxAdapter(child: _CategoryChips()),
                  const SliverToBoxAdapter(child: _FeaturedSectionHeader()),
                  const SliverToBoxAdapter(child: _FeaturedStoryCard()),
                  const SliverToBoxAdapter(child: _CommunitySectionHeader()),
                  const SliverToBoxAdapter(child: _CommunityList()),
                  SliverToBoxAdapter(
                    child: SizedBox(height: bottomInset + 142),
                  ),
                ],
              ),
              Positioned(
                right: 24,
                bottom: bottomInset - 30,
                child: const _FloatingMapButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HiddenGemsHeader extends StatelessWidget {
  const _HiddenGemsHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 166,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 0,
            top: 42,
            child: SizedBox(
              width: 182,
              height: 112,
              child: CustomPaint(painter: _HeaderLandscapePainter()),
            ),
          ),
          Positioned(
            left: 16,
            top: 20,
            child: _HeaderButton(
              icon: Icons.arrow_back_rounded,
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/main/explore');
                }
              },
            ),
          ),
          Positioned(
            right: 78,
            top: 20,
            child: _HeaderButton(icon: Icons.search_rounded, onTap: () {}),
          ),
          Positioned(
            right: 16,
            top: 20,
            child: _HeaderButton(icon: Icons.tune_rounded, onTap: () {}),
          ),
          Positioned(
            left: 70,
            right: 84,
            top: 24,
            child: Text(
              'Hidden Gems',
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 30,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 24,
            top: 66,
            child: Text(
              'Temukan tempat indah yang belum\nbanyak diketahui orang.',
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF6B7280),
                fontSize: 14.5,
                height: 1.48,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            left: 70,
            right: 20,
            top: 126,
            child: Row(
              children: [
                const Icon(
                  Icons.diamond_rounded,
                  color: AppColors.forestGreen,
                  size: 17,
                ),
                const SizedBox(width: 8),
                Text(
                  '1.284 Hidden Gems',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF4B5563),
                    fontSize: 13,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '•',
                    style: TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14,
                      height: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Terus bertambah oleh komunitas',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: const Color(0xFF4B5563),
                      fontSize: 13,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
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

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.deepForest, size: 27),
      ),
    );
  }
}

class _CategoryChips extends StatelessWidget {
  const _CategoryChips();

  static const _chips = [
    _GemCategory('Semua', Icons.grid_view_rounded),
    _GemCategory('Gunung', Icons.terrain_rounded),
    _GemCategory('Air Terjun', Icons.water_drop_rounded),
    _GemCategory('Camping', Icons.change_history_rounded),
    _GemCategory('Hutan', Icons.park_rounded),
    _GemCategory('Danau', Icons.water_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
        clipBehavior: Clip.none,
        itemCount: _chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final selected = index == 0;
          final chip = _chips[index];
          return Container(
            height: 46,
            padding: EdgeInsets.symmetric(horizontal: selected ? 22 : 23),
            decoration: BoxDecoration(
              color: selected ? AppColors.forestGreen : Colors.white,
              borderRadius: BorderRadius.circular(999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x10000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  chip.icon,
                  color: selected ? Colors.white : AppColors.forestGreen,
                  size: selected ? 22 : 21,
                ),
                const SizedBox(width: 12),
                Text(
                  chip.label,
                  style: GoogleFonts.plusJakartaSans(
                    color: selected ? Colors.white : AppColors.deepForest,
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedSectionHeader extends StatelessWidget {
  const _FeaturedSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.star_rounded,
              color: Color(0xFFFFC247),
              size: 27,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cerita Pilihan',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 22,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                'Cerita paling populer minggu ini',
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 14,
                  height: 1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturedStoryCard extends StatelessWidget {
  const _FeaturedStoryCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _NetworkPhoto(url: HiddenGemsScreen._heroImage),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.04),
                    Colors.black.withValues(alpha: 0.18),
                    Colors.black.withValues(alpha: 0.84),
                  ],
                  stops: const [0, 0.45, 1],
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: 18,
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.forestGreen,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.deepForest.withValues(alpha: 0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.trending_up_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Paling Populer',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 16,
              top: 18,
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.96),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.bookmark_border_rounded,
                  color: AppColors.forestGreen,
                  size: 28,
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 22,
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
                      height: 1.02,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const _Avatar(
                          url: HiddenGemsScreen._andongImage, size: 32),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'adventure.kay',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 15,
                            height: 1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.verified_rounded,
                        color: AppColors.forestGreen,
                        size: 18,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Text(
                          '•',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      Text(
                        '2 jam lalu',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Dieng, Jawa Tengah',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 15,
                          height: 1,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StoryMetric(
                        icon: Icons.star_rounded,
                        iconColor: Color(0xFFFFC247),
                        label: '4.9',
                      ),
                      _StoryMetric(
                        icon: Icons.visibility_outlined,
                        iconColor: Colors.white,
                        label: '1.248 views',
                      ),
                      _StoryMetric(
                        icon: Icons.chat_bubble_outline_rounded,
                        iconColor: Colors.white,
                        label: '24 komentar',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryMetric extends StatelessWidget {
  const _StoryMetric({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 21),
        const SizedBox(width: 7),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 14,
            height: 1,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _CommunitySectionHeader extends StatelessWidget {
  const _CommunitySectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 30, 24, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Terbaru dari Komunitas',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.deepForest,
                fontSize: 16.5,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            'Urutkan:',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF6B7280),
              fontSize: 11.5,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Terbaru',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.forestGreen,
              fontSize: 11.5,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 7),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.forestGreen,
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _CommunityList extends StatelessWidget {
  const _CommunityList();

  @override
  Widget build(BuildContext context) {
    const items = [
      _CommunityStory(
        title: 'Kabut Pagi di Gunung Andong',
        username: 'budl.pndk',
        time: '5 jam lalu',
        location: 'Magelang, Jawa Tengah',
        description:
            'Pendakian via Sawit. Jalur cukup bersahabat untuk pemula.',
        rating: '4.8',
        comments: '18',
        image: HiddenGemsScreen._andongImage,
      ),
      _CommunityStory(
        title: 'Curug Cimahi di Musim Hujan',
        username: 'rlta.outdoor',
        time: '1 hari lalu',
        location: 'Bandung, Jawa Barat',
        description: 'Airnya deras banget! Suasana sejuk dan bikin betah.',
        rating: '4.7',
        comments: '12',
        image: HiddenGemsScreen._waterfallImage,
      ),
      _CommunityStory(
        title: 'Telaga Ngebel yang Tenang',
        username: 'jelajah.rimba',
        time: '1 hari lalu',
        location: 'Ponorogo, Jawa Timur',
        description: 'Cocok untuk healing dan camping santai bareng teman.',
        rating: '4.6',
        comments: '20',
        image: HiddenGemsScreen._lakeImage,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 18),
      itemBuilder: (context, index) => _CommunityCard(story: items[index]),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({required this.story});

  final _CommunityStory story;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 120,
              height: 120,
              child: _NetworkPhoto(url: story.image),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.cream.withValues(alpha: 0.65),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bookmark_border_rounded,
                      color: AppColors.forestGreen,
                      size: 24,
                    ),
                  ),
                ),
                Positioned.fill(
                  right: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.deepForest,
                          fontSize: 16.5,
                          height: 1.18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const _Avatar(
                            url: HiddenGemsScreen._andongImage,
                            size: 20,
                          ),
                          const SizedBox(width: 7),
                          Flexible(
                            child: Text(
                              story.username,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.deepForest,
                                fontSize: 12.5,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.verified_rounded,
                            color: AppColors.forestGreen,
                            size: 16,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Text(
                              '•',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14,
                                height: 1,
                              ),
                            ),
                          ),
                          Text(
                            story.time,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF6B7280),
                              fontSize: 12.5,
                              height: 1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Color(0xFF6B7280),
                            size: 17,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              story.location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF6B7280),
                                fontSize: 12.5,
                                height: 1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        story.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF6B7280),
                          fontSize: 13.5,
                          height: 1.27,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFFC247),
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            story.rating,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF6B7280),
                              fontSize: 13,
                              height: 1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 26),
                          const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Color(0xFF6B7280),
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            story.comments,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF6B7280),
                              fontSize: 13,
                              height: 1,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class _FloatingMapButton extends StatelessWidget {
  const _FloatingMapButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.forestGreen,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.deepForest.withValues(alpha: 0.32),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.map_outlined, color: Colors.white, size: 30),
          const SizedBox(height: 3),
          Text(
            'Lihat di Peta',
            maxLines: 1,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 9.5,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.size});

  final String url;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: _NetworkPhoto(url: url),
      ),
    );
  }
}

class _NetworkPhoto extends StatelessWidget {
  const _NetworkPhoto({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return Container(
          color: AppColors.stone.withValues(alpha: 0.42),
        );
      },
      errorBuilder: (_, __, ___) => Container(
        color: AppColors.stone.withValues(alpha: 0.72),
      ),
    );
  }
}

class _HeaderLandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final mountainPaint = Paint()
      ..color = AppColors.deepForest.withValues(alpha: 0.06)
      ..style = PaintingStyle.fill;
    final ridgePaint = Paint()
      ..color = AppColors.forestGreen.withValues(alpha: 0.09)
      ..style = PaintingStyle.fill;
    final treePaint = Paint()
      ..color = AppColors.deepForest.withValues(alpha: 0.11)
      ..style = PaintingStyle.fill;

    final far = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.20, size.height * 0.60)
      ..lineTo(size.width * 0.36, size.height * 0.74)
      ..lineTo(size.width * 0.56, size.height * 0.44)
      ..lineTo(size.width * 0.80, size.height * 0.70)
      ..lineTo(size.width, size.height * 0.50)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(far, mountainPaint);

    final near = Path()
      ..moveTo(size.width * 0.18, size.height)
      ..lineTo(size.width * 0.44, size.height * 0.56)
      ..lineTo(size.width * 0.60, size.height * 0.72)
      ..lineTo(size.width * 0.74, size.height * 0.50)
      ..lineTo(size.width, size.height * 0.82)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(near, ridgePaint);

    for (final dx in [0.77, 0.85, 0.93]) {
      final x = size.width * dx;
      final base = size.height * 0.94;
      final tree = Path()
        ..moveTo(x, base - 54)
        ..lineTo(x - 14, base - 28)
        ..lineTo(x - 7, base - 28)
        ..lineTo(x - 18, base - 7)
        ..lineTo(x + 18, base - 7)
        ..lineTo(x + 7, base - 28)
        ..lineTo(x + 14, base - 28)
        ..close();
      canvas.drawPath(tree, treePaint);
      canvas.drawRect(
        Rect.fromLTWH(x - 2, base - 10, 4, 16),
        treePaint,
      );
    }

    final birdPaint = Paint()
      ..color = AppColors.forestGreen.withValues(alpha: 0.12)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (final offset in [
      const Offset(24, 18),
      const Offset(62, 28),
      const Offset(102, 18),
    ]) {
      final wing = Path()
        ..moveTo(offset.dx - 8, offset.dy)
        ..quadraticBezierTo(offset.dx - 3, offset.dy - 5, offset.dx, offset.dy)
        ..quadraticBezierTo(
            offset.dx + 5, offset.dy - 5, offset.dx + 11, offset.dy);
      canvas.drawPath(wing, birdPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GemCategory {
  const _GemCategory(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _CommunityStory {
  const _CommunityStory({
    required this.title,
    required this.username,
    required this.time,
    required this.location,
    required this.description,
    required this.rating,
    required this.comments,
    required this.image,
  });

  final String title;
  final String username;
  final String time;
  final String location;
  final String description;
  final String rating;
  final String comments;
  final String image;
}
