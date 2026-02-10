import 'dart:convert';

class ShippingAddressResponse {
  bool? result;
  List<ShippingAddress>? data;
  int? code;

  ShippingAddressResponse({this.result, this.data, this.code});

  factory ShippingAddressResponse.fromRawJson(String str) =>
      ShippingAddressResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddressResponse.fromJson(Map<String, dynamic> json) =>
      ShippingAddressResponse(
        result: json["result"],
        data:
            json["data"] == null
                ? []
                : List<ShippingAddress>.from(
                  json["data"]!.map((x) => ShippingAddress.fromJson(x)),
                ),
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code,
  };
}

class ShippingAddress {
  int? id;
  String? sectorId;
  String? sectorName;
  String? phone;
  String? address;
  int? shopId;
  int? sellerId;
  bool isSelect = false;
  ShippingAddress({
    this.id,
    this.sectorId,
    this.sectorName,
    this.phone,
    this.address,
    this.shopId,
    this.sellerId,
  });

  factory ShippingAddress.fromRawJson(String str) =>
      ShippingAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        sectorId: json["sector_id"],
        sectorName: json["sector_name"],
        phone: json["phone"],
        address: json["address"],
        shopId: json["shop_id"],
        sellerId: json["seller_id"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sector_id": sectorId,
    "sector_name": sectorName,
    "phone": phone,
    "address": address,
    "shop_id": shopId,
    "seller_id": sellerId,
  };
}
