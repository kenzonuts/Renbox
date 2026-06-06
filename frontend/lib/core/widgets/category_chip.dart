import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/categories.dart';

class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final NatureCategory category;
  final bool selected;
  final VoidCallback onTap;

  static const _height = 34.0;

  @override
  Widget build(BuildContext context) {
    final bgColor = selected
        ? (category.selectedBackgroundColor ?? category.backgroundColor)
        : category.backgroundColor;
    final textColor = selected
        ? (category.selectedTextColor ?? category.textColor)
        : category.textColor;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_height / 2),
          splashColor: textColor.withValues(alpha: 0.12),
          highlightColor: textColor.withValues(alpha: 0.06),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            height: _height,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(_height / 2),
              border: selected
                  ? null
                  : Border.all(
                      color: textColor.withValues(alpha: 0.14),
                      width: 1,
                    ),
              boxShadow: selected
                  ? [
                      BoxShadow(
                        color: bgColor.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                SizedBox(
                  width: 16,
                  child: Text(
                    category.emoji,
                    style: const TextStyle(fontSize: 13, height: 1.1),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  category.label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    height: 1,
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
