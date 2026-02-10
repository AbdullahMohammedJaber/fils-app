// To parse this JSON data, do
//
//     final suggestProductResponse = suggestProductResponseFromMap(jsonString);

import 'dart:convert';

import '../product/item_product.dart';

SuggestProductResponse suggestProductResponseFromMap(String str) =>
    SuggestProductResponse.fromMap(json.decode(str));

String suggestProductResponseToMap(SuggestProductResponse data) =>
    json.encode(data.toMap());

class SuggestProductResponse {
  bool status;
  int code;
  Data data;

  SuggestProductResponse({
    required this.status,
    required this.code,
    required this.data,
  });

  factory SuggestProductResponse.fromMap(Map<String, dynamic> json) =>
      SuggestProductResponse(
        status: json["status"],
        code: json["code"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
    "status": status,
    "code": code,
    "data": data.toMap(),
  };
}

class Data {
  List<ProductListModel> data;
  DataLinks links;
  Meta meta;
  bool success;
  int status;

  Data({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    data: List<ProductListModel>.from(
      json["data"].map((x) => ProductListModel.fromJson(x)),
    ),
    links: DataLinks.fromMap(json["links"]),
    meta: Meta.fromMap(json["meta"]),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toMap(),
    "meta": meta.toMap(),
    "success": success,
    "status": status,
  };
}

class DatumLinks {
  String details;

  DatumLinks({required this.details});

  factory DatumLinks.fromMap(Map<String, dynamic> json) =>
      DatumLinks(details: json["details"]);

  Map<String, dynamic> toMap() => {"details": details};
}

class DataLinks {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  DataLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory DataLinks.fromMap(Map<String, dynamic> json) => DataLinks(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toMap() => {
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

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toMap())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  dynamic url;
  dynamic label;
  bool active;

  Link({required this.url, required this.label, required this.active});

  factory Link.fromMap(Map<String, dynamic> json) =>
      Link(url: json["url"], label: json["label"], active: json["active"]);

  Map<String, dynamic> toMap() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
