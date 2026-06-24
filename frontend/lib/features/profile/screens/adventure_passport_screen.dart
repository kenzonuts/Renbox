import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_layout.dart';
import '../../../core/theme/app_colors.dart';

const _pageBg = Color(0xFFFCFAF7);
const _green = Color(0xFF124D3B);
const _ink = Color(0xFF0A251D);
const _muted = Color(0xFF66736D);
const _line = Color(0xFFE8E0D7);

class AdventurePassportScreen extends StatelessWidget {
  const AdventurePassportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Column(
                  children: [
                    const _PageHeader(),
                    const SizedBox(height: 14),
                    const _ExplorerHeroCard(),
                    const SizedBox(height: 12),
                    const _StatsGrid(),
                    const SizedBox(height: 16),
                    _SectionHeader(
                      title: 'Badge Collection',
                      action: 'Lihat Semua',
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    const _BadgeCollection(),
                    const SizedBox(height: 16),
                    const _NextMilestoneCard(),
                    SizedBox(height: AppLayout.bottomContentPadding(context)),
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

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          _IconButton(
            icon: Icons.arrow_back_rounded,
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/main');
              }
            },
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Koleksi Petualanganmu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: _green,
                    fontSize: 14,
                    height: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Passport Explorer',
                  style: GoogleFonts.plusJakartaSans(
                    color: _muted,
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          _IconButton(
            icon: Icons.ios_share_rounded,
            onTap: () {},
          ),
        ],
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
      color: Colors.white.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 36,
          height: 36,
          child: Icon(icon, size: 19, color: _green),
        ),
      ),
    );
  }
}

