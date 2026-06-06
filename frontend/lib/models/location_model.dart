class LocationModel {
  LocationModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    this.province,
    this.city,
    this.address,
    this.latitude,
    this.longitude,
    this.altitude,
    this.difficulty,
    this.description,
    this.coverImageUrl,
    this.duration,
    this.ratingAverage,
    this.reviewsCount,
  });

  final String id;
  final String name;
  final String slug;
  final String category;
  final String? province;
  final String? city;
  final String? address;
  final double? latitude;
  final double? longitude;
  final int? altitude;
  final String? difficulty;
  final String? description;
  final String? coverImageUrl;
  final String? duration;
  final double? ratingAverage;
  final int? reviewsCount;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      category: json['category'] as String,
      province: json['province'] as String?,
      city: json['city'] as String?,
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      altitude: json['altitude'] as int?,
      difficulty: json['difficulty'] as String?,
      description: json['description'] as String?,
      coverImageUrl: json['cover_image_url'] as String?,
      duration: json['duration'] as String?,
      ratingAverage: (json['rating_average'] as num?)?.toDouble(),
      reviewsCount: json['reviews_count'] as int?,
    );
  }

  String get locationLine {
    final parts = [city, province].where((e) => e != null && e.isNotEmpty);
    return parts.join(', ');
  }

  String get categoryLabel {
    switch (category) {
      case 'mountain':
        return 'Gunung';
      case 'camping':
        return 'Camping';
      case 'waterfall':
        return 'Air Terjun';
      case 'beach':
        return 'Pantai';
      case 'forest':
        return 'Hutan';
      case 'lake':
        return 'Danau';
      default:
        return category;
    }
  }

  String get difficultyLabel {
    switch (difficulty) {
      case 'easy':
        return 'Mudah';
      case 'medium':
        return 'Sedang';
      case 'hard':
        return category == 'mountain' ? 'Sulit/Trekking' : 'Sulit';
      case 'extreme':
        return category == 'mountain' ? 'Sulit/Trekking' : 'Ekstrem';
      default:
        return difficulty ?? '-';
    }
  }

  String get difficultyBadgeLabel {
    switch (difficulty) {
      case 'easy':
        return 'Easy';
      case 'medium':
        return 'Medium';
      case 'hard':
      case 'extreme':
        return 'Hard';
      default:
        return 'Easy';
    }
  }

  bool get isHardDifficulty =>
      difficulty == 'hard' || difficulty == 'extreme';
}
