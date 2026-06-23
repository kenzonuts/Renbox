import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/renbok_logo.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  static const _heroImage =
      'https://images.unsplash.com/photo-1501785888041-af3ef285b470?auto=format&fit=crop&w=1200&q=85';
  static const _prauImage =
      'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=800&q=85';
  static const _andongImage =
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=85';
  static const _merbabuImage =
      'https://images.unsplash.com/photo-1470770903676-69b98201ea1c?auto=format&fit=crop&w=800&q=85';
  static const _waterfallOne =
      'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=800&q=85';
  static const _waterfallTwo =
      'https://images.unsplash.com/photo-1508459855340-fb63ac591728?auto=format&fit=crop&w=800&q=85';
  static const _waterfallThree =
      'https://images.unsplash.com/photo-1546882588-d9bd63f85a91?auto=format&fit=crop&w=800&q=85';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: SafeArea(
          bottom: false,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: _Header()),
              const SliverToBoxAdapter(child: _TitleBlock()),
              const SliverToBoxAdapter(child: _SearchField()),
              const SliverToBoxAdapter(child: _CategoryTabs()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
                  child: _SectionHeader(
                    icon: Icons.local_fire_department_rounded,
                    title: 'Populer Minggu Ini',
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: _HeroDestinationCard()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: _SectionHeader(
                    icon: Icons.location_on_outlined,
                    title: 'Dekat Denganmu',
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: _NearbyList()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
                  child: _SectionHeader(
                    icon: Icons.eco_outlined,
                    title: 'Hidden Gems',
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: _HiddenGemsList()),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 10),
                  child: _MapSectionHeader(),
                ),
              ),
              const SliverToBoxAdapter(child: _MapPreview()),
              SliverToBoxAdapter(
                child: SizedBox(
                    height: MediaQuery.paddingOf(context).bottom + 112),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: RenbokLogo(size: 22, showSubtitle: true),
            ),
            const Spacer(),
            _HeaderIcon(icon: Icons.search_rounded, onTap: () {}),
            const SizedBox(width: 12),
            Stack(
              clipBehavior: Clip.none,
              children: [
                _HeaderIcon(
                  icon: Icons.notifications_none_rounded,
                  onTap: () => context.go('/main/activity'),
                ),
                Positioned(
                  top: -1,
                  right: -1,
                  child: Container(
                    height: 15,
                    constraints: const BoxConstraints(minWidth: 15),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE11D48),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '3',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const _Avatar(),
          ],
        ),
      ),
    );
  }
}

class _TitleBlock extends StatelessWidget {
  const _TitleBlock();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mau ke mana hari ini?',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.deepForest,
              fontSize: 26,
              fontWeight: FontWeight.w700,
              height: 1.12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Temukan gunung, air terjun, camping ground, dan hidden gems.',
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF6B7280),
              fontSize: 11,
              fontWeight: FontWeight.w400,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepForest.withValues(alpha: 0.09),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Icon(
              Icons.search_rounded,
              size: 22,
              color: AppColors.deepForest.withValues(alpha: 0.72),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Cari gunung, air terjun, camping...',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF7A817D),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Icon(Icons.tune_rounded,
                size: 20, color: AppColors.deepForest),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs();

  static const _tabs = [
    'Semua',
    'Gunung',
    'Air Terjun',
    'Camping',
    'Pantai',
    'Danau',
    'Hidden Gems',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = index == 0;
          return Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: selected ? 18 : 17),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected ? AppColors.forestGreen : Colors.white,
              borderRadius: BorderRadius.circular(999),
              boxShadow: [
                BoxShadow(
                  color: AppColors.deepForest.withValues(alpha: 0.06),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              _tabs[index],
              style: GoogleFonts.plusJakartaSans(
                color: selected ? Colors.white : const Color(0xFF1F2937),
                fontSize: 10,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.forestGreen, size: 17),
        const SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          'Lihat Semua',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward_rounded,
            color: AppColors.deepForest, size: 16),
      ],
    );
  }
}

