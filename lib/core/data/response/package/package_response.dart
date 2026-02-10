import 'dart:convert';

class PackageInfoResponse {
  dynamic result;
  dynamic code;
  String? message;
  Data? data;

  PackageInfoResponse({this.result, this.code, this.message, this.data});

  factory PackageInfoResponse.fromRawJson(String str) =>
      PackageInfoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageInfoResponse.fromJson(Map<String, dynamic> json) =>
      PackageInfoResponse(
        result: json["result"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  dynamic amount;
  int? productUploadLimit;
  dynamic logo;
  int? duration;
  dynamic createdAt;
  DateTime? updatedAt;
  int? auction;
  int? branch;
  int? isClassified;
  int? isGifted;
  int? normalAuction;
  int? liveAuction;

  Data({
    this.id,
    this.name,
    this.amount,
    this.productUploadLimit,
    this.logo,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.auction,
    this.branch,
    this.isClassified,
    this.isGifted,
    this.normalAuction,
    this.liveAuction,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    amount: json["amount"],
    productUploadLimit: json["product_upload_limit"],
    logo: json["logo"],
    duration: json["duration"],
    createdAt: json["created_at"],
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    auction: json["auction"],
    branch: json["branch"],
    isClassified: json["isClassified"],
    isGifted: json["isGifted"],
    normalAuction: json["normal_auction"],
    liveAuction: json["live_auction"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "amount": amount,
    "product_upload_limit": productUploadLimit,
    "logo": logo,
    "duration": duration,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
    "auction": auction,
    "branch": branch,
    "isClassified": isClassified,
    "isGifted": isGifted,
    "normal_auction": normalAuction,
    "live_auction": liveAuction,
  };
}
