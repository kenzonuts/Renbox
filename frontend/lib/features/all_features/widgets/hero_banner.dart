import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/renbok_feature_theme.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  static const double height = 190;
  static const double radius = 24;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.08),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'img/home/home.png',
              fit: BoxFit.cover,
              alignment: const Alignment(0.45, -0.15),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFF7F8EE).withValues(alpha: 0.96),
                    const Color(0xFFE7F0E4).withValues(alpha: 0.88),
                    const Color(0x00E7F0E4),
                  ],
                  stops: const [0, 0.42, 0.78],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 36, 24, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.26),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.eco_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Explore Indonesia',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      color: colors.primary,
                      fontSize: 28,
                      height: 1,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: 220,
                    child: Text(
                      '23 fitur siap membantu\npetualanganmu.',
                      style: GoogleFonts.plusJakartaSans(
                        color: colors.textPrimary,
                        fontSize: 17,
                        height: 1.38,
                        fontWeight: FontWeight.w700,
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
