// To parse this JSON data, do
//
//     final walletSellerResponse = walletSellerResponseFromJson(jsonString);

import 'dart:convert';

WalletSellerResponse walletSellerResponseFromJson(String str) =>
    WalletSellerResponse.fromJson(json.decode(str));

String walletSellerResponseToJson(WalletSellerResponse data) =>
    json.encode(data.toJson());

class WalletSellerResponse {
  bool status;
  String message;
  Data data;

  WalletSellerResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WalletSellerResponse.fromJson(Map<String, dynamic> json) =>
      WalletSellerResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String adminToPay;
  List<dynamic> latestPayouts;

  Data({
    required this.adminToPay,
    required this.latestPayouts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adminToPay: json["admin_to_pay"],
        latestPayouts: List<dynamic>.from(json["latest_payouts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "admin_to_pay": adminToPay,
        "latest_payouts": List<dynamic>.from(latestPayouts.map((x) => x)),
      };
}
