// To parse this JSON data, do
//
//     final colorProductResponse = colorProductResponseFromJson(jsonString);

import 'dart:convert';

ColorProductResponse colorProductResponseFromJson(String str) =>
    ColorProductResponse.fromJson(json.decode(str));

String colorProductResponseToJson(ColorProductResponse data) =>
    json.encode(data.toJson());

class ColorProductResponse {
  bool status;
  List<ColorProduct> data;

  ColorProductResponse({
    required this.status,
    required this.data,
  });

  factory ColorProductResponse.fromJson(Map<String, dynamic> json) =>
      ColorProductResponse(
        status: json["status"],
        data: List<ColorProduct>.from(
            json["data"].map((x) => ColorProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ColorProduct {
  dynamic id;
  String name;
  String code;
  bool isSelect = false;
  ColorProduct({
    required this.id,
    required this.name,
    required this.code,
  });

  factory ColorProduct.fromJson(Map<String, dynamic> json) => ColorProduct(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
      };
}
