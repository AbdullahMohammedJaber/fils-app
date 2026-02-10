// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  dynamic result;
  dynamic message;
  String? accessToken;
  dynamic tokenType;
  dynamic expiresAt;
  User? user;
  dynamic code;

  UserResponse({
    this.result,
    this.message,
    required this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.user,
    this.code,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    result: json["result"],
    message: json["message"],
    accessToken: json["access_token"],
    tokenType: json["token_type"] ?? "",
    expiresAt: json["expires_at"] ?? "",
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_at": expiresAt,
    "user": user!.toJson(),
    "code": code,
  };
}

class User {
  dynamic id;
  String type;
  String name;
  String email;
  dynamic avatar;
  String avatarOriginal;
  String? phone;
  bool emailVerified;
  bool can_switch_between_accounts;
  dynamic shops_count;

  User({
    required this.id,
    required this.shops_count,
    required this.type,
    required this.name,
    required this.email,
    required this.avatar,
    required this.avatarOriginal,
    required this.phone,
    required this.emailVerified,
    required this.can_switch_between_accounts,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] ?? 0,
    type: json["type"] ?? "customer",
    name: json["name"] ?? "",
    shops_count: json["shops_count"] ?? 0,
    email: json["email"] ?? "",
    avatar: json["avatar"],
    avatarOriginal: json["avatar_original"] ?? "",
    phone: json["phone"] ?? "",
    emailVerified: json["email_verified"] ?? true,
    can_switch_between_accounts: json["can_switch_between_accounts"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "shops_count": shops_count,
    "name": name,
    "email": email,
    "avatar": avatar,
    "avatar_original": avatarOriginal,
    "phone": phone,
    "email_verified": emailVerified,
    "can_switch_between_accounts": can_switch_between_accounts,
  };
}
