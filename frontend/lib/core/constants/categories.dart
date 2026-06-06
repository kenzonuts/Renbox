import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NatureCategory {
  const NatureCategory({
    required this.id,
    required this.label,
    required this.apiValue,
    required this.emoji,
    required this.backgroundColor,
    required this.textColor,
    this.selectedBackgroundColor,
    this.selectedTextColor,
  });

  final String id;
  final String label;
  final String apiValue;
  final String emoji;
  final Color backgroundColor;
  final Color textColor;
  final Color? selectedBackgroundColor;
  final Color? selectedTextColor;
}

const List<NatureCategory> natureCategories = [
  NatureCategory(
    id: 'mountain',
    label: 'Gunung',
    apiValue: 'mountain',
    emoji: '🏔️',
    backgroundColor: AppColors.mountainBg,
    textColor: AppColors.forestText,
    selectedBackgroundColor: AppColors.forestGreen,
    selectedTextColor: Colors.white,
  ),
  NatureCategory(
    id: 'camping',
    label: 'Camping',
    apiValue: 'camping',
    emoji: '⛺',
    backgroundColor: AppColors.campingBg,
    textColor: AppColors.campingText,
    selectedBackgroundColor: AppColors.campingText,
    selectedTextColor: Colors.white,
  ),
  NatureCategory(
    id: 'waterfall',
    label: 'Air Terjun',
    apiValue: 'waterfall',
    emoji: '💧',
    backgroundColor: AppColors.waterfallBg,
    textColor: AppColors.waterfallText,
    selectedBackgroundColor: AppColors.waterfallText,
    selectedTextColor: Colors.white,
  ),
  NatureCategory(
    id: 'beach',
    label: 'Pantai',
    apiValue: 'beach',
    emoji: '🌴',
    backgroundColor: AppColors.beachBg,
    textColor: AppColors.beachText,
    selectedBackgroundColor: AppColors.beachText,
    selectedTextColor: Colors.white,
  ),
  NatureCategory(
    id: 'forest',
    label: 'Hutan',
    apiValue: 'forest',
    emoji: '🌲',
    backgroundColor: AppColors.hutanBg,
    textColor: AppColors.hutanText,
    selectedBackgroundColor: AppColors.hutanText,
    selectedTextColor: Colors.white,
  ),
  NatureCategory(
    id: 'lake',
    label: 'Danau',
    apiValue: 'lake',
    emoji: '🏞️',
    backgroundColor: AppColors.lakeBg,
    textColor: AppColors.lakeText,
    selectedBackgroundColor: AppColors.lakeText,
    selectedTextColor: Colors.white,
  ),
];

const List<String> interestOptions = [
  'Gunung',
  'Camping',
  'Air Terjun',
  'Pantai',
  'Hutan',
  'Danau',
  'Fotografi Alam',
];
