import 'profile_model.dart';

class CommentModel {
  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    this.createdAt,
    this.profile,
  });

  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime? createdAt;
  final ProfileModel? profile;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String,
      postId: json['post_id'] as String,
      userId: json['user_id'] as String,
      content: json['content'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      profile: json['profiles'] != null
          ? ProfileModel.fromJson(json['profiles'] as Map<String, dynamic>)
          : null,
    );
  }
}
