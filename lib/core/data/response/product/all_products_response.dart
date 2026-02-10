// To parse this JSON data, do
//
//     final allProductsResponse = allProductsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:fils/core/data/response/product/item_product.dart';

AllProductsResponse allProductsResponseFromJson(String str) => AllProductsResponse.fromJson(json.decode(str));

String allProductsResponseToJson(AllProductsResponse data) => json.encode(data.toJson());

class AllProductsResponse {
  List<ProductListModel> data;
  AllProductsResponseLinks links;
  Meta meta;
  bool success;
  int status;

  AllProductsResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) => AllProductsResponse(
    data: List<ProductListModel>.from(json["data"].map((x) => ProductListModel.fromJson(x))),
    links: AllProductsResponseLinks.fromJson(json["links"]),
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



class DatumLinks {
  String details;

  DatumLinks({
    required this.details,
  });

  factory DatumLinks.fromJson(Map<String, dynamic> json) => DatumLinks(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}

class AllProductsResponseLinks {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  AllProductsResponseLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory AllProductsResponseLinks.fromJson(Map<String, dynamic> json) => AllProductsResponseLinks(
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
  dynamic  url;
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
