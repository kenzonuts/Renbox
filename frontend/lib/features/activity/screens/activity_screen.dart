import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_layout.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_top_header.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = AppLayout.bottomContentPadding(context) + 20;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          const Positioned(
            top: 126,
            right: -8,
            child: Opacity(
              opacity: 0.10,
              child: SizedBox(
                width: 214,
                height: 116,
                child: CustomPaint(painter: _MountainLinePainter()),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Header(),
                        const SizedBox(height: 12),
                        Text(
                          'Activity',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.deepForest,
                            fontSize: 40,
                            height: 1.05,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '12 Aktivitas Baru Hari Ini',
                              style: GoogleFonts.plusJakartaSans(
                                color: const Color(0xFF4B5563),
                                fontSize: 16,
                                height: 1,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: AppColors.forestGreen,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(child: _SummaryArea()),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(child: _StatsCard()),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                const SliverToBoxAdapter(child: _FilterChips()),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, bottomPadding),
                  sliver: SliverList.separated(
                    itemCount: _activities.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 0),
                    itemBuilder: (context, index) => _ActivityCard(
                      activity: _activities[index],
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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return AppTopHeader(
      horizontalPadding: 0,
      onSearchTap: () => context.go('/main/explore'),
      onNotificationTap: () {},
      onProfileTap: () => context.go('/main/profile'),
    );
  }
}

class _SummaryArea extends StatelessWidget {
  const _SummaryArea();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _ExplorerCard()),
        SizedBox(width: 16),
        Expanded(child: _AchievementCard()),
      ],
    );
  }
}

