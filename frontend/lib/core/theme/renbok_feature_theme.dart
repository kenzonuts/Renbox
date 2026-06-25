import 'package:flutter/material.dart';

@immutable
class RenbokFeatureTheme extends ThemeExtension<RenbokFeatureTheme> {
  const RenbokFeatureTheme({
    required this.background,
    required this.primary,
    required this.primaryLight,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
  });

  final Color background;
  final Color primary;
  final Color primaryLight;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;

  static const RenbokFeatureTheme defaults = RenbokFeatureTheme(
    background: Color(0xFFF8F5F0),
    primary: Color(0xFF006B4F),
    primaryLight: Color(0xFFDDEFE7),
    textPrimary: Color(0xFF12372A),
    textSecondary: Color(0xFF6B7280),
    divider: Color(0xFFE8E8E8),
  );

  @override
  RenbokFeatureTheme copyWith({
    Color? background,
    Color? primary,
    Color? primaryLight,
    Color? textPrimary,
    Color? textSecondary,
    Color? divider,
  }) {
    return RenbokFeatureTheme(
      background: background ?? this.background,
      primary: primary ?? this.primary,
      primaryLight: primaryLight ?? this.primaryLight,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      divider: divider ?? this.divider,
    );
  }

  @override
  RenbokFeatureTheme lerp(
    ThemeExtension<RenbokFeatureTheme>? other,
    double t,
  ) {
    if (other is! RenbokFeatureTheme) return this;

    return RenbokFeatureTheme(
      background: Color.lerp(background, other.background, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
    );
  }
}
