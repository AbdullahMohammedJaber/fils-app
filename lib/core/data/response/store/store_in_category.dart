// To parse this JSON data, do
//
//     final storeInCategoryResponse = storeInCategoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fils/core/data/response/store/store_response.dart';

StoreInCategoryResponse storeInCategoryResponseFromJson(String str) => StoreInCategoryResponse.fromJson(json.decode(str));

String storeInCategoryResponseToJson(StoreInCategoryResponse data) => json.encode(data.toJson());

class StoreInCategoryResponse {
  bool result;
  Data data;
  int code;

  StoreInCategoryResponse({
    required this.result,
    required this.data,
    required this.code,
  });

  factory StoreInCategoryResponse.fromJson(Map<String, dynamic> json) => StoreInCategoryResponse(
    result: json["result"],
    data: Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data.toJson(),
    "code": code,
  };
}

class Data {
  Shops shops;

  Data({
    required this.shops,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    shops: Shops.fromJson(json["shops"]),
  );

  Map<String, dynamic> toJson() => {
    "shops": shops.toJson(),
  };
}

class Shops {
  List<Store> data;
  Links links;
  Meta meta;
  bool success;
  int status;

  Shops({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });

  factory Shops.fromJson(Map<String, dynamic> json) => Shops(
    data: List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "success": success,
    "status": status,
  };
}



class Links {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  List<Link> links;
  dynamic path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  dynamic label;
  dynamic active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
