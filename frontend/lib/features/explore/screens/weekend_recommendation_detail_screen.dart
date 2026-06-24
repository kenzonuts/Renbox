import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class WeekendRecommendationDetailScreen extends StatelessWidget {
  const WeekendRecommendationDetailScreen({super.key});

  static const routePath = '/weekend-recommendation/gunung-prau';

  @override
  Widget build(BuildContext context) {
    final palette = _DestinationPalette.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      extendBody: true,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _HeroAndQuickInfo(palette: palette),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
                sliver: SliverList.list(
                  children: [
                    _WhyWeekendCard(palette: palette),
                    const SizedBox(height: 16),
                    _ItineraryCard(palette: palette),
                    const SizedBox(height: 16),
                    _PhotoGalleryCard(palette: palette),
                    const SizedBox(height: 16),
                    _FacilitiesCard(palette: palette),
                    const SizedBox(height: 16),
                    _ReviewCard(palette: palette),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _StickyBottomCta(palette: palette),
          ),
        ],
      ),
    );
  }
}

class _HeroAndQuickInfo extends StatelessWidget {
  const _HeroAndQuickInfo({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 414,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _HeroSection(palette: palette),
          Positioned(
            left: 16,
            right: 16,
            top: 270,
            child: _QuickInfoCard(palette: palette),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 320,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'img/home/home.png',
            fit: BoxFit.cover,
            alignment: const Alignment(0.42, -0.08),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.10),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.72),
                ],
                stops: const [0, 0.38, 1],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            top: topInset + 12,
            child: Row(
              children: [
                _HeroCircleButton(
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
                _HeroCircleButton(
                  icon: Icons.bookmark_border_rounded,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                _HeroCircleButton(
                  icon: Icons.ios_share_rounded,
                  onTap: () {},
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _HeroBadge(palette: palette),
                const SizedBox(height: 12),
                Text(
                  'Gunung Prau',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 36,
                    height: 1.02,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.white.withValues(alpha: 0.86),
                      size: 17,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Dieng, Jawa Tengah',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFB703),
                      size: 19,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '4.9  (1.248 ulasan)',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _HeroChip(label: 'Weekend Friendly'),
                    _HeroChip(label: 'Sunrise Spot', color: Color(0xFFC57A10)),
                    _HeroChip(label: 'Pemula Aman', color: Color(0xFF135CA6)),
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

class _HeroCircleButton extends StatelessWidget {
  const _HeroCircleButton({required this.icon, required this.onTap});

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
          child: Icon(icon, color: const Color(0xFF12372A), size: 24),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: palette.primary.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified_outlined, color: Colors.white, size: 15),
          const SizedBox(width: 7),
          Text(
            'REKOMENDASI AKHIR PEKAN',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 11,
              letterSpacing: 0.35,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroChip extends StatelessWidget {
  const _HeroChip({
    required this.label,
    this.color = const Color(0xFF006B4F),
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _QuickInfoCard extends StatelessWidget {
  const _QuickInfoCard({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    const items = [
      _InfoData(Icons.schedule_rounded, 'Estimasi Waktu', '1 Hari'),
      _InfoData(Icons.signpost_rounded, 'Jalur', 'Patak Banteng'),
      _InfoData(Icons.terrain_rounded, 'Level', 'Mudah - Sedang'),
      _InfoData(Icons.wb_cloudy_outlined, 'Cuaca', '18° - 26°'),
      _InfoData(Icons.account_balance_wallet_rounded, 'Estimasi Biaya',
          'Rp150k - Rp300k'),
      _InfoData(Icons.landscape_rounded, 'Ketinggian', '2.565 mdpl'),
    ];

    return _PremiumCard(
      palette: palette,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 140,
        child: Column(
          children: [
            for (var row = 0; row < 3; row++) ...[
              Expanded(
                child: Row(
                  children: [
                    _QuickInfoItem(data: items[row * 2], palette: palette),
                    _SoftDivider.vertical(palette),
                    _QuickInfoItem(data: items[row * 2 + 1], palette: palette),
                  ],
                ),
              ),
              if (row < 2) _SoftDivider.horizontal(palette),
            ],
          ],
        ),
      ),
    );
  }
}

class _QuickInfoItem extends StatelessWidget {
  const _QuickInfoItem({required this.data, required this.palette});

  final _InfoData data;
  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(data.icon, color: palette.primary, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: palette.textSecondary,
                      fontSize: 10,
                      height: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: palette.textPrimary,
                      fontSize: 12.5,
                      height: 1,
                      fontWeight: FontWeight.w800,
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

class _WhyWeekendCard extends StatelessWidget {
  const _WhyWeekendCard({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    const items = [
      'Bisa berangkat Jumat malam',
      'Sunrise view sangat indah',
      'Jalur populer dan ramai pendaki',
      'Cocok untuk pemula',
    ];

    return _SectionCard(
      palette: palette,
      title: 'Kenapa Cocok Akhir Pekan?',
      child: Column(
        children: [
          for (final item in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _ChecklistItem(text: item, palette: palette),
            ),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({required this.text, required this.palette});

  final String text;
  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: palette.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.plusJakartaSans(
              color: palette.textPrimary,
              fontSize: 13,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _ItineraryCard extends StatelessWidget {
  const _ItineraryCard({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    const items = [
      _TimelineData('Jumat', '21.00', 'Berangkat dari kota',
          'Disarankan berangkat malam hari', Icons.circle_rounded),
      _TimelineData('Sabtu', '04.00', 'Mulai pendakian',
          'Dari basecamp ke puncak', Icons.hiking_rounded),
      _TimelineData('', '05.30', 'Sunrise di Puncak Prau',
          'Nikmati golden sunrise & foto terbaik', Icons.wb_sunny_rounded),
      _TimelineData('', '09.00', 'Turun dari puncak', 'Kembali ke basecamp',
          Icons.south_rounded),
      _TimelineData('', '12.00', 'Makan & perjalanan pulang',
          'Sampai rumah sore/malam', Icons.restaurant_rounded),
    ];

    return _SectionCard(
      palette: palette,
      title: 'Rencana Itinerary Singkat',
      child: Column(
        children: [
          for (var i = 0; i < items.length; i++)
            _TimelineItem(
              data: items[i],
              palette: palette,
              isFirst: i == 0,
              isLast: i == items.length - 1,
            ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.data,
    required this.palette,
    required this.isFirst,
    required this.isLast,
  });

  final _TimelineData data;
  final _DestinationPalette palette;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 84,
            child: Align(
              alignment: Alignment.topLeft,
              child: data.day.isEmpty
                  ? const SizedBox(height: 30)
                  : Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: palette.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        data.day.toUpperCase(),
                        style: GoogleFonts.plusJakartaSans(
                          color: palette.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(
            width: 34,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    child: Container(width: 1, color: palette.divider),
                  )
                else
                  const SizedBox(height: 0),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isFirst ? palette.primary : palette.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isFirst
                          ? palette.primary
                          : palette.primary.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Icon(
                    data.icon,
                    color: isFirst ? Colors.white : palette.primary,
                    size: isFirst ? 9 : 16,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 1, color: palette.divider),
                  )
                else
                  const SizedBox(height: 18),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 52,
            child: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                data.time,
                style: GoogleFonts.plusJakartaSans(
                  color: palette.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 5,
                bottom: isLast ? 0 : 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: GoogleFonts.plusJakartaSans(
                      color: palette.textPrimary,
                      fontSize: 13,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      color: palette.textSecondary,
                      fontSize: 11.5,
                      height: 1.35,
                      fontWeight: FontWeight.w500,
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

class _PhotoGalleryCard extends StatelessWidget {
  const _PhotoGalleryCard({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    const alignments = [
      Alignment(0.5, -0.2),
      Alignment(-0.2, -0.08),
      Alignment(0.0, 0.45),
      Alignment(0.85, -0.16),
    ];

    return _SectionCard(
      palette: palette,
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

class _FacilitiesCard extends StatelessWidget {
  const _FacilitiesCard({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    const items = [
      _FacilityData(Icons.local_parking_rounded, 'Parkir'),
      _FacilityData(Icons.wc_rounded, 'Toilet'),
      _FacilityData(Icons.storefront_rounded, 'Warung'),
      _FacilityData(Icons.festival_rounded, 'Camping'),
      _FacilityData(Icons.account_balance_rounded, 'Mushola'),
    ];

    return _SectionCard(
      palette: palette,
      title: 'Fasilitas',
      child: SizedBox(
        height: 78,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              _FacilityItem(data: item, palette: palette),
          ],
        ),
      ),
    );
  }
}

class _FacilityItem extends StatelessWidget {
  const _FacilityItem({required this.data, required this.palette});

  final _FacilityData data;
  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: palette.primary.withValues(alpha: 0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(data.icon, color: palette.primary, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            data.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: palette.textPrimary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      palette: palette,
      title: 'Ulasan Pendaki',
      action: 'Lihat Semua',
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: palette.background,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: palette.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'img/home/home.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    alignment: const Alignment(-0.95, 0.45),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rina Amelia',
                        style: GoogleFonts.plusJakartaSans(
                          color: palette.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '2 minggu lalu',
                        style: GoogleFonts.plusJakartaSans(
                          color: palette.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA60A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: Colors.white, size: 15),
                      const SizedBox(width: 4),
                      Text(
                        '5.0',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Sunrise terbaik yang pernah saya lihat. Jalurnya aman, ramai, dan cocok untuk pendaki pemula yang tetap ingin pengalaman gunung yang berkesan.',
              style: GoogleFonts.plusJakartaSans(
                color: palette.textPrimary,
                fontSize: 12.5,
                height: 1.48,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyBottomCta extends StatelessWidget {
  const _StickyBottomCta({required this.palette});

  final _DestinationPalette palette;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Container(
      height: 88 + bottomInset,
      padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottomInset),
      decoration: BoxDecoration(
        color: palette.surface.withValues(alpha: 0.96),
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
            child: _BottomButton(
              label: 'Simpan',
              icon: Icons.bookmark_border_rounded,
              palette: palette,
              isPrimary: false,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _BottomButton(
              label: 'Mulai Rencana',
              icon: Icons.arrow_forward_rounded,
              palette: palette,
              isPrimary: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomButton extends StatelessWidget {
  const _BottomButton({
    required this.label,
    required this.icon,
    required this.palette,
    required this.isPrimary,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final _DestinationPalette palette;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isPrimary ? palette.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isPrimary
                ? null
                : Border.all(color: palette.primary, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isPrimary ? Colors.white : palette.primary,
                size: 21,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: isPrimary ? Colors.white : palette.primary,
                    fontSize: 14,
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.palette,
    required this.title,
    required this.child,
    this.action,
  });

  final _DestinationPalette palette;
  final String title;
  final String? action;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _PremiumCard(
      palette: palette,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    color: palette.primary,
                    fontSize: 16,
                    height: 1.18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (action != null) ...[
                const SizedBox(width: 12),
                Text(
                  action!,
                  style: GoogleFonts.plusJakartaSans(
                    color: palette.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 2),
                Icon(Icons.chevron_right_rounded,
                    color: palette.primary, size: 18),
              ],
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard({
    required this.palette,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final _DestinationPalette palette;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.055),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SoftDivider extends StatelessWidget {
  const _SoftDivider._({required this.palette, required this.isVertical});

  factory _SoftDivider.vertical(_DestinationPalette palette) {
    return _SoftDivider._(palette: palette, isVertical: true);
  }

  factory _SoftDivider.horizontal(_DestinationPalette palette) {
    return _SoftDivider._(palette: palette, isVertical: false);
  }

  final _DestinationPalette palette;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SizedBox(
        height: 30,
        child: VerticalDivider(width: 1, thickness: 1, color: palette.divider),
      );
    }
    return Divider(height: 1, thickness: 1, color: palette.divider);
  }
}

class _DestinationPalette {
  const _DestinationPalette({
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

  factory _DestinationPalette.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return const _DestinationPalette(
        background: Color(0xFF07130F),
        surface: Color(0xFF101F19),
        primary: Color(0xFF5BD6B0),
        textPrimary: Color(0xFFF3F7F4),
        textSecondary: Color(0xFFBAC5BF),
        divider: Color(0xFF233A31),
      );
    }

    return const _DestinationPalette(
      background: Color(0xFFF8F5F0),
      surface: Colors.white,
      primary: Color(0xFF006B4F),
      textPrimary: Color(0xFF12372A),
      textSecondary: Color(0xFF6B7280),
      divider: Color(0xFFE8E2DA),
    );
  }
}

class _InfoData {
  const _InfoData(this.icon, this.label, this.value);

  final IconData icon;
  final String label;
  final String value;
}

class _TimelineData {
  const _TimelineData(
    this.day,
    this.time,
    this.title,
    this.subtitle,
    this.icon,
  );

  final String day;
  final String time;
  final String title;
  final String subtitle;
  final IconData icon;
}

class _FacilityData {
  const _FacilityData(this.icon, this.label);

  final IconData icon;
  final String label;
}