class _ExplorerCard extends StatelessWidget {
  const _ExplorerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [AppColors.deepForest, AppColors.forestGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -8,
            child: Container(
              width: 150,
              height: 190,
              decoration: BoxDecoration(
                color: AppColors.cream.withValues(alpha: 0.90),
                shape: BoxShape.circle,
              ),
            ),
          ),
          const Positioned(
            right: 16,
            top: 46,
            child: _BadgeArtwork(size: 70, compact: true),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.shield_outlined,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Level 7 Explorer',
                          maxLines: 1,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      height: 1,
                    ),
                    children: [
                      const TextSpan(
                        text: '780',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' / 1000 XP',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: SizedBox(
                    width: 92,
                    height: 8,
                    child: Stack(
                      children: [
                        Container(color: Colors.white.withValues(alpha: 0.25)),
                        FractionallySizedBox(
                          widthFactor: 0.72,
                          child: Container(color: const Color(0xFF8ED174)),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 126,
                  child: Text(
                    'Terus jelajahi,\ncapai level berikutnya!',
                    maxLines: 2,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 11,
                      height: 1.25,
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

class _AchievementCard extends StatelessWidget {
  const _AchievementCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            right: -24,
            bottom: -22,
            child: Opacity(
              opacity: 0.10,
              child: SizedBox(
                width: 96,
                height: 76,
                child: CustomPaint(painter: _MountainLinePainter()),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achievement Baru',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF101828),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const _BadgeArtwork(size: 58),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Mountain Hunter',
                            maxLines: 1,
                            style: GoogleFonts.plusJakartaSans(
                              color: const Color(0xFF101828),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Menaklukkan 5 gunung',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color(0xFF6B7280),
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '+150 XP',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.forestGreen,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard();

  @override
  Widget build(BuildContext context) {
    const stats = [
      _StatData('12', 'Interaksi', Icons.favorite_border_rounded,
          Color(0xFFD8244D), Color(0xFFFBECEE)),
      _StatData('6', 'Check-in', Icons.location_on_rounded,
          AppColors.forestGreen, Color(0xFFEEF6ED)),
      _StatData('3', 'Badge', Icons.emoji_events_outlined, Color(0xFF93631F),
          Color(0xFFF8F0E4)),
      _StatData('2', 'Info & Sistem', Icons.campaign_outlined,
          Color(0xFF1261A6), Color(0xFFEAF3FB)),
    ];

    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          for (var i = 0; i < stats.length; i++) ...[
            Expanded(child: _StatItem(data: stats[i])),
            if (i != stats.length - 1)
              Container(width: 1, height: 48, color: const Color(0xFFE5E7EB)),
          ],
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.data});

  final _StatData data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration:
              BoxDecoration(color: data.background, shape: BoxShape.circle),
          child: Icon(data.icon, color: data.color, size: 22),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.value,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF080D0C),
                  fontSize: 22,
                  height: 1,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  data.label,
                  maxLines: 1,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF4B5563),
                    fontSize: 10,
                    height: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    final chips = ['Semua', 'Interaksi', 'Check-in', 'Badge', 'Sistem'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (var i = 0; i < chips.length; i++) ...[
            _FilterChip(label: chips[i], active: i == 0),
            if (i != chips.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 76,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.forestGreen : Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: active ? null : Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: active
            ? const [
                BoxShadow(
                  color: Color(0x1A2D6A4F),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Text(
        label,
        maxLines: 1,
        style: GoogleFonts.plusJakartaSans(
          color: active ? Colors.white : const Color(0xFF111827),
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({required this.activity});

  final _ActivityData activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          activity.leading,
          const SizedBox(width: 16),
          Expanded(child: activity.content),
          const SizedBox(width: 12),
          SizedBox(width: 80, child: activity.trailing),
          const SizedBox(width: 12),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF6B7280),
            size: 28,
          ),
        ],
      ),
    );
  }
}

class _ActivityText extends StatelessWidget {
  const _ActivityText({
    required this.lines,
    required this.time,
    this.xp,
  });

  final List<InlineSpan> lines;
  final String time;
  final String? xp;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF0B1110),
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w500,
            ),
            children: lines,
          ),
        ),
        const SizedBox(height: 8),
        FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                time,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (xp != null) ...[
                const SizedBox(width: 6),
                Text(
                  '•',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  xp!,
                  style: GoogleFonts.plusJakartaSans(
                    color: AppColors.forestGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.size,
    this.badgeColor,
    this.badgeIcon,
    this.person = Icons.person_rounded,
    this.backgroundAlignment = Alignment.center,
  });

  final double size;
  final Color? badgeColor;
  final IconData? badgeIcon;
  final IconData person;
  final Alignment backgroundAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + (badgeColor == null ? 0 : 8),
      height: size + (badgeColor == null ? 0 : 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: ClipOval(
              child: SizedBox(
                width: size,
                height: size,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _MountainScene(alignment: backgroundAlignment),
                    Icon(
                      person,
                      color: Colors.white.withValues(alpha: 0.92),
                      size: size * 0.54,
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (badgeColor != null && badgeIcon != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: badgeColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Icon(badgeIcon, color: Colors.white, size: 14),
              ),
            ),
        ],
      ),
    );
  }
}

class _RoundIconAvatar extends StatelessWidget {
  const _RoundIconAvatar({
    required this.icon,
    required this.background,
    required this.color,
  });

  final IconData icon;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }
}

class _MountainThumbnail extends StatelessWidget {
  const _MountainThumbnail({this.alignment = Alignment.center});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 80,
        height: 64,
        child: _MountainScene(alignment: alignment, showPerson: true),
      ),
    );
  }
}

class _MountainScene extends StatelessWidget {
  const _MountainScene({
    this.alignment = Alignment.center,
    this.showPerson = false,
  });

  final Alignment alignment;
  final bool showPerson;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _MountainScenePainter(
        alignment: alignment,
        showPerson: showPerson,
      ),
    );
  }
}

