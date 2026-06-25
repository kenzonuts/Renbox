import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/renbok_feature_theme.dart';
import '../models/feature_item.dart';
import '../screens/feature_placeholder_screen.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.item,
    this.compact = false,
  });

  static const double height = 88;
  static const double iconSize = 48;
  static const double radius = 20;

  final FeatureItem item;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return SizedBox(
      height: compact ? 112 : height,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute<void>(
              builder: (_) => FeaturePlaceholderScreen(
                title: item.title,
                description: item.description,
                icon: item.icon,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(compact ? 12 : 16),
            child: compact
                ? _CompactFeatureContent(item: item, colors: colors)
                : _FeatureContent(item: item, colors: colors),
          ),
        ),
      ),
    );
  }
}

class _FeatureContent extends StatelessWidget {
  const _FeatureContent({required this.item, required this.colors});

  final FeatureItem item;
  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _FeatureIcon(
            icon: item.icon, colors: colors, size: FeatureCard.iconSize),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: colors.textPrimary,
                  fontSize: 15,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  color: colors.textSecondary,
                  fontSize: 11,
                  height: 1.45,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Icon(Icons.chevron_right_rounded, color: colors.primary, size: 26),
      ],
    );
  }
}

class _CompactFeatureContent extends StatelessWidget {
  const _CompactFeatureContent({required this.item, required this.colors});

  final FeatureItem item;
  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _FeatureIcon(icon: item.icon, colors: colors, size: 44),
            const Spacer(),
            Icon(Icons.chevron_right_rounded, color: colors.primary, size: 22),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          item.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.plusJakartaSans(
            color: colors.textPrimary,
            fontSize: 11,
            height: 1.14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Text(
            item.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: colors.textSecondary,
              fontSize: 8.5,
              height: 1.22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureIcon extends StatelessWidget {
  const _FeatureIcon({
    required this.icon,
    required this.colors,
    required this.size,
  });

  final IconData icon;
  final RenbokFeatureTheme colors;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.primaryLight.withValues(alpha: 0.66),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(icon, color: colors.primary, size: size * 0.58),
    );
  }
}
