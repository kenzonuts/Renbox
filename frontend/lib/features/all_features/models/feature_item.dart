import 'package:flutter/material.dart';

class FeatureItem {
  const FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
}

class FeatureSectionData {
  const FeatureSectionData({
    required this.title,
    required this.icon,
    required this.features,
    this.compactSingleRow = false,
  });

  final String title;
  final IconData icon;
  final List<FeatureItem> features;
  final bool compactSingleRow;
}
