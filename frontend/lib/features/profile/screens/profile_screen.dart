import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_top_header.dart';

const _heroHeight = 300.0;
const _passportHeight = 205.0;
const _overlap = 30.0;
const _horizontalPadding = 24.0;
const _ink = Color(0xFF0B2C23);
const _muted = Color(0xFF5F6368);
const _line = Color(0xFFE6E0D8);

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: _ProfileTop()),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            const SliverToBoxAdapter(child: _AchievementSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            const SliverToBoxAdapter(child: _ExplorerStatsCard()),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
            const SliverToBoxAdapter(child: _RecentAdventures()),
            const SliverToBoxAdapter(child: SizedBox(height: 18)),
            SliverPersistentHeader(
              pinned: true,
              delegate: _StickyTabsDelegate(),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 148),
              sliver: _PostGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTop extends StatelessWidget {
  const _ProfileTop();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _heroHeight + _passportHeight - _overlap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const _ProfileHero(),
          Positioned(
            left: 16,
            right: 16,
            top: _heroHeight - _overlap,
            height: _passportHeight,
            child: _AdventurePassportCard(),
          ),
        ],
      ),
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'img/home/home.png',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.62),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.45),
                ],
                stops: const [0, 0.42, 1],
              ),
            ),
          ),
          const _ProfileHeader(),
          Positioned(
            left: 24,
            right: 24,
            bottom: 22,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const _HeroAvatar(),
                const SizedBox(width: 18),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Kenzo',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.white,
                                fontSize: 30,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const _VerifiedBadge(),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '@kenzonuts',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const _ExplorerPill(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 24,
            bottom: -4,
            child: _AchievementPill(),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      height: 72,
      child: AppTopHeader(
        variant: AppTopHeaderVariant.overlay,
        showProfile: false,
        trailingIcon: Icons.settings_outlined,
        onSearchTap: () => context.go('/main/explore'),
        onNotificationTap: () => context.go('/main/activity'),
        onTrailingTap: () {},
      ),
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ],
            image: const DecorationImage(
              image: AssetImage('img/home/home.png'),
              fit: BoxFit.cover,
              alignment: Alignment(-0.82, 0.46),
            ),
          ),
        ),
        Positioned(
          right: 4,
          bottom: 3,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.forestGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
            ),
            child: const Icon(
              Icons.explore_rounded,
              color: Colors.white,
              size: 21,
            ),
          ),
        ),
      ],
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  const _VerifiedBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: const Color(0xFF7ED957),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
    );
  }
}