class _WeatherCard extends StatelessWidget {
  const _WeatherCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 64,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3ED),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Gunung Prau',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF101828),
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  '18°C - 25°C',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101828),
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text('🌤', style: TextStyle(fontSize: 21, height: 1)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrailStatusCard extends StatelessWidget {
  const _TrailStatusCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 64,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3ED),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Merbabu',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF101828),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(
                Icons.hiking_rounded,
                color: Color(0xFF43A047),
                size: 14,
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Jalur Selo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF4B5563),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                height: 20,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: const Color(0xFF43A047)),
                ),
                child: Text(
                  'DIBUKA',
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF2E7D32),
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.forestGreen),
      ),
      child: Text(
        'Lihat Profil',
        maxLines: 1,
        style: GoogleFonts.plusJakartaSans(
          color: AppColors.deepForest,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _BadgeArtwork extends StatelessWidget {
  const _BadgeArtwork({required this.size, this.compact = false});

  final double size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: compact ? size : size + 16,
      child: CustomPaint(painter: _BadgePainter(compact: compact)),
    );
  }
}

class _ActivityData {
  const _ActivityData({
    required this.leading,
    required this.content,
    required this.trailing,
  });

  final Widget leading;
  final Widget content;
  final Widget trailing;
}

class _StatData {
  const _StatData(
      this.value, this.label, this.icon, this.color, this.background);

  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final Color background;
}

TextSpan _bold(String text, {Color color = const Color(0xFF0B1110)}) {
  return TextSpan(
    text: text,
    style:
        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: color),
  );
}

TextSpan _plain(String text, {Color color = const Color(0xFF0B1110)}) {
  return TextSpan(
    text: text,
    style:
        GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500, color: color),
  );
}

final _activities = <_ActivityData>[
  _ActivityData(
    leading: const _UserAvatar(
      size: 58,
      badgeColor: Color(0xFFD8244D),
      badgeIcon: Icons.favorite_rounded,
      person: Icons.person_rounded,
      backgroundAlignment: Alignment.centerLeft,
    ),
    content: _ActivityText(
      lines: [
        _bold('Rizky Pratama '),
        _plain('menyukai fotomu\ndi '),
        _bold('Gunung Prau', color: AppColors.deepForest),
      ],
      time: '10 menit lalu',
    ),
    trailing: const _MountainThumbnail(alignment: Alignment.center),
  ),
  _ActivityData(
    leading: const _UserAvatar(
      size: 58,
      badgeColor: AppColors.forestGreen,
      badgeIcon: Icons.chat_bubble_rounded,
      person: Icons.person_2_rounded,
      backgroundAlignment: Alignment.centerRight,
    ),
    content: _ActivityText(
      lines: [
        _bold('Dewi Lestari '),
        _plain('berkomentar:\n“Sunrise-nya keren banget! 🔥”'),
      ],
      time: '25 menit lalu',
    ),
    trailing: const _MountainThumbnail(alignment: Alignment.center),
  ),
  _ActivityData(
    leading: const _RoundIconAvatar(
      icon: Icons.emoji_events_rounded,
      background: Color(0xFF8A642C),
      color: Color(0xFFE9C978),
    ),
    content: _ActivityText(
      lines: [
        _plain('Selamat! Kamu mendapat badge baru\n'),
        _bold('Mountain Hunter', color: AppColors.deepForest),
      ],
      time: '1 jam lalu',
      xp: '+150 XP',
    ),
    trailing: const Center(child: _BadgeArtwork(size: 66)),
  ),
  _ActivityData(
    leading: const _UserAvatar(
      size: 58,
      badgeColor: Color(0xFF48A08C),
      badgeIcon: Icons.location_on_rounded,
      person: Icons.hiking_rounded,
      backgroundAlignment: Alignment.centerLeft,
    ),
    content: _ActivityText(
      lines: [
        _bold('Raka Firmansyah '),
        _plain('check-in di\n'),
        _bold('Gunung Merbabu', color: AppColors.deepForest),
      ],
      time: '2 jam lalu',
    ),
    trailing: const _MountainThumbnail(alignment: Alignment.centerRight),
  ),
  _ActivityData(
    leading: const _RoundIconAvatar(
      icon: Icons.notifications_none_rounded,
      background: AppColors.deepForest,
      color: Color(0xFFCFE6B7),
    ),
    content: _ActivityText(
      lines: [
        _plain(
            'Info dari RENBOK\nCuaca Gunung Prau cerah untuk\nweekend ini ☀️'),
      ],
      time: '3 jam lalu',
    ),
    trailing: const _WeatherCard(),
  ),
  _ActivityData(
    leading: const _RoundIconAvatar(
      icon: Icons.campaign_rounded,
      background: Color(0xFFE6EEE4),
      color: AppColors.deepForest,
    ),
    content: _ActivityText(
      lines: [
        _bold('Update Jalur Pendakian\n'),
        _plain('Jalur Selo - Merbabu sudah dibuka\nkembali untuk umum.'),
      ],
      time: '4 jam lalu',
    ),
    trailing: const _TrailStatusCard(),
  ),
  _ActivityData(
    leading: const _UserAvatar(
      size: 58,
      badgeColor: Color(0xFF1C75BC),
      badgeIcon: Icons.groups_rounded,
      person: Icons.person_rounded,
      backgroundAlignment: Alignment.bottomCenter,
    ),
    content: _ActivityText(
      lines: [
        _bold('Andi Wijaya '),
        _plain('mulai mengikuti kamu'),
      ],
      time: '5 jam lalu',
    ),
    trailing: const Center(child: _ProfileButton()),
  ),
];

