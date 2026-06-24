import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityStoryDetailScreen extends StatelessWidget {
  const CommunityStoryDetailScreen({super.key});

  static const routePath = '/community-story/sunrise-gunung-prau';

  @override
  Widget build(BuildContext context) {
    final colors = StoryColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _StoryHeader(colors: colors)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
            sliver: SliverList.list(
              children: [
                StoryGallery(colors: colors),
                const SizedBox(height: 16),
                RouteTimeline(colors: colors),
                const SizedBox(height: 16),
                _TipsCard(colors: colors),
                const SizedBox(height: 16),
                _CommentsSection(colors: colors),
                const SizedBox(height: 16),
                _RelatedStoriesSection(colors: colors),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _StoryActionBar(colors: colors),
    );
  }
}

class _StoryHeader extends StatelessWidget {
  const _StoryHeader({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 578,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _HeroImage(colors: colors),
          Positioned(
            left: 16,
            right: 16,
            top: 272,
            child: _AuthorStoryCard(colors: colors),
          ),
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'img/home/home.png',
            fit: BoxFit.cover,
            alignment: const Alignment(0.38, -0.1),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.06),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.72),
                ],
                stops: const [0, 0.34, 1],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: topInset + 12,
            child: Row(
              children: [
                CircleIconButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/main');
                    }
                  },
                ),
                const Spacer(),
                CircleIconButton(
                  icon: Icons.bookmark_border_rounded,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                CircleIconButton(
                  icon: Icons.ios_share_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 34,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.94),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.landscape_rounded,
                          color: Colors.white, size: 15),
                      const SizedBox(width: 7),
                      Text(
                        'Cerita Petualangan',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Sunrise di Gunung Prau',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 30,
                    height: 1.06,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white.withValues(alpha: 0.9),
                      size: 17,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Dieng, Jawa Tengah',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white.withValues(alpha: 0.94),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _HeroMeta(
                      icon: Icons.calendar_month_rounded,
                      label: '18 Mei 2026',
                    ),
                    _HeroMeta(
                      icon: Icons.access_time_rounded,
                      label: '2 jam lalu',
                    ),
                    _HeroMeta(
                      icon: Icons.visibility_outlined,
                      label: '1.248 views',
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

class _HeroMeta extends StatelessWidget {
  const _HeroMeta({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.9), size: 15),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _AuthorStoryCard extends StatelessWidget {
  const _AuthorStoryCard({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      colors: colors,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image.asset(
                  'img/home/home.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  alignment: const Alignment(-0.92, 0.48),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'adventure.kay',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              color: colors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.verified_rounded,
                          color: colors.primary,
                          size: 17,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Explorer Level 8',
                          style: GoogleFonts.plusJakartaSans(
                            color: colors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.workspace_premium_rounded,
                          color: colors.primary,
                          size: 14,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(92, 44),
                  foregroundColor: colors.primary,
                  side: BorderSide(color: colors.primary, width: 1.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                child: const Text('Follow'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(height: 1, color: colors.divider),
          const SizedBox(height: 16),
          Text(
            'Hari ini akhirnya berhasil summit Gunung Prau. Berangkat jam 2 pagi. Jalur cukup ramai, tapi sunrise benar-benar worth it. Kalau mau datang, usahakan musim kemarau ya.',
            style: GoogleFonts.plusJakartaSans(
              color: colors.textPrimary,
              fontSize: 13.5,
              height: 1.65,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          _AdventureSummary(colors: colors),
        ],
      ),
    );
  }
}

class _AdventureSummary extends StatelessWidget {
  const _AdventureSummary({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    const stats = [
      StatData(Icons.terrain_rounded, '2.565 mdpl', 'Ketinggian'),
      StatData(Icons.route_rounded, '6.7 km', 'Jarak'),
      StatData(Icons.timer_outlined, '5 jam', 'Durasi'),
      StatData(Icons.signal_cellular_alt_rounded, 'Sedang', 'Kesulitan'),
      StatData(Icons.wb_sunny_outlined, 'Cerah', 'Cuaca'),
    ];

    return Container(
      height: 104,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.divider),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: stats.length,
        separatorBuilder: (_, __) => VerticalDivider(
          width: 14,
          indent: 24,
          endIndent: 24,
          color: colors.divider,
        ),
        itemBuilder: (context, index) {
          return InfoStatItem(data: stats[index], colors: colors);
        },
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.95),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(icon, color: const Color(0xFF12372A), size: 23),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.colors,
    required this.child,
    this.title,
    this.action,
    this.padding = const EdgeInsets.all(16),
  });

  final StoryColors colors;
  final Widget child;
  final String? title;
  final String? action;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.055),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style: GoogleFonts.plusJakartaSans(
                      color: colors.textPrimary,
                      fontSize: 16,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(width: 12),
                  Text(
                    action!,
                    style: GoogleFonts.plusJakartaSans(
                      color: colors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Icon(Icons.chevron_right_rounded,
                      color: colors.primary, size: 18),
                ],
              ],
            ),
            const SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );
  }
}

class InfoStatItem extends StatelessWidget {
  const InfoStatItem({
    super.key,
    required this.data,
    required this.colors,
  });

  final StatData data;
  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(data.icon, color: colors.primary, size: 24),
          const SizedBox(height: 9),
          Text(
            data.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: colors.textPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            data.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              color: colors.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class StoryGallery extends StatelessWidget {
  const StoryGallery({super.key, required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    const alignments = [
      Alignment(0.42, -0.1),
      Alignment(-0.1, -0.06),
      Alignment(0.58, 0.02),
      Alignment(-0.84, 0.16),
      Alignment(0.2, 0.52),
    ];

    return SectionCard(
      colors: colors,
      title: 'Galeri Foto',
      action: 'Lihat Semua',
      child: SizedBox(
        height: 92,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: alignments.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'img/home/home.png',
                width: 92,
                height: 92,
                fit: BoxFit.cover,
                alignment: alignments[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class RouteTimeline extends StatelessWidget {
  const RouteTimeline({super.key, required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    const stops = [
      RouteStop('Basecamp Patak Banteng', '1.650 mdpl'),
      RouteStop('Pos 1', '2.000 mdpl'),
      RouteStop('Pos 2', '2.400 mdpl'),
      RouteStop('Puncak Prau', '2.565 mdpl'),
    ];

    return SectionCard(
      colors: colors,
      title: 'Rute Perjalanan',
      child: Column(
        children: [
          for (var i = 0; i < stops.length; i++)
            _RouteStopItem(
              stop: stops[i],
              colors: colors,
              isFirst: i == 0,
              isLast: i == stops.length - 1,
            ),
        ],
      ),
    );
  }
}

class _RouteStopItem extends StatelessWidget {
  const _RouteStopItem({
    required this.stop,
    required this.colors,
    required this.isFirst,
    required this.isLast,
  });

  final RouteStop stop;
  final StoryColors colors;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(child: Container(width: 1, color: colors.divider))
                else
                  const SizedBox(height: 0),
                Container(
                  width: isFirst || isLast ? 34 : 16,
                  height: isFirst || isLast ? 34 : 16,
                  decoration: BoxDecoration(
                    color: isFirst || isLast
                        ? colors.primary.withValues(alpha: 0.1)
                        : colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: isFirst || isLast
                      ? Icon(
                          isLast ? Icons.terrain_rounded : Icons.flag_rounded,
                          color: colors.primary,
                          size: 19,
                        )
                      : null,
                ),
                if (!isLast)
                  Expanded(child: Container(width: 1, color: colors.divider))
                else
                  const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 3, bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stop.title,
                    style: GoogleFonts.plusJakartaSans(
                      color: colors.textPrimary,
                      fontSize: 13.5,
                      height: 1.25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stop.subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      color: colors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  const _TipsCard({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    const tips = [
      'Datang jam 2 pagi untuk dapat spot terbaik',
      'Bawa sarung tangan, udara dingin sekali',
      'Bawa air minimal 2 liter',
      'Sunrise terbaik sekitar jam 05.20',
      'Jangan lupa bawa trash bag',
    ];

    return SectionCard(
      colors: colors,
      title: 'Tips dari Pendaki',
      child: Column(
        children: [
          for (var i = 0; i < tips.length; i++)
            Padding(
              padding: EdgeInsets.only(bottom: i == tips.length - 1 ? 0 : 12),
              child: ChecklistItem(text: tips[i], colors: colors),
            ),
        ],
      ),
    );
  }
}

class ChecklistItem extends StatelessWidget {
  const ChecklistItem({
    super.key,
    required this.text,
    required this.colors,
  });

  final String text;
  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: colors.primary,
            size: 19,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              color: colors.textPrimary,
              fontSize: 13,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _CommentsSection extends StatelessWidget {
  const _CommentsSection({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    const comments = [
      CommentData(
        'Rina Amelia',
        '1 jam lalu',
        'Masih ramai ga pas weekend?',
        Alignment(-0.72, 0.44),
      ),
      CommentData(
        'Budi Setiawan',
        '58 menit lalu',
        'Weekend kemarin lumayan penuh, tapi masih aman kok.',
        Alignment(-0.2, 0.24),
      ),
      CommentData(
        'Kenzo',
        '30 menit lalu',
        'Thanks infonya! Jadi lebih siap berangkat nanti.',
        Alignment(0.3, 0.35),
      ),
    ];

    return SectionCard(
      colors: colors,
      title: 'Komentar (24)',
      action: 'Lihat Semua',
      child: Column(
        children: [
          for (var i = 0; i < comments.length; i++) ...[
            CommentItem(data: comments[i], colors: colors),
            if (i < comments.length - 1)
              Divider(height: 20, color: colors.divider),
          ],
        ],
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.data,
    required this.colors,
  });

  final CommentData data;
  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            'img/home/home.png',
            width: 38,
            height: 38,
            fit: BoxFit.cover,
            alignment: data.avatarAlignment,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      data.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.plusJakartaSans(
                        color: colors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data.time,
                    style: GoogleFonts.plusJakartaSans(
                      color: colors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                data.text,
                style: GoogleFonts.plusJakartaSans(
                  color: colors.textPrimary,
                  fontSize: 12.5,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.more_horiz_rounded, color: colors.textSecondary, size: 20),
      ],
    );
  }
}

class _RelatedStoriesSection extends StatelessWidget {
  const _RelatedStoriesSection({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    const stories = [
      RelatedStoryData(
        'Pendakian Gunung Andong via Sawit',
        '@budi.pndk',
        Alignment(0.15, -0.02),
      ),
      RelatedStoryData(
        'Curug Cimahi di Musim Hujan',
        '@rita.outdoor',
        Alignment(-0.7, 0.05),
      ),
      RelatedStoryData(
        'Pantai Menganti Hidden Gem Kebumen',
        '@explorejawa',
        Alignment(0.9, 0.16),
      ),
    ];

    return SectionCard(
      colors: colors,
      title: 'Cerita Lainnya dari Komunitas',
      action: 'Lihat Semua',
      child: SizedBox(
        height: 116,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: stories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return RelatedStoryCard(data: stories[index], colors: colors);
          },
        ),
      ),
    );
  }
}

class RelatedStoryCard extends StatelessWidget {
  const RelatedStoryCard({
    super.key,
    required this.data,
    required this.colors,
  });

  final RelatedStoryData data;
  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'img/home/home.png',
              fit: BoxFit.cover,
              alignment: data.imageAlignment,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.68),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 14,
              right: 14,
              bottom: 13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'oleh ${data.author}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withValues(alpha: 0.86),
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
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

class _StoryActionBar extends StatelessWidget {
  const _StoryActionBar({required this.colors});

  final StoryColors colors;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      height: 88 + bottomInset,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottomInset),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.97),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.favorite_border_rounded,
              label: 'Suka',
              colors: colors,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ActionButton(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'Komentar',
              colors: colors,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ActionButton(
              icon: Icons.near_me_rounded,
              label: 'Bagikan',
              colors: colors,
              isPrimary: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.colors,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final StoryColors colors;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary
          ? colors.primary
          : colors.textSecondary.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : colors.primary,
                size: 21,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: isPrimary ? Colors.white : colors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoryColors {
  const StoryColors({
    required this.background,
    required this.surface,
    required this.primary,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
  });

  final Color background;
  final Color surface;
  final Color primary;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;

  factory StoryColors.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return const StoryColors(
        background: Color(0xFF07130F),
        surface: Color(0xFF101F19),
        primary: Color(0xFF5BD6B0),
        textPrimary: Color(0xFFF3F7F4),
        textSecondary: Color(0xFFBAC5BF),
        divider: Color(0xFF233A31),
      );
    }

    return const StoryColors(
      background: Color(0xFFF8F5F0),
      surface: Colors.white,
      primary: Color(0xFF006B4F),
      textPrimary: Color(0xFF12372A),
      textSecondary: Color(0xFF6B7280),
      divider: Color(0xFFE8E2DA),
    );
  }
}

class StatData {
  const StatData(this.icon, this.value, this.label);

  final IconData icon;
  final String value;
  final String label;
}

class RouteStop {
  const RouteStop(this.title, this.subtitle);

  final String title;
  final String subtitle;
}

class CommentData {
  const CommentData(
    this.name,
    this.time,
    this.text,
    this.avatarAlignment,
  );

  final String name;
  final String time;
  final String text;
  final Alignment avatarAlignment;
}

class RelatedStoryData {
  const RelatedStoryData(
    this.title,
    this.author,
    this.imageAlignment,
  );

  final String title;
  final String author;
  final Alignment imageAlignment;
}
