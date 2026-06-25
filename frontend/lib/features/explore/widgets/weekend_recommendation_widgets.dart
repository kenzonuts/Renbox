import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/renbok_feature_theme.dart';
import '../../main/widgets/renbok_bottom_navigation.dart';
import '../models/weekend_destination.dart';
import '../screens/weekend_recommendation_detail_screen.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 56,
    this.iconSize = 28,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.07),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: colors.primary, size: iconSize),
          ),
        ),
      ),
    );
  }
}

class WeekendCategoryChip extends StatelessWidget {
  const WeekendCategoryChip({
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
    final colors = _colors(context);

    return Material(
      color: selected ? colors.primary : Colors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: 46,
          constraints: BoxConstraints(minWidth: selected ? 116 : 0),
          padding: EdgeInsets.symmetric(horizontal: selected ? 22 : 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.055),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!selected) ...[
                Icon(icon, color: colors.primary, size: 22),
                const SizedBox(width: 11),
              ],
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: selected ? Colors.white : colors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeekendHeroBanner extends StatelessWidget {
  const WeekendHeroBanner({super.key});

  static const _imageUrl =
      'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?auto=format&fit=crop&w=1200&q=85';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
      child: Container(
        height: 230,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              _imageUrl,
              fit: BoxFit.cover,
              alignment: const Alignment(0.15, 0),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.78),
                    Colors.black.withValues(alpha: 0.38),
                    Colors.transparent,
                  ],
                  stops: const [0, 0.45, 0.82],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekend Trip\nTerbaik',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 30,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: 230,
                    child: Text(
                      'Destinasi pendek, aman, dan\ncocok buat 1-2 hari.',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontSize: 17,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const _SocialProof(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortRow extends StatelessWidget {
  const SortRow({
    super.key,
    required this.onSortTap,
    required this.onLocationTap,
  });

  final VoidCallback onSortTap;
  final VoidCallback onLocationTap;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(17, 22, 17, 16),
      child: Row(
        children: [
          Text(
            'Urutkan:',
            style: GoogleFonts.plusJakartaSans(
              color: colors.textSecondary,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: onSortTap,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.045),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      'Terdekat',
                      style: GoogleFonts.plusJakartaSans(
                        color: colors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: colors.textPrimary,
                      size: 23,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Material(
            color: colors.primaryLight.withValues(alpha: 0.52),
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              onTap: onLocationTap,
              borderRadius: BorderRadius.circular(999),
              child: SizedBox(
                height: 44,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Row(
                    children: [
                      Icon(Icons.my_location_rounded,
                          color: colors.primary, size: 20),
                      const SizedBox(width: 9),
                      Text(
                        'Lokasi Saya',
                        style: GoogleFonts.plusJakartaSans(
                          color: colors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeekendDestinationCard extends StatelessWidget {
  const WeekendDestinationCard({
    super.key,
    required this.destination,
    required this.saved,
    required this.onSaveTap,
  });

  final WeekendDestination destination;
  final bool saved;
  final VoidCallback onSaveTap;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 22,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DestinationImage(destination: destination),
          const SizedBox(width: 13),
          Expanded(
            child: SizedBox(
              height: 145,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                destination.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.plusJakartaSans(
                                  color: colors.textPrimary,
                                  fontSize: 18,
                                  height: 1.08,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: onSaveTap,
                              borderRadius: BorderRadius.circular(999),
                              child: Icon(
                                saved
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_border_rounded,
                                color: colors.primary,
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _MetadataRow(
                          icon: Icons.location_on_rounded,
                          text: destination.location,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFF5A400), size: 16),
                            const SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '${destination.rating} (${destination.reviews})',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: _metaStyle(colors),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: Text('•', style: _metaStyle(colors)),
                            ),
                            Icon(Icons.schedule_rounded,
                                color: colors.textSecondary, size: 15),
                            const SizedBox(width: 5),
                            Text(destination.duration,
                                style: _metaStyle(colors)),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Wrap(
                          spacing: 7,
                          runSpacing: 5,
                          children: [
                            InfoChip(
                              icon: destination.difficulty == 'Sedang'
                                  ? Icons.hiking_rounded
                                  : Icons.terrain_rounded,
                              label: destination.difficulty,
                              accentColor: destination.difficulty == 'Sedang'
                                  ? const Color(0xFFD68111)
                                  : const Color(0xFF279653),
                            ),
                            InfoChip(
                              icon: Icons.account_balance_wallet_rounded,
                              label: destination.budget,
                              accentColor: colors.primary,
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        _MetadataRow(
                          icon: destination.weather.startsWith('24')
                              ? Icons.wb_sunny_outlined
                              : Icons.cloud_outlined,
                          text: destination.weather,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          destination.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: colors.textSecondary,
                            fontSize: 11.2,
                            height: 1.22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _DetailButton(colors: colors),
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

class InfoChip extends StatelessWidget {
  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.accentColor,
  });

  final IconData icon;
  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: accentColor, size: 12),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: accentColor,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class RenbokBottomNav extends StatelessWidget {
  const RenbokBottomNav({super.key});

  @override
  Widget build(BuildContext context) => const RenbokBottomNavigation(
        currentIndex: 0,
      );
}

class _SocialProof extends StatelessWidget {
  const _SocialProof();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 62,
          height: 32,
          child: Stack(
            children: [
              _ProofAvatar(left: 0, color: Color(0xFFE6C4AF)),
              _ProofAvatar(left: 19, color: Color(0xFFB7D1C7)),
              _ProofAvatar(left: 38, color: Color(0xFFE4AD92)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '12K+',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 13,
                height: 1.15,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'Explorer sudah menikmati',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white.withValues(alpha: 0.92),
                fontSize: 11,
                height: 1.25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProofAvatar extends StatelessWidget {
  const _ProofAvatar({required this.left, required this.color});

  final double left;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: 0,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: const Icon(Icons.person_rounded, color: Colors.white, size: 19),
      ),
    );
  }
}

class _DestinationImage extends StatelessWidget {
  const _DestinationImage({required this.destination});

  final WeekendDestination destination;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 145,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              destination.imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 126),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xCC12372A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(destination.imageLabelIcon,
                          color: const Color(0xFF76C893), size: 13),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          destination.imageLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  const _MetadataRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = _colors(context);

    return Row(
      children: [
        Icon(icon, color: colors.textSecondary, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: _metaStyle(colors),
          ),
        ),
      ],
    );
  }
}

class _DetailButton extends StatelessWidget {
  const _DetailButton({required this.colors});

  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colors.primary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push(WeekendRecommendationDetailScreen.routePath),
        child: SizedBox(
          height: 36,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Lihat Detail',
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_rounded,
                    color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextStyle _metaStyle(RenbokFeatureTheme colors) {
  return GoogleFonts.plusJakartaSans(
    color: colors.textSecondary,
    fontSize: 12.5,
    height: 1.1,
    fontWeight: FontWeight.w600,
  );
}

RenbokFeatureTheme _colors(BuildContext context) {
  return Theme.of(context).extension<RenbokFeatureTheme>() ??
      RenbokFeatureTheme.defaults;
}
