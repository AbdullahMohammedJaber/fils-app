import 'dart:convert';

import 'user_response.dart';

class SwitchAccountResponse {
  bool? result;
  String? message;
  String? token;
  User? user;

  SwitchAccountResponse({
    this.result,
    this.message,
    this.token,
    this.user,
  });

  factory SwitchAccountResponse.fromRawJson(String str) => SwitchAccountResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SwitchAccountResponse.fromJson(Map<String, dynamic> json) => SwitchAccountResponse(
    result: json["result"],
    message: json["message"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}