class _ExplorerHeroCard extends StatelessWidget {
  const _ExplorerHeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        image: const DecorationImage(
          image: AssetImage('img/home/cardpetualangan.png'),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFAFFFFFF),
                    Color(0xDEFFFFFF),
                    Color(0x22FFFFFF),
                  ],
                  stops: [0, 0.58, 1],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 13),
            child: Row(
              children: [
                const _LevelMedal(),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Explorer Level 8',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                color: _green,
                                fontSize: 14,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.verified_rounded,
                            size: 14,
                            color: Color(0xFF2DBE73),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '+1.240 XP',
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.starGold,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '760 XP lagi menuju Level 9',
                        style: GoogleFonts.plusJakartaSans(
                          color: _ink,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Expanded(child: _ProgressBar(value: 0.68)),
                          const SizedBox(width: 10),
                          Text(
                            '68%',
                            style: GoogleFonts.plusJakartaSans(
                              color: _green,
                              fontSize: 11,
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

class _LevelMedal extends StatelessWidget {
  const _LevelMedal();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 78,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 68,
            height: 68,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8E3DA), width: 5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 12,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: _green,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.terrain_rounded,
                color: Colors.white,
                size: 31,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 24,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: _green,
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.center,
            child: Text(
              'Level 8',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 7,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: Color(0xFFE7E6E1)),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: const ColoredBox(color: _green),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        children: [
          Row(
            children: [
              _StatTile(
                icon: Icons.terrain_rounded,
                iconColor: AppColors.forestGreen,
                value: '12',
                label: 'Gunung',
              ),
              _VerticalRule(),
              _StatTile(
                icon: Icons.water_drop_rounded,
                iconColor: AppColors.skyBlue,
                value: '8',
                label: 'Air Terjun',
              ),
              _VerticalRule(),
              _StatTile(
                icon: Icons.cabin_rounded,
                iconColor: AppColors.earthBrown,
                value: '15',
                label: 'Camping',
              ),
            ],
          ),
          _HorizontalRule(),
          Row(
            children: [
              _StatTile(
                icon: Icons.location_on_rounded,
                iconColor: AppColors.error,
                value: '24',
                label: 'Check-in',
              ),
              _VerticalRule(),
              _StatTile(
                icon: Icons.camera_alt_rounded,
                iconColor: Color(0xFF7C3AED),
                value: '83',
                label: 'Foto',
              ),
              _VerticalRule(),
              _StatTile(
                icon: Icons.star_rounded,
                iconColor: AppColors.starGold,
                value: '17',
                label: 'Review',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 21),
                const SizedBox(width: 7),
                Text(
                  value,
                  style: GoogleFonts.plusJakartaSans(
                    color: _green,
                    fontSize: 18,
                    height: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: _muted,
                fontSize: 9.5,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalRule extends StatelessWidget {
  const _HorizontalRule();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: _line);
  }
}

class _VerticalRule extends StatelessWidget {
  const _VerticalRule();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 46,
      child: VerticalDivider(width: 1, thickness: 1, color: _line),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.action,
    required this.onTap,
  });

  final String title;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            color: _green,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
            child: Row(
              children: [
                Text(
                  action,
                  style: GoogleFonts.plusJakartaSans(
                    color: _green,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: _green,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BadgeCollection extends StatelessWidget {
  const _BadgeCollection();

  @override
  Widget build(BuildContext context) {
    final badges = const [
      _BadgeData('Summit\nHunter', Icons.terrain_rounded, true),
      _BadgeData('Waterfall\nExplorer', Icons.water_drop_rounded, true),
      _BadgeData('Camper\nPro', Icons.cabin_rounded, true),
      _BadgeData('Forest\nWalker', Icons.forest_rounded, true),
      _BadgeData('Volcano\nMaster', Icons.local_fire_department_rounded, false),
      _BadgeData('Island\nExplorer', Icons.sailing_rounded, false),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 16),
        child: GridView.builder(
          itemCount: badges.length + 1,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 14,
            crossAxisSpacing: 8,
            mainAxisExtent: 82,
          ),
          itemBuilder: (context, index) {
            if (index == badges.length) {
              return const _MoreBadgeTile();
            }
            return _BadgeTile(data: badges[index]);
          },
        ),
      ),
    );
  }
}

class _BadgeTile extends StatelessWidget {
  const _BadgeTile({required this.data});

  final _BadgeData data;

  @override
  Widget build(BuildContext context) {
    final color = data.unlocked ? _green : const Color(0xFF8B908C);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: data.unlocked
                    ? const Color(0xFFE8F3ED)
                    : const Color(0xFFE9E9E7),
                shape: BoxShape.circle,
              ),
              child: CustomPaint(
                painter: _BadgeHexPainter(color: color),
                child: Icon(
                  data.icon,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            if (data.unlocked)
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  width: 17,
                  height: 17,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2DBE73),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              )
            else
              Positioned.fill(
                child: Icon(
                  Icons.lock_rounded,
                  color: Colors.white.withValues(alpha: 0.78),
                  size: 18,
                ),
              ),
          ],
        ),
        const SizedBox(height: 7),
        Text(
          data.label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.plusJakartaSans(
            color: data.unlocked ? _green : _muted,
            fontSize: 8.7,
            height: 1.12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _MoreBadgeTile extends StatelessWidget {
  const _MoreBadgeTile();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFD7D1C8),
              width: 1.2,
              strokeAlign: BorderSide.strokeAlignInside,
            ),
          ),
          child: const Icon(
            Icons.add_rounded,
            color: _green,
            size: 24,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          'Lainnya',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            color: _green,
            fontSize: 8.7,
            height: 1.12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

class _NextMilestoneCard extends StatelessWidget {
  const _NextMilestoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF3ED),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD8E7DE)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: _green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.flag_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Misi berikutnya',
                  style: GoogleFonts.plusJakartaSans(
                    color: _green,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Check-in di 3 destinasi baru untuk membuka badge berikutnya.',
                  style: GoogleFonts.plusJakartaSans(
                    color: _muted,
                    fontSize: 10.5,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
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

class _BadgeHexPainter extends CustomPainter {
  const _BadgeHexPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.39;
    final path = Path();

    for (var i = 0; i < 6; i++) {
      final angle = -1.57079632679 + i * 1.0471975512;
      final point = Offset(
        center.dx + radius * 1.08 * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    path.close();
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _BadgeHexPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _BadgeData {
  const _BadgeData(this.label, this.icon, this.unlocked);

  final String label;
  final IconData icon;
  final bool unlocked;
}
