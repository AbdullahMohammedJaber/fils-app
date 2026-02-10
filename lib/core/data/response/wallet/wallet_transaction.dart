// To parse this JSON data, do
//
//     final transactionHistoryResponse = transactionHistoryResponseFromJson(jsonString);

import 'dart:convert';

TransactionHistoryResponse transactionHistoryResponseFromJson(String str) =>
    TransactionHistoryResponse.fromJson(json.decode(str));

String transactionHistoryResponseToJson(TransactionHistoryResponse data) =>
    json.encode(data.toJson());

class TransactionHistoryResponse {
  List<TransactionHistory> data;
  String message;
  bool result;
  dynamic code;

  TransactionHistoryResponse({
    required this.data,
    required this.message,
    required this.result,
    required this.code,
  });

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      TransactionHistoryResponse(
        data: List<TransactionHistory>.from(
          json["data"].map((x) => TransactionHistory.fromJson(x)),
        ),
        message: json["message"],
        result: json["result"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
    "result": result,
    "code": code,
  };
}

class TransactionHistory {
  dynamic id;
  dynamic userId;
  String amount;
  String? description;
  DateTime createdAt;
  DateTime updatedAt;
  String type;

  TransactionHistory({
    required this.id,
    required this.userId,
    required this.amount,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
  });

  factory TransactionHistory.fromJson(Map<String, dynamic> json) =>
      TransactionHistory(
        id: json["id"],
        userId: json["user_id"],
        amount: json["amount"],
        description: json["description"]??"",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "amount": amount,
    "description": description,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "type": type,
  };
}
