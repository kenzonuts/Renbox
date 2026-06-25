import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/dummy_data.dart';
import '../../../core/widgets/loading_view.dart';
import '../../../models/location_model.dart';
import '../../../services/api_service.dart';

class LocationDetailScreen extends ConsumerWidget {
  const LocationDetailScreen({super.key, required this.slug});

  final String slug;

  static const _fallbackHeroImage =
      'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=86';

  static const _galleryImages = [
    'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=600&q=82',
    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=600&q=82',
    'https://images.unsplash.com/photo-1470770903676-69b98201ea1c?auto=format&fit=crop&w=600&q=82',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=600&q=82',
    'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=600&q=82',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<LocationModel?>(
      future: ref.read(apiServiceProvider).getLocationBySlug(slug),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: LoadingView());
        }

        final location = snapshot.data ??
            DummyData.popularLocations.firstWhere(
              (l) => l.slug == slug,
              orElse: () => DummyData.featuredLocation,
            );

        return _LocationDetailView(location: location);
      },
    );
  }
}

class _LocationDetailView extends StatelessWidget {
  const _LocationDetailView({required this.location});

  final LocationModel location;

  String get _heroImage =>
      location.coverImageUrl ?? LocationDetailScreen._fallbackHeroImage;

  String get _level {
    if (location.difficulty == 'hard' || location.difficulty == 'extreme') {
      return 'Sulit';
    }
    return location.difficultyLabel == '-'
        ? 'Sedang'
        : location.difficultyLabel;
  }

  String get _altitude => '${location.altitude ?? 2565} mdpl';

  String get _rating => (location.ratingAverage ?? 4.8).toStringAsFixed(1);

  String get _reviews => '${location.reviewsCount ?? 890} ulasan';

  String get _region => location.locationLine.isEmpty
      ? 'Dieng, Jawa Tengah'
      : location.locationLine;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.black,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFAF7),
        body: Stack(
          children: [
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: _HeroHeader(
                    imageUrl: _heroImage,
                    title: location.name,
                    region: _region,
                    rating: _rating,
                    reviews: _reviews,
                    level: _level,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 7,
                          child: _PrimaryActionButton(
                            icon: Icons.near_me_rounded,
                            label: 'Mulai Navigasi',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 4,
                          child: _SecondaryActionButton(
                            icon: Icons.add_rounded,
                            label: 'Simpan',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _SectionCard(
                    title: 'Info Cepat',
                    child: _QuickInfoGrid(altitude: _altitude, level: _level),
                  ),
                ),
                const SliverToBoxAdapter(child: _AccessSection()),
                const SliverToBoxAdapter(child: _NeedToKnowSection()),
                const SliverToBoxAdapter(child: _GallerySection()),
                SliverToBoxAdapter(
                  child: SizedBox(height: 110 + bottomInset),
                ),
              ],
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10 + bottomInset,
              child: const _BottomActionBar(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({
    required this.imageUrl,
    required this.title,
    required this.region,
    required this.rating,
    required this.reviews,
    required this.level,
  });

  final String imageUrl;
  final String title;
  final String region;
  final String rating;
  final String reviews;
  final String level;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(26)),
      child: SizedBox(
        height: 390,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
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
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.2),
                    AppColors.deepForest.withValues(alpha: 0.88),
                  ],
                  stops: const [0, 0.46, 1],
                ),
              ),
            ),
            SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CircleIconButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/main/explore');
                        }
                      },
                    ),
                    const Spacer(),
                    const _CircleIconButton(
                        icon: Icons.bookmark_border_rounded),
                    const SizedBox(width: 12),
                    const _CircleIconButton(icon: Icons.share_outlined),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 22,
              right: 22,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 31,
                      fontWeight: FontWeight.w800,
                      height: 1.06,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          region,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppColors.starGold, size: 22),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          '$rating ($reviews)',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '•',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.terrain_rounded,
                          color: Color(0xFFFFA83D), size: 20),
                      const SizedBox(width: 6),
                      Text(
                        level,
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      const _DistancePill(),
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

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 54,
          height: 54,
          child: Icon(icon, color: AppColors.deepForest, size: 26),
        ),
      ),
    );
  }
}

class _DistancePill extends StatelessWidget {
  const _DistancePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF08785F),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_rounded, color: Colors.white, size: 17),
          const SizedBox(width: 6),
          Text(
            '6.5 km dari lokasimu',
            style: GoogleFonts.plusJakartaSans(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryActionButton extends StatelessWidget {
  const _PrimaryActionButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0B8A66), Color(0xFF05684F)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepForest.withValues(alpha: 0.14),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 23),
              const SizedBox(width: 11),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 15,
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

class _SecondaryActionButton extends StatelessWidget {
  const _SecondaryActionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
      shadowColor: AppColors.deepForest.withValues(alpha: 0.12),
      elevation: 8,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.deepForest, size: 25),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.deepForest,
                  fontSize: 14,
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

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepForest.withValues(alpha: 0.07),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF0B1534),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }
}

class _QuickInfoGrid extends StatelessWidget {
  const _QuickInfoGrid({required this.altitude, required this.level});

  final String altitude;
  final String level;

