import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/renbok_feature_theme.dart';
import 'circle_icon_button.dart';

class AllFeaturesHeader extends StatelessWidget {
  const AllFeaturesHeader({super.key, required this.onSearchTap});

  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<RenbokFeatureTheme>() ??
        RenbokFeatureTheme.defaults;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
      child: Row(
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_rounded,
            iconSize: 30,
            semanticLabel: 'Kembali',
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              } else {
                context.go('/main');
              }
            },
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Semua Fitur',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.primary,
                    fontSize: 28,
                    height: 1.05,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Temukan semua fitur RENBOK',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    color: colors.textSecondary,
                    fontSize: 15,
                    height: 1.2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          CircleIconButton(
            icon: Icons.search_rounded,
            iconSize: 34,
            semanticLabel: 'Cari fitur',
            onTap: onSearchTap,
          ),
        ],
      ),
    );
  }
}
