class UserModel {
  UserModel({
    required this.id,
    this.email,
    this.accessToken,
    this.refreshToken,
  });

  final String id;
  final String? email;
  final String? accessToken;
  final String? refreshToken;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String? ?? json['user']?['id'] as String? ?? '',
      email: json['email'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }
}
