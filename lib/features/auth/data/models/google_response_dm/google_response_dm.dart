
// Model للمستخدم
import '../../../domain/entities/google_response_entity/google_response_entity.dart';

class GoogleUserDm extends GoogleUserEntity {
  GoogleUserDm({
    required super.id,
    required super.name,
    required super.email,
    super.avatarUrl,
    required super.role,
  });

  factory GoogleUserDm.fromJson(Map<String, dynamic> json) {
    return GoogleUserDm(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'role': role,
    };
  }

  GoogleUserEntity toEntity() {
    return GoogleUserEntity(
      id: id,
      name: name,
      email: email,
      avatarUrl: avatarUrl,
      role: role,
    );
  }
}

class GoogleAuthResponseDm extends GoogleAuthResponseEntity {
  GoogleAuthResponseDm({
    super.token,
    GoogleUserDm? super.user,
    super.message,
  });

  factory GoogleAuthResponseDm.fromJson(Map<String, dynamic> json) {
    return GoogleAuthResponseDm(
      token: json['token'] as String?,
      user: json['user'] != null
          ? GoogleUserDm.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String?,
    );
  }}