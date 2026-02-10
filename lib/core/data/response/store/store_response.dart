

import 'dart:convert';

StoreResponse StoreResponseFromJson(String str) =>
    StoreResponse.fromJson(json.decode(str));

String StoreResponseToJson(StoreResponse data) =>
    json.encode(data.toJson());

class StoreResponse {
  List<Store> data;
  Links links;
  Meta meta;
  bool success;
  dynamic status;

  StoreResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });

  factory StoreResponse.fromJson(Map<String, dynamic> json) =>
      StoreResponse(
        data: List<Store>.from(json["data"].map((x) => Store.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() =>
      {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "success": success,
        "status": status,
      };
}

class Store {
  dynamic id;
  String? slug;
  String? name;
  String? logo;
  dynamic rating;
  dynamic productsCount;
  dynamic totalSales;
  dynamic address;
  dynamic description;

  Store({
    required this.id,
    required this.slug,
    required this.description,
    required this.name,
    required this.logo,
    required this.rating,
    required this.productsCount,
    required this.totalSales,
    this.address = "USE",
  });

  factory Store.fromJson(Map<String, dynamic> json) =>
      Store(
        id: json["id"],
        address: json["address"],
        slug: json["slug"],
        name: json["name"],
        logo: json["logo"],
        rating: json["rating"],
        productsCount: json["products_count"] ?? "0",
        totalSales: json["total_sales"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "slug": slug,
        "name": name,
        "logo": logo,
        "rating": rating,
        "products_count": productsCount ?? "0",
        "total_sales": totalSales,
        "address": address,
        "description": description,
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

  factory Links.fromJson(Map<String, dynamic> json) =>
      Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() =>
      {
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
  String path;
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

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() =>
      {
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
  dynamic url;
  dynamic label;
  dynamic active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() =>
      {
        "url": url,
        "label": label,
        "active": active,
      };
}