class _HeroDestinationCard extends StatelessWidget {
  const _HeroDestinationCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 220,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const _NetworkPhoto(url: ExploreScreen._heroImage),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.08),
                      Colors.black.withValues(alpha: 0.08),
                      Colors.black.withValues(alpha: 0.74),
                    ],
                    stops: const [0, 0.42, 1],
                  ),
                ),
              ),
              Positioned(
                top: 18,
                right: 18,
                child: _RoundIcon(
                  icon: Icons.bookmark_border_rounded,
                  color: AppColors.deepForest,
                  background: Colors.white.withValues(alpha: 0.92),
                ),
              ),
              Positioned(
                left: 18,
                bottom: 18,
                right: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.36),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: Color(0xFFFFB703),
                            size: 13,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'POPULER',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gunung Rinjani',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          'Lombok, NTB',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFFFC247), size: 15),
                        const SizedBox(width: 4),
                        Text(
                          '4.9',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(1.234 ulasan)',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Icon(Icons.groups_rounded,
                            color: Colors.white, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          '128 explorer minggu ini',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Lihat Panduan',
                                style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.deepForest,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                color: AppColors.deepForest,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: _Dots(),
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

class _NearbyList extends StatelessWidget {
  const _NearbyList();

  @override
  Widget build(BuildContext context) {
    const cards = [
      _NearbyDestination(
        title: 'Gunung Prau',
        region: 'Dieng, Jawa Tengah',
        distance: '6.5 km',
        rating: '4.8',
        reviews: '890',
        elevation: '2.565 mdpl',
        image: ExploreScreen._prauImage,
      ),
      _NearbyDestination(
        title: 'Gunung Andong',
        region: 'Magelang, Jawa Tengah',
        distance: '7.8 km',
        rating: '4.7',
        reviews: '612',
        elevation: '1.726 mdpl',
        image: ExploreScreen._andongImage,
      ),
      _NearbyDestination(
        title: 'Gunung Merbabu',
        region: 'Boyolali, Jawa Tengah',
        distance: '9.5 km',
        rating: '4.8',
        reviews: '1.102',
        elevation: '3.145 mdpl',
        image: ExploreScreen._merbabuImage,
      ),
    ];

    return SizedBox(
      height: 138,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.none,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => cards[index],
      ),
    );
  }
}

class _NearbyDestination extends StatelessWidget {
  const _NearbyDestination({
    required this.title,
    required this.region,
    required this.distance,
    required this.rating,
    required this.reviews,
    required this.elevation,
    required this.image,
  });

  final String title;
  final String region;
  final String distance;
  final String rating;
  final String reviews;
  final String elevation;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepForest.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 74,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _NetworkPhoto(url: image),
                Positioned(
                  left: 10,
                  top: 8,
                  child: _TinyBadge(
                    icon: Icons.location_on,
                    label: distance,
                    background: const Color(0xFFEAF3F6).withValues(alpha: 0.95),
                    color: AppColors.deepForest,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 9, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  region,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFC247), size: 13),
                    const SizedBox(width: 3),
                    Text(
                      '$rating  ($reviews)',
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF4B5563),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.terrain_rounded,
                      color: AppColors.deepForest.withValues(alpha: 0.58),
                      size: 13,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      elevation,
                      style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF4B5563),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HiddenGemsList extends StatelessWidget {
  const _HiddenGemsList();

  @override
  Widget build(BuildContext context) {
    const cards = [
      _HiddenGem(
        title: 'Curug Lawe',
        region: 'Semarang, Jawa Tengah',
        explorers: '28 explorer',
        rating: '4.6',
        image: ExploreScreen._waterfallOne,
      ),
      _HiddenGem(
        title: 'Air Terjun Kedung Kayang',
        region: 'Magelang, Jawa Tengah',
        explorers: '42 explorer',
        rating: '4.7',
        image: ExploreScreen._waterfallTwo,
      ),
      _HiddenGem(
        title: 'Curug Ceheng',
        region: 'Banyumas, Jawa Tengah',
        explorers: '12 explorer',
        rating: '4.8',
        image: ExploreScreen._waterfallThree,
      ),
    ];

    return SizedBox(
      height: 137,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        clipBehavior: Clip.none,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => cards[index],
      ),
    );
  }
}

class _HiddenGem extends StatelessWidget {
  const _HiddenGem({
    required this.title,
    required this.region,
    required this.explorers,
    required this.rating,
    required this.image,
  });

