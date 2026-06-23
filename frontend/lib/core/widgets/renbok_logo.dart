import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_constants.dart';
import '../theme/app_colors.dart';

class RenbokLogo extends StatelessWidget {
  const RenbokLogo({super.key, this.size = 32, this.showSubtitle = false});

  final double size;
  final bool showSubtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRect(
          child: SizedBox(
            width: size * 5.85,
            height: size * 1.08,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.center,
              child: Image.asset('img/logo/Logo.png'),
            ),
          ),
        ),
        if (showSubtitle) ...[
          SizedBox(height: size * 0.14),
          Text(
            AppConstants.tagline,
            style: GoogleFonts.plusJakartaSans(
              fontSize: size * 0.38,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ],
    );
  }
}