  @override
  Widget build(BuildContext context) {
    final items = [
      const _QuickInfoItem(
        icon: Icons.route_rounded,
        title: 'Jarak',
        value: '6.5 km',
        subtitle: 'dari lokasimu',
      ),
      const _QuickInfoItem(
        icon: Icons.schedule_rounded,
        title: 'Estimasi Tiba',
        value: '18 menit',
        subtitle: 'dengan mobil',
      ),
      const _QuickInfoItem(
        icon: Icons.cloud_queue_rounded,
        title: 'Cuaca',
        value: '18C - 26C',
        subtitle: 'Cerah Berawan',
      ),
      const _QuickInfoItem(
        icon: Icons.verified_user_outlined,
        title: 'Status Jalur',
        value: 'Aman',
        subtitle: 'Kondisi baik',
      ),
      _QuickInfoItem(
        icon: Icons.terrain_rounded,
        title: 'Tinggi',
        value: altitude,
        subtitle: 'di atas permukaan laut',
      ),
      _QuickInfoItem(
        icon: Icons.bar_chart_rounded,
        title: 'Level',
        value: level,
        subtitle: 'Cocok untuk pemula',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 340;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isNarrow ? 2 : 3,
            mainAxisExtent: 82,
            crossAxisSpacing: 10,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (_, index) => items[index],
        );
      },
    );
  }
}

class _QuickInfoItem extends StatelessWidget {
  const _QuickInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1EC),
            borderRadius: BorderRadius.circular(26),
          ),
          child: Icon(icon, color: const Color(0xFF08785F), size: 27),
        ),
        const SizedBox(width: 10),
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
                  color: const Color(0xFF526078),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF08785F),
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: const Color(0xFF526078),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccessSection extends StatelessWidget {
  const _AccessSection();

  @override
  Widget build(BuildContext context) {
    return const _SectionCard(
      title: 'Akses dari Lokasimu',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _AccessCard(
                  icon: Icons.directions_car_filled_rounded,
                  title: 'Mobil',
                  time: '18 menit',
                  via: 'via Jl. Dieng',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _AccessCard(
                  icon: Icons.motorcycle_rounded,
                  title: 'Motor',
                  time: '14 menit',
                  via: 'via Jl. Dieng',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _AccessCard(
                  icon: Icons.directions_walk_rounded,
                  title: 'Jalan Kaki',
                  time: '1 jam 20 mnt',
                  via: 'via Jalur Patak',
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          _RouteLine(),
        ],
      ),
    );
  }
}

class _AccessCard extends StatelessWidget {
  const _AccessCard({
    required this.icon,
    required this.title,
    required this.time,
    required this.via,
  });

  final IconData icon;
  final String title;
  final String time;
  final String via;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAF8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF08785F), size: 29),
          const SizedBox(width: 9),
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
                    color: const Color(0xFF526078),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF0B1534),
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  via,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF526078),
                    fontSize: 9,
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

class _RouteLine extends StatelessWidget {
  const _RouteLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF5F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 12,
                  right: 50,
                  child: Container(
                    height: 2,
                    color: const Color(0xFF08785F).withValues(alpha: 0.45),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _RouteDot(icon: null),
                    _RouteDot(icon: null),
                    _RouteDot(icon: Icons.location_on_rounded),
                  ],
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _RouteLabel(title: 'Lokasimu', value: '0 km'),
              _RouteLabel(title: 'Basecamp Patak Banteng', value: '5.2 km'),
              _RouteLabel(title: 'Gunung Prau', value: '6.5 km'),
            ],
          ),
        ],
      ),
    );
  }
}

class _RouteDot extends StatelessWidget {
  const _RouteDot({this.icon});

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Icon(icon, color: const Color(0xFF08785F), size: 31);
    }
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: Color(0xFF08785F),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _RouteLabel extends StatelessWidget {
  const _RouteLabel({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 92,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF08785F),
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              color: const Color(0xFF0B1534),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeedToKnowSection extends StatelessWidget {
  const _NeedToKnowSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Yang Perlu Kamu Tahu',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 340;
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _NeedChip(
                width: isNarrow ? constraints.maxWidth : 136,
                icon: Icons.wb_sunny_outlined,
                label: 'Jalur populer\nuntuk sunrise',
              ),
              _NeedChip(
                width: isNarrow ? constraints.maxWidth : 116,
                icon: Icons.local_parking_rounded,
                label: 'Parkir\ntersedia',
              ),
              _NeedChip(
                width: isNarrow ? constraints.maxWidth : 132,
                icon: Icons.hiking_rounded,
                label: 'Cocok untuk\npemula',
              ),
              _NeedChip(
                width: isNarrow ? constraints.maxWidth : 138,
                icon: Icons.groups_2_outlined,
                label: 'Ramai saat\nweekend',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NeedChip extends StatelessWidget {
  const _NeedChip({
    required this.width,
    required this.icon,
    required this.label,
  });

  final double width;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAF8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF08785F), size: 27),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                color: const Color(0xFF0B1534),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  const _GallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Galeri',
      child: Column(
        children: [
          Transform.translate(
            offset: const Offset(0, -41),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                iconAlignment: IconAlignment.end,
                icon: const Icon(Icons.arrow_forward_rounded, size: 17),
                label: const Text('Lihat Semua'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF08785F),
                  textStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -28),
            child: SizedBox(
              height: 112,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: LocationDetailScreen._galleryImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, index) {
                  return _GalleryImage(
                    url: LocationDetailScreen._galleryImages[index],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 0),
        ],
      ),
    );
  }
}

class _GalleryImage extends StatelessWidget {
  const _GalleryImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 128,
        height: 112,
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(color: AppColors.stone),
          errorWidget: (_, __, ___) => Container(color: AppColors.stone),
        ),
      ),
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepForest.withValues(alpha: 0.13),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 4,
            child: _SecondaryActionButton(
              icon: Icons.bookmark_border_rounded,
              label: 'Simpan',
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            flex: 7,
            child: _PrimaryActionButton(
              icon: Icons.near_me_rounded,
              label: 'Mulai Navigasi',
            ),
          ),
        ],
      ),
    );
  }
}