class _MountainScenePainter extends CustomPainter {
  const _MountainScenePainter({
    required this.alignment,
    required this.showPerson,
  });

  final Alignment alignment;
  final bool showPerson;

  @override
  void paint(Canvas canvas, Size size) {
    final shift = alignment.x * size.width * 0.12;
    final sky = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD8A8), Color(0xFFE9F5FA), Color(0xFF7FA0A0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sky);

    canvas.drawCircle(
      Offset(size.width * 0.28 - shift, size.height * 0.28),
      size.shortestSide * 0.16,
      Paint()..color = const Color(0xFFFFC56B).withValues(alpha: 0.70),
    );

    final far = Paint()..color = const Color(0xFF8AA39A);
    final mid = Paint()..color = const Color(0xFF385E4D);
    final dark = Paint()..color = const Color(0xFF203C31);
    final light = Paint()..color = const Color(0xFFF6F2E7);

    Path mountain(
      double left,
      double base,
      double width,
      double peak,
    ) {
      return Path()
        ..moveTo(left - shift, base)
        ..lineTo(left + width * 0.48 - shift, peak)
        ..lineTo(left + width - shift, base)
        ..close();
    }

    final farMountain = mountain(
      -size.width * 0.12,
      size.height * 0.76,
      size.width * 0.88,
      size.height * 0.22,
    );
    final mainMountain = mountain(
      size.width * 0.20,
      size.height * 0.78,
      size.width * 0.92,
      size.height * 0.18,
    );
    canvas.drawPath(farMountain, far);
    canvas.drawPath(mainMountain, mid);

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.64 - shift, size.height * 0.18)
        ..lineTo(size.width * 0.50 - shift, size.height * 0.46)
        ..lineTo(size.width * 0.61 - shift, size.height * 0.38)
        ..lineTo(size.width * 0.67 - shift, size.height * 0.52)
        ..lineTo(size.width * 0.78 - shift, size.height * 0.37)
        ..close(),
      light,
    );

    final mist = Paint()
      ..color = Colors.white.withValues(alpha: 0.42)
      ..style = PaintingStyle.fill;
    for (var i = 0; i < 4; i++) {
      final y = size.height * (0.52 + i * 0.05);
      canvas.drawOval(
        Rect.fromLTWH(
          size.width * (-0.14 + i * 0.18) - shift,
          y,
          size.width * 0.70,
          size.height * 0.12,
        ),
        mist,
      );
    }

    final ground = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.74)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.64,
        size.width * 0.52,
        size.height * 0.76,
      )
      ..quadraticBezierTo(
        size.width * 0.72,
        size.height * 0.88,
        size.width,
        size.height * 0.70,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(ground, dark);

    if (showPerson) {
      final person = Paint()
        ..color = const Color(0xFF171C19)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = math.max(2, size.width * 0.035);
      final x = size.width * 0.48;
      final y = size.height * 0.70;
      canvas.drawCircle(
          Offset(x, y - size.height * 0.16), size.width * 0.045, person);
      canvas.drawLine(
        Offset(x, y - size.height * 0.11),
        Offset(x, y + size.height * 0.08),
        person,
      );
      canvas.drawLine(
        Offset(x, y - size.height * 0.02),
        Offset(x - size.width * 0.08, y + size.height * 0.06),
        person,
      );
      canvas.drawLine(
        Offset(x, y - size.height * 0.02),
        Offset(x + size.width * 0.08, y + size.height * 0.05),
        person,
      );
      canvas.drawLine(
        Offset(x, y + size.height * 0.08),
        Offset(x - size.width * 0.06, y + size.height * 0.20),
        person,
      );
      canvas.drawLine(
        Offset(x, y + size.height * 0.08),
        Offset(x + size.width * 0.07, y + size.height * 0.20),
        person,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _MountainScenePainter oldDelegate) {
    return oldDelegate.alignment != alignment ||
        oldDelegate.showPerson != showPerson;
  }
}

class _MountainLinePainter extends CustomPainter {
  const _MountainLinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final deepPaint = Paint()
      ..color = AppColors.deepForest
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final fillPaint = Paint()
      ..color = AppColors.forestGreen.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    Path mountain(double left, double base, double width, double height) {
      return Path()
        ..moveTo(left, base)
        ..lineTo(left + width * 0.35, base - height * 0.55)
        ..lineTo(left + width * 0.50, base - height)
        ..lineTo(left + width * 0.68, base - height * 0.50)
        ..lineTo(left + width, base)
        ..close();
    }

    final m1 = mountain(size.width * 0.02, size.height * 0.92,
        size.width * 0.56, size.height * 0.70);
    final m2 = mountain(size.width * 0.30, size.height * 0.92,
        size.width * 0.68, size.height * 0.92);
    canvas.drawPath(m2, fillPaint);
    canvas.drawPath(m1, fillPaint);
    canvas.drawPath(m2, deepPaint);
    canvas.drawPath(m1, deepPaint);

    final ridge = Path()
      ..moveTo(size.width * 0.48, size.height * 0.34)
      ..lineTo(size.width * 0.56, size.height * 0.48)
      ..lineTo(size.width * 0.52, size.height * 0.47)
      ..lineTo(size.width * 0.62, size.height * 0.64);
    canvas.drawPath(ridge, deepPaint);

    final treePaint = Paint()
      ..color = AppColors.deepForest
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 12; i++) {
      final x = size.width * (0.05 + i * 0.075);
      final y = size.height * (0.92 - (i.isEven ? 0.04 : 0));
      canvas.drawLine(Offset(x, y), Offset(x, y - 18), treePaint);
      canvas.drawLine(Offset(x, y - 15), Offset(x - 8, y - 5), treePaint);
      canvas.drawLine(Offset(x, y - 15), Offset(x + 8, y - 5), treePaint);
      canvas.drawLine(Offset(x, y - 9), Offset(x - 6, y - 2), treePaint);
      canvas.drawLine(Offset(x, y - 9), Offset(x + 6, y - 2), treePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BadgePainter extends CustomPainter {
  const _BadgePainter({required this.compact});

  final bool compact;

  @override
  void paint(Canvas canvas, Size size) {
    final badgeWidth = size.width * 0.82;
    final badgeHeight = compact ? size.height * 0.76 : size.height * 0.68;
    final centerX = size.width / 2;
    final top = size.height * 0.04;
    final badge = Path()
      ..moveTo(centerX, top)
      ..lineTo(centerX + badgeWidth * 0.47, top + badgeHeight * 0.18)
      ..lineTo(centerX + badgeWidth * 0.45, top + badgeHeight * 0.72)
      ..lineTo(centerX, top + badgeHeight)
      ..lineTo(centerX - badgeWidth * 0.45, top + badgeHeight * 0.72)
      ..lineTo(centerX - badgeWidth * 0.47, top + badgeHeight * 0.18)
      ..close();

    canvas.drawPath(
      badge,
      Paint()
        ..color = const Color(0xFF8C5E2E)
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      badge,
      Paint()
        ..color = const Color(0xFF6C4521)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    final inner = Path()
      ..moveTo(centerX, top + 7)
      ..lineTo(centerX + badgeWidth * 0.37, top + badgeHeight * 0.22)
      ..lineTo(centerX + badgeWidth * 0.36, top + badgeHeight * 0.66)
      ..lineTo(centerX, top + badgeHeight * 0.90)
      ..lineTo(centerX - badgeWidth * 0.36, top + badgeHeight * 0.66)
      ..lineTo(centerX - badgeWidth * 0.37, top + badgeHeight * 0.22)
      ..close();
    canvas.drawPath(inner, Paint()..color = const Color(0xFF4F7651));

    final mountainPaint = Paint()..color = const Color(0xFFEAF0D5);
    final darkMountainPaint = Paint()..color = const Color(0xFF143D2D);
    final m1 = Path()
      ..moveTo(centerX - badgeWidth * 0.30, top + badgeHeight * 0.62)
      ..lineTo(centerX - badgeWidth * 0.08, top + badgeHeight * 0.28)
      ..lineTo(centerX + badgeWidth * 0.15, top + badgeHeight * 0.62)
      ..close();
    final m2 = Path()
      ..moveTo(centerX - badgeWidth * 0.08, top + badgeHeight * 0.62)
      ..lineTo(centerX + badgeWidth * 0.16, top + badgeHeight * 0.24)
      ..lineTo(centerX + badgeWidth * 0.34, top + badgeHeight * 0.62)
      ..close();
    canvas.drawPath(m1, mountainPaint);
    canvas.drawPath(m2, mountainPaint);
    canvas.drawPath(
      Path()
        ..moveTo(centerX - badgeWidth * 0.22, top + badgeHeight * 0.62)
        ..lineTo(centerX - badgeWidth * 0.08, top + badgeHeight * 0.40)
        ..lineTo(centerX + badgeWidth * 0.05, top + badgeHeight * 0.62)
        ..close(),
      darkMountainPaint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(centerX + badgeWidth * 0.02, top + badgeHeight * 0.62)
        ..lineTo(centerX + badgeWidth * 0.16, top + badgeHeight * 0.40)
        ..lineTo(centerX + badgeWidth * 0.28, top + badgeHeight * 0.62)
        ..close(),
      darkMountainPaint,
    );

    if (!compact) {
      final ribbonTop = size.height * 0.70;
      final ribbon = RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.08, ribbonTop, size.width * 0.84, 20),
        const Radius.circular(4),
      );
      canvas.drawRRect(ribbon, Paint()..color = const Color(0xFF9A5F2E));
      final textPainter = TextPainter(
        text: TextSpan(
          text: 'MOUNTAIN',
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: size.width * 0.13,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);
      textPainter.paint(
        canvas,
        Offset(centerX - textPainter.width / 2, ribbonTop + 3),
      );
    }

    final shine = Paint()
      ..color = const Color(0xFFF3CC72)
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < 5; i++) {
      final angle = -math.pi / 2 + (i - 2) * 0.42;
      final start =
          Offset(centerX - badgeWidth * 0.22, top + badgeHeight * 0.22);
      final end = Offset(
          start.dx + math.cos(angle) * 8, start.dy + math.sin(angle) * 8);
      canvas.drawLine(start, end, shine);
    }
  }

  @override
  bool shouldRepaint(covariant _BadgePainter oldDelegate) =>
      oldDelegate.compact != compact;
}
