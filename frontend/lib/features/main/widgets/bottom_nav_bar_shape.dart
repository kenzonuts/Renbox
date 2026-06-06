import 'package:flutter/material.dart';
import '../../../core/constants/app_layout.dart';
import '../../../core/theme/app_colors.dart';

/// Bottom bar putih dengan lubang lingkaran di tengah atas — bulatan Create memotong bar.
class BottomNavBarShape extends StatelessWidget {
  const BottomNavBarShape({
    super.key,
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: _BottomNavClipper(
        topRadius: AppLayout.bottomNavTopRadius,
        cutoutRadius: AppLayout.createCutoutRadius,
        cutoutCenterY: AppLayout.createButtonOffsetY,
      ),
      color: Colors.white,
      elevation: 10,
      shadowColor: AppColors.deepForest.withValues(alpha: 0.1),
      clipBehavior: Clip.none,
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: child,
      ),
    );
  }
}

class _BottomNavClipper extends CustomClipper<Path> {
  _BottomNavClipper({
    required this.topRadius,
    required this.cutoutRadius,
    required this.cutoutCenterY,
  });

  final double topRadius;
  final double cutoutRadius;
  final double cutoutCenterY;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final cx = w / 2;
    final r = topRadius;

    // Rounded-top bar shape
    final bar = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..lineTo(w - r, 0)
      ..quadraticBezierTo(w, 0, w, r)
      ..lineTo(w, size.height)
      ..close();

    // Circular hole — center geser ke bawah sedikit
    final hole = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(cx, cutoutCenterY),
        radius: cutoutRadius,
      ));

    return Path.combine(PathOperation.difference, bar, hole);
  }

  @override
  bool shouldReclip(covariant _BottomNavClipper old) {
    return old.topRadius != topRadius ||
        old.cutoutRadius != cutoutRadius ||
        old.cutoutCenterY != cutoutCenterY;
  }
}
