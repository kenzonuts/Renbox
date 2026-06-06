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
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _MountainIcon(size: size * 0.82),
            SizedBox(width: size * 0.32),
            _Wordmark(size: size),
          ],
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

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final letterStyle = GoogleFonts.outfit(
      fontSize: size,
      fontWeight: FontWeight.w900,
      height: 1,
      letterSpacing: size * 0.14,
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          AppColors.deepForest,
          AppColors.forestGreen,
          Color(0xFF40916C),
        ],
        stops: [0.0, 0.55, 1.0],
      ).createShader(bounds),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'REN', style: letterStyle),
            TextSpan(
              text: 'BOK',
              style: letterStyle.copyWith(
                letterSpacing: size * 0.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MountainIcon extends StatelessWidget {
  const _MountainIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.72,
      child: CustomPaint(
        painter: _MountainPainter(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.forestGreen,
              AppColors.deepForest,
            ],
          ),
        ),
      ),
    );
  }
}

class _MountainPainter extends CustomPainter {
  _MountainPainter({required this.gradient});

  final Gradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final leftPath = Path()
      ..moveTo(w * 0.04, h)
      ..lineTo(w * 0.26, h * 0.38)
      ..lineTo(w * 0.44, h)
      ..close();

    final centerPath = Path()
      ..moveTo(w * 0.24, h)
      ..lineTo(w * 0.5, h * 0.04)
      ..lineTo(w * 0.76, h)
      ..close();

    final rightPath = Path()
      ..moveTo(w * 0.56, h)
      ..lineTo(w * 0.79, h * 0.42)
      ..lineTo(w * 0.96, h)
      ..close();

    for (final path in [leftPath, centerPath, rightPath]) {
      final bounds = path.getBounds();
      final paint = Paint()
        ..shader = gradient.createShader(bounds)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _MountainPainter oldDelegate) =>
      oldDelegate.gradient != gradient;
}
