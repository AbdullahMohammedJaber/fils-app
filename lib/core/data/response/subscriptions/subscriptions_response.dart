import 'dart:convert';

class SubscribeResponse {
  List<Subscribe>? data;

  SubscribeResponse({this.data});

  factory SubscribeResponse.fromRawJson(String str) =>
      SubscribeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscribeResponse.fromJson(Map<String, dynamic> json) =>
      SubscribeResponse(
        data:
            json["data"] == null
                ? []
                : List<Subscribe>.from(
                  json["data"]!.map((x) => Subscribe.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Subscribe {
  int? id;
  String? name;
  String? subtitle;
  String? color;
  String? logo;
  int? productUploadLimit;
  String? amount;
  dynamic price;
  int? duration;
  List<String>? featuers;
  List<String>? extraFeatures;
  bool isSelect = false;

  Subscribe({
    this.id,
    this.name,
    this.subtitle,
    this.color,
    this.logo,
    this.productUploadLimit,
    this.amount,
    this.price,
    this.duration,
    this.featuers,
    this.extraFeatures,
  });

  factory Subscribe.fromRawJson(String str) =>
      Subscribe.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Subscribe.fromJson(Map<String, dynamic> json) => Subscribe(
    id: json["id"],
    name: json["name"],
    subtitle: json["subtitle"],
    color: json["color"],
    logo: json["logo"],
    productUploadLimit: json["product_upload_limit"],
    amount: json["amount"],
    price: json["price"],
    duration: json["duration"],
    featuers:
        json["featuers"] == null
            ? []
            : List<String>.from(json["featuers"]!.map((x) => x)),
    extraFeatures:
        json["0"] == null ? [] : List<String>.from(json["0"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "subtitle": subtitle,
    "color": color,
    "logo": logo,
    "product_upload_limit": productUploadLimit,
    "amount": amount,
    "price": price,
    "duration": duration,
    "featuers":
        featuers == null ? [] : List<dynamic>.from(featuers!.map((x) => x)),
    "extra_features":
        extraFeatures == null
            ? []
            : List<dynamic>.from(extraFeatures!.map((x) => x)),
  };
}