  final String title;
  final String region;
  final String explorers;
  final String rating;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepForest.withValues(alpha: 0.07),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 82,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _NetworkPhoto(url: image),
                Positioned(
                  top: 8,
                  right: 8,
                  child: _RoundIcon(
                    icon: Icons.bookmark_border_rounded,
                    color: AppColors.deepForest,
                    background: Colors.white.withValues(alpha: 0.94),
                    size: 26,
                    iconSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.deepForest,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  region,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(Icons.groups_rounded,
                        size: 10, color: AppColors.deepForest),
                    const SizedBox(width: 2),
                    Expanded(
                      child: Text(
                        explorers,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.deepForest,
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(Icons.star_rounded,
                        color: Color(0xFFFFC247), size: 10),
                    const SizedBox(width: 2),
                    Text(
                      rating,
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.deepForest,
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapSectionHeader extends StatelessWidget {
  const _MapSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.map_outlined, color: AppColors.deepForest, size: 18),
        const SizedBox(width: 8),
        Text(
          'Lihat Destinasi di Peta',
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepForest.withValues(alpha: 0.07),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                'Buka Peta',
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.arrow_forward_rounded,
                  color: AppColors.deepForest, size: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapPreview extends StatelessWidget {
  const _MapPreview();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 128,
          child: CustomPaint(
            painter: _MapPainter(),
            child: const Stack(
              children: [
                Positioned(left: 46, top: 18, child: _MapPin(count: '12')),
                Positioned(left: 126, top: 24, child: _MapPin(count: '8')),
                Positioned(left: 215, top: 16, child: _MapPin(count: '15')),
                Positioned(right: 50, top: 44, child: _MapPin(count: '6')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFFDCEBDC);
    canvas.drawRect(Offset.zero & size, bg);

    final wash = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.skyBlue.withValues(alpha: 0.35),
          const Color(0xFFEFF3E8),
          AppColors.forestGreen.withValues(alpha: 0.16),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, wash);

    final road = Paint()
      ..color = Colors.white.withValues(alpha: 0.58)
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final line = Path()
      ..moveTo(-20, 87)
      ..cubicTo(58, 52, 93, 111, 156, 76)
      ..cubicTo(222, 39, 275, 78, size.width + 24, 34);
    canvas.drawPath(line, road);

    final river = Paint()
      ..color = AppColors.skyBlue.withValues(alpha: 0.38)
      ..strokeWidth = 11
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final riverPath = Path()
      ..moveTo(-16, 25)
      ..cubicTo(52, 55, 95, 23, 144, 40)
      ..cubicTo(198, 59, 239, 111, size.width + 18, 84);
    canvas.drawPath(riverPath, river);

    final detail = Paint()
      ..color = AppColors.deepForest.withValues(alpha: 0.08)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < 9; i++) {
      final y = 10.0 + i * 14;
      canvas.drawLine(
          Offset(0, y), Offset(size.width, y + (i.isEven ? 18 : -10)), detail);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.count});

  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.forestGreen,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.deepForest.withValues(alpha: 0.18),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(Icons.landscape_rounded,
              color: Colors.white, size: 18),
        ),
        const SizedBox(width: 4),
        Text(
          count,
          style: GoogleFonts.plusJakartaSans(
            color: AppColors.deepForest,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 28,
        height: 28,
        child: Icon(icon, color: const Color(0xFF111827), size: 24),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipOval(
          child: SizedBox(
            width: 36,
            height: 36,
            child: Image.network(
              'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=160&q=80',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: AppColors.stone),
            ),
          ),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cream, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({
    required this.icon,
    required this.color,
    required this.background,
    this.size = 34,
    this.iconSize = 18,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, color: color, size: iconSize),
    );
  }
}

class _TinyBadge extends StatelessWidget {
  const _TinyBadge({
    required this.icon,
    required this.label,
    required this.background,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return Container(
          width: index == 0 ? 16 : 14,
          height: 3,
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: index == 0 ? 1 : 0.42),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
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
        return Container(color: AppColors.stone.withValues(alpha: 0.5));
      },
      errorBuilder: (_, __, ___) => Container(color: AppColors.stone),
    );
  }
}
