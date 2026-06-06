import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Constrains the app to mobile portrait width (390px baseline).
class MobileViewport extends StatelessWidget {
  const MobileViewport({super.key, required this.child});

  final Widget child;

  static const double mobileWidth = 390;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWide = screenWidth > mobileWidth + 1;

    if (!isWide) return child;

    return ColoredBox(
      color: const Color(0xFFE6E2DC),
      child: Center(
        child: Container(
          width: mobileWidth,
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: AppColors.cream,
            boxShadow: [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 40,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
