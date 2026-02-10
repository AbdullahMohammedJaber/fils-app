// To parse this JSON data, do
//
//     final attrebuteProductResponse = attrebuteProductResponseFromJson(jsonString);

import 'dart:convert';

AttrebuteProductResponse attrebuteProductResponseFromJson(String str) =>
    AttrebuteProductResponse.fromJson(json.decode(str));

String attrebuteProductResponseToJson(AttrebuteProductResponse data) =>
    json.encode(data.toJson());

class AttrebuteProductResponse {
  bool status;
  List<AttrebuteProduct> data;
  dynamic code;

  AttrebuteProductResponse({
    required this.status,
    required this.data,
    required this.code,
  });

  factory AttrebuteProductResponse.fromJson(Map<String, dynamic> json) =>
      AttrebuteProductResponse(
        status: json["status"],
        data: List<AttrebuteProduct>.from(
          json["data"].map((x) => AttrebuteProduct.fromJson(x)),
        ),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "code": code,
  };
}

class AttrebuteProduct {
  dynamic id;
  String name;
  List<Value> values;

  AttrebuteProduct({
    required this.id,
    required this.name,
    required this.values,
  });

  factory AttrebuteProduct.fromJson(Map<String, dynamic> json) =>
      AttrebuteProduct(
        id: json["id"],
        name: json["name"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
  };
}

class Value {
  dynamic id;
  dynamic attributeId;
  String value;
  dynamic colorCode;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isSelect = false;

  Value({
    required this.id,
    required this.attributeId,
    required this.value,
    required this.colorCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    attributeId: json["attribute_id"],
    value: json["value"],
    colorCode: json["color_code"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "attribute_id": attributeId,
    "value": value,
    "color_code": colorCode,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
