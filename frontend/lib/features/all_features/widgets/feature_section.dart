import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/renbok_feature_theme.dart';
import '../models/feature_item.dart';
import 'feature_card.dart';

class FeatureSection extends StatelessWidget {
  const FeatureSection({
    super.key,
    required this.section,
  });

  final FeatureSectionData section;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        children: [
          _FeatureSectionHeader(section: section, colors: colors),
          const SizedBox(height: 10),
          _FeatureSectionBody(section: section, colors: colors),
        ],
      ),
    );
  }
}

class _FeatureSectionHeader extends StatelessWidget {
  const _FeatureSectionHeader({
    required this.section,
    required this.colors,
  });

  final FeatureSectionData section;
  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(section.icon, color: colors.primary, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            section.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              color: colors.primary,
              fontSize: 15,
              height: 1,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          '${section.features.length} fitur',
          style: GoogleFonts.plusJakartaSans(
            color: colors.textSecondary,
            fontSize: 13,
            height: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 7),
        Icon(Icons.chevron_right_rounded, color: colors.primary, size: 24),
      ],
    );
  }
}

class _FeatureSectionBody extends StatelessWidget {
  const _FeatureSectionBody({
    required this.section,
    required this.colors,
  });

  final FeatureSectionData section;
  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.055),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: section.compactSingleRow
          ? _CompactFeatureRow(features: section.features, colors: colors)
          : _PairedFeatureRows(features: section.features, colors: colors),
    );
  }
}

class _PairedFeatureRows extends StatelessWidget {
  const _PairedFeatureRows({
    required this.features,
    required this.colors,
  });

  final List<FeatureItem> features;
  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (var index = 0; index < features.length; index += 2) {
      final hasPair = index + 1 < features.length;
      rows.add(
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(child: FeatureCard(item: features[index])),
              if (hasPair) ...[
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: colors.divider,
                ),
                Expanded(child: FeatureCard(item: features[index + 1])),
              ] else
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ),
      );

      if (index + 2 < features.length) {
        rows.add(Divider(height: 1, thickness: 1, color: colors.divider));
      }
    }

    return Column(children: rows);
  }
}

class _CompactFeatureRow extends StatelessWidget {
  const _CompactFeatureRow({
    required this.features,
    required this.colors,
  });

  final List<FeatureItem> features;
  final RenbokFeatureTheme colors;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          for (var index = 0; index < features.length; index++) ...[
            Expanded(child: FeatureCard(item: features[index], compact: true)),
            if (index != features.length - 1)
              VerticalDivider(
                width: 1,
                thickness: 1,
                color: colors.divider,
              ),
          ],
        ],
      ),
    );
  }
}
