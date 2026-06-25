import 'package:flutter/material.dart';

class WeekendDestination {
  const WeekendDestination({
    required this.title,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.duration,
    required this.difficulty,
    required this.budget,
    required this.weather,
    required this.description,
    required this.imageUrl,
    required this.imageLabel,
    required this.imageLabelIcon,
  });

  final String title;
  final String location;
  final String rating;
  final String reviews;
  final String duration;
  final String difficulty;
  final String budget;
  final String weather;
  final String description;
  final String imageUrl;
  final String imageLabel;
  final IconData imageLabelIcon;
}
