// To parse this JSON data, do
//
//     final paymentMethodResponse = paymentMethodResponseFromJson(jsonString);

import 'dart:convert';

PaymentMethodResponse paymentMethodResponseFromJson(String str) =>
    PaymentMethodResponse.fromJson(json.decode(str));

String paymentMethodResponseToJson(PaymentMethodResponse data) =>
    json.encode(data.toJson());

class PaymentMethodResponse {
  bool result;
  List<PaymentMethode> data;
  dynamic code;

  PaymentMethodResponse({
    required this.result,
    required this.data,
    required this.code,
  });

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        result: json["result"],
        data: List<PaymentMethode>.from(
            json["data"].map((x) => PaymentMethode.fromJson(x))),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "code": code,
      };
}

class PaymentMethode {
  String paymentType;
  String paymentTypeKey;
  String image;
  String name;
  String title;
  dynamic offlinePaymentId;
  String details;
  bool isSelect = false;

  PaymentMethode({
    required this.paymentType,
    required this.paymentTypeKey,
    required this.image,
    required this.name,
    required this.title,
    required this.offlinePaymentId,
    required this.details,
  });

  factory PaymentMethode.fromJson(Map<String, dynamic> json) => PaymentMethode(
        paymentType: json["payment_type"],
        paymentTypeKey: json["payment_type_key"],
        image: json["image"],
        name: json["name"],
        title: json["title"],
        offlinePaymentId: json["offline_payment_id"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "payment_type": paymentType,
        "payment_type_key": paymentTypeKey,
        "image": image,
        "name": name,
        "title": title,
        "offline_payment_id": offlinePaymentId,
        "details": details,
      };
}
