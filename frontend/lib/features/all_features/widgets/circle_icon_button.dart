import 'package:flutter/material.dart';

import '../../../core/theme/renbok_feature_theme.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 56,
    this.iconSize = 30,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final double iconSize;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        elevation: 0,
        shadowColor: Colors.transparent,
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
                  color: Colors.black.withValues(alpha: 0.06),
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
