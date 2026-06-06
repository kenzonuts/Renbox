import 'location_model.dart';
import 'profile_model.dart';

class PostModel {
  PostModel({
    required this.id,
    required this.userId,
    required this.imageUrl,
    this.locationId,
    this.caption,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.savesCount = 0,
    this.createdAt,
    this.profile,
    this.location,
    this.isLiked = false,
    this.isSaved = false,
  });

  final String id;
  final String userId;
  final String? locationId;
  final String imageUrl;
  final String? caption;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final int savesCount;
  final DateTime? createdAt;
  final ProfileModel? profile;
  final LocationModel? location;
  final bool isLiked;
  final bool isSaved;

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      locationId: json['location_id'] as String?,
      imageUrl: json['image_url'] as String,
      caption: json['caption'] as String?,
      likesCount: json['likes_count'] as int? ?? 0,
      commentsCount: json['comments_count'] as int? ?? 0,
      sharesCount: json['shares_count'] as int? ?? 0,
      savesCount: json['saves_count'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      profile: json['profiles'] != null
          ? ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>)
          : null,
      location: json['locations'] != null
          ? LocationModel.fromJson(json['locations'] as Map<String, dynamic>)
          : null,
      isLiked: json['is_liked'] as bool? ?? false,
      isSaved: json['is_saved'] as bool? ?? false,
    );
  }
}
