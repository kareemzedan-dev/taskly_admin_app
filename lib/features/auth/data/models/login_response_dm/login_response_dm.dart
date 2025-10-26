

import '../../../domain/entities/login_response_entity/login_response_entity.dart';

class LoginResponseDm extends LoginResponseEntity {
  LoginResponseDm({super.user, super.message, super.token});

  LoginResponseDm.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? LoginUserDm.fromJson(json['user']) : null;
    message = json['message'];
    token = json['token'];
  }
}

class LoginUserDm extends LoginUserEntity {
  LoginUserDm({super.email, super.password, super.id});
  LoginUserDm.fromJson(Map<String, dynamic> json) {
     id = json['id'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }
  LoginUserDm.toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;

    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
  }
}