class _ExplorerPill extends StatelessWidget {
  const _ExplorerPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
      decoration: BoxDecoration(
        color: AppColors.forestGreen.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332D6A4F),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white, width: 1.5),
            ),
            child: const Icon(Icons.shield_outlined,
                color: Colors.white, size: 15),
          ),
          const SizedBox(width: 8),
          Text(
            'Level 7 Explorer',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementPill extends StatelessWidget {
  const _AchievementPill();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      padding: const EdgeInsets.fromLTRB(16, 0, 20, 0),
      decoration: BoxDecoration(
        color: const Color(0xFFD8B99C),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.terrain_rounded, color: Colors.white, size: 22),
          const SizedBox(width: 9),
          Text(
            'Mountain Hunter',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _AdventurePassportCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 32,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            Positioned(
              right: -7,
              bottom: -2,
              width: 154,
              child: Opacity(
                opacity: 0.92,
                child: Image.asset('img/home/cardpetualangan.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.explore_outlined,
                        color: AppColors.forestGreen,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Adventure Passport',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.deepForest,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      _PassportStat(
                        icon: Icons.terrain_rounded,
                        iconColor: AppColors.forestGreen,
                        number: '12',
                        label: 'Gunung',
                        bg: Color(0xFFE7F2EA),
                      ),
                      _VerticalRule(),
                      _PassportStat(
                        icon: Icons.water_drop_rounded,
                        iconColor: AppColors.skyBlue,
                        number: '8',
                        label: 'Air Terjun',
                        bg: Color(0xFFEAF7FB),
                      ),
                      _VerticalRule(),
                      _PassportStat(
                        icon: Icons.cabin_rounded,
                        iconColor: AppColors.earthBrown,
                        number: '15',
                        label: 'Camping',
                        bg: Color(0xFFF4ECE4),
                      ),
                      _VerticalRule(),
                      _PassportStat(
                        icon: Icons.location_on_rounded,
                        iconColor: AppColors.forestGreen,
                        number: '24',
                        label: 'Check-in',
                        bg: Color(0xFFE9F2E3),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(height: 1, width: 286, color: _line),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '68%',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.forestGreen,
                          fontSize: 26,
                          height: 0.95,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Menuju Explorer Level 8',
                            style: GoogleFonts.plusJakartaSans(
                              color: _ink,
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '780 / 1.150 XP',
                            style: GoogleFonts.plusJakartaSans(
                              color: _muted,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: SizedBox(
                      width: 236,
                      height: 8,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          const ColoredBox(color: Color(0xFFE5E7EB)),
                          FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: 0.68,
                            child: Container(color: AppColors.forestGreen),
                          ),
                        ],
                      ),
                    ),
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

class _PassportStat extends StatelessWidget {
  const _PassportStat({
    required this.icon,
    required this.iconColor,
    required this.number,
    required this.label,
    required this.bg,
  });

  final IconData icon;
  final Color iconColor;
  final String number;
  final String label;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 21),
          ),
          const SizedBox(height: 4),
          Text(
            number,
            style: GoogleFonts.plusJakartaSans(
              color: _ink,
              fontSize: 18,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            style: GoogleFonts.plusJakartaSans(
              color: _muted,
              fontSize: 10.5,
              height: 1,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _VerticalRule extends StatelessWidget {
  const _VerticalRule();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 39, color: _line);
  }
}

class _AchievementSection extends StatelessWidget {
  const _AchievementSection();

  @override
  Widget build(BuildContext context) {
    final badges = const [
      _BadgeData('Mountain\nHunter', Icons.terrain_rounded, Color(0xFF1B5A3F)),
      _BadgeData('Waterfall\nExplorer', Icons.waterfall_chart_rounded,
          Color(0xFF143A53)),
      _BadgeData(
          'Nature\nPhotographer', Icons.camera_alt_rounded, Color(0xFF8B552C)),
      _BadgeData('Weekend\nCamper', Icons.nightlight_round, Color(0xFF144E36)),
      _BadgeData('Trail\nSeeker', Icons.explore_rounded, Color(0xFF72532D)),
    ];

    return Column(
      children: [
        const _SectionHeader(title: 'Achievement'),
        const SizedBox(height: 12),
        SizedBox(
          height: 154,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                _AchievementBadge(data: badges[index]),
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemCount: badges.length,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.deepForest,
              fontSize: 18,
              height: 1,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          Text(
            'Lihat Semua',
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.deepForest,
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward_rounded,
              color: AppColors.deepForest, size: 20),
        ],
      ),
    );
  }
}

class _BadgeData {
  const _BadgeData(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class _AchievementBadge extends StatelessWidget {
  const _AchievementBadge({required this.data});

  final _BadgeData data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        children: [
          SizedBox(
            width: 88,
            height: 88,
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipPath(
                  clipper: _HexagonClipper(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          data.color.withValues(alpha: 0.88),
                          data.color
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: _BadgeTexturePainter(color: data.color),
                      child: Center(
                        child: Icon(data.icon, color: Colors.white, size: 37),
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: _HexagonClipper(),
                  child: Container(
                    margin: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFE3C9A7), width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 11),
          Text(
            data.label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.deepForest,
              fontSize: 13,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExplorerStatsCard extends StatelessWidget {
  const _ExplorerStatsCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x10000000),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: const Row(
          children: [
            _ProfileStat(
                icon: Icons.image_outlined, number: '48', label: 'Postingan'),
            _VerticalRule(),
            _ProfileStat(
                icon: Icons.location_on_outlined,
                number: '24',
                label: 'Check-in'),
            _VerticalRule(),
            _ProfileStat(
                icon: Icons.bookmark_border_rounded,
                number: '18',
                label: 'Wishlist'),
            _VerticalRule(),
            _ProfileStat(
                icon: Icons.workspace_premium_outlined,
                number: '7',
                label: 'Badge',
                accent: Color(0xFF6C63D8)),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({
    required this.icon,
    required this.number,
    required this.label,
    this.accent = AppColors.forestGreen,
  });

  final IconData icon;
  final String number;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 27),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: GoogleFonts.plusJakartaSans(
                  color: _ink,
                  fontSize: 20,
                  height: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: _muted,
                  fontSize: 11.5,
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

class _RecentAdventures extends StatelessWidget {
  const _RecentAdventures();

  @override
  Widget build(BuildContext context) {
    final cards = const [
      _AdventureData(
        'Gunung Prau',
        'Dieng, Jawa Tengah',
        '2 hari lalu',
        'img/home/home.png',
        true,
      ),
      _AdventureData(
        'Gunung Merbabu',
        'Boyolali, Jawa Tengah',
        '1 minggu lalu',
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=500&q=80',
        false,
      ),
      _AdventureData(
        'Curug Lawe',
        'Ungaran, Jawa Tengah',
        '2 minggu lalu',
        'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=500&q=80',
        false,
      ),
      _AdventureData(
        'Telaga Warna',
        'Dieng, Jawa Tengah',
        '3 minggu lalu',
        'https://images.unsplash.com/photo-1439066615861-d1af74d74000?auto=format&fit=crop&w=500&q=80',
        false,
      ),
    ];

    return Column(
      children: [
        const _SectionHeader(title: 'Petualangan Terbaru'),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _AdventureCard(data: cards[index]),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: cards.length,
          ),
        ),
      ],
    );
  }
}

class _AdventureData {
  const _AdventureData(
    this.name,
    this.place,
    this.time,
    this.image,
    this.asset,
  );

  final String name;
  final String place;
  final String time;
  final String image;
  final bool asset;
}

class _AdventureCard extends StatelessWidget {
  const _AdventureCard({required this.data});

  final _AdventureData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 58,
            width: double.infinity,
            child: data.asset
                ? Image.asset(data.image, fit: BoxFit.cover)
                : CachedNetworkImage(imageUrl: data.image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
            child: Text(
              data.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: _ink,
                fontSize: 13,
                height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 0),
            child: Text(
              data.place,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: _muted,
                fontSize: 11,
                height: 1,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 8, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    data.time,
                    maxLines: 1,
                    style: GoogleFonts.plusJakartaSans(
                      color: _muted,
                      fontSize: 10.5,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  height: 23,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_rounded,
                          color: AppColors.forestGreen, size: 13),
                      const SizedBox(width: 3),
                      Text(
                        'Check-in',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.forestGreen,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
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

class _StickyTabsDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const _ProfileTabs();
  }

  @override
  double get maxExtent => 58;

  @override
  double get minExtent => 58;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: const Row(
        children: [
          _TabItem(
              icon: Icons.article_outlined, label: 'Postingan', active: true),
          _TabItem(icon: Icons.image_outlined, label: 'Album'),
          _TabItem(icon: Icons.location_on_outlined, label: 'Check-in'),
          _TabItem(icon: Icons.bookmark_border_rounded, label: 'Wishlist'),
          _TabItem(icon: Icons.workspace_premium_outlined, label: 'Badge'),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    required this.icon,
    required this.label,
    this.active = false,
  });

  final IconData icon;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.forestGreen : const Color(0xFF4D5156);
    return Expanded(
      child: SizedBox(
        height: 58,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 5),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: color,
                      fontSize: 13,
                      fontWeight: active ? FontWeight.w800 : FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 3,
              width: active ? 70 : 0,
              decoration: BoxDecoration(
                color: AppColors.forestGreen,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostGrid extends StatelessWidget {
  const _PostGrid();

  @override
  Widget build(BuildContext context) {
    final images = const [
      _GridImage('img/home/home.png', true, Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1448375240586-882707db888b?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1439066615861-d1af74d74000?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
      _GridImage(
          'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=500&q=80',
          false,
          Alignment.center),
    ];

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => _GridTile(data: images[index]),
        childCount: images.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      ),
    );
  }
}

class _GridImage {
  const _GridImage(this.src, this.asset, this.alignment);
  final String src;
  final bool asset;
  final Alignment alignment;
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.data});

  final _GridImage data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          data.asset
              ? Image.asset(data.src,
                  fit: BoxFit.cover, alignment: data.alignment)
              : CachedNetworkImage(
                  imageUrl: data.src,
                  fit: BoxFit.cover,
                  alignment: data.alignment),
          Positioned(
            top: 9,
            right: 9,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    for (var i = 0; i < 6; i++) {
      final angle = math.pi / 6 + i * math.pi / 3;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _BadgeTexturePainter extends CustomPainter {
  const _BadgeTexturePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final fill = Paint()
      ..color = Colors.black.withValues(alpha: 0.09)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width * 0.25, size.height * 0.28), 2.2, paint);
    canvas.drawCircle(
        Offset(size.width * 0.73, size.height * 0.30), 2.5, paint);
    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.12, size.height * 0.72)
        ..lineTo(size.width * 0.32, size.height * 0.52)
        ..lineTo(size.width * 0.48, size.height * 0.75)
        ..lineTo(size.width * 0.64, size.height * 0.58)
        ..lineTo(size.width * 0.86, size.height * 0.74)
        ..lineTo(size.width * 0.86, size.height)
        ..lineTo(size.width * 0.12, size.height)
        ..close(),
      fill,
    );
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.18),
      Offset(size.width * 0.82, size.height * 0.82),
      paint..color = color.withValues(alpha: 0.35),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
