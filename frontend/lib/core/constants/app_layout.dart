import 'package:flutter/material.dart';

/// Mobile layout tokens for portrait smartphone UI (390×844 baseline).
class AppLayout {
  AppLayout._();

  static const double bottomNavHeight = 78.0;
  static const double bottomNavTopRadius = 28.0;
  static const double createButtonSize = 56.0;

  /// Radius lubang potong di top bar (= setengah tombol + sedikit celah).
  static const double createCutoutRadius = createButtonSize / 2 + 3;

  /// Geser tombol Create ke bawah sedikit dari tepi atas stack.
  static const double createButtonOffsetY = 10.0;

  /// Setengah tombol yang natural menonjol ke atas (bukan diangkat extra).
  static double get createButtonProtrusion => createButtonSize / 2;

  /// Scroll padding so feed content clears the bottom nav + FAB.
  static double bottomContentPadding(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    return bottomNavHeight + createButtonProtrusion + safeBottom + 16;
  }

  static double bottomNavTotalHeight(BuildContext context) {
    final safeBottom = MediaQuery.paddingOf(context).bottom;
    return bottomNavHeight + createButtonProtrusion + safeBottom;
  }
}
