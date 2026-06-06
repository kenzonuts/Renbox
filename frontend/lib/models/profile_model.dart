class ProfileModel {
  ProfileModel({
    required this.id,
    required this.username,
    this.fullName,
    this.avatarUrl,
    this.bio,
    this.city,
    this.interests = const [],
    this.email,
    this.createdAt,
  });

  final String id;
  final String username;
  final String? fullName;
  final String? avatarUrl;
  final String? bio;
  final String? city;
  final List<String> interests;
  final String? email;
  final DateTime? createdAt;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      bio: json['bio'] as String?,
      city: json['city'] as String?,
      interests: (json['interests'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      email: json['email'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  String get displayName => fullName?.isNotEmpty == true ? fullName! : username;
}
