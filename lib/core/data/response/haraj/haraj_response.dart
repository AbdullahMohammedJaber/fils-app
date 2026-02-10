import 'dart:convert';

class AllProductMarketOpenResponse {
  List<MarketOpenResponse>? data;
  Links? links;
  Meta? meta;
  bool? success;
  dynamic status;

  AllProductMarketOpenResponse({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  factory AllProductMarketOpenResponse.fromRawJson(String str) =>
      AllProductMarketOpenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllProductMarketOpenResponse.fromJson(Map<String, dynamic> json) =>
      AllProductMarketOpenResponse(
        data:
        json["data"] == null
            ? []
            : List<MarketOpenResponse>.from(
          json["data"]!.map((x) => MarketOpenResponse.fromJson(x)),
        ),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "data":
    data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links?.toJson(),
    "meta": meta?.toJson(),
    "success": success,
    "status": status,
  };
}

class MarketOpenResponse {
  dynamic id;
  String? slug;
  String? name;
  String? thumbnailImage;
  String? condition;
  String? unitPrice;
  String? category;
  bool? published;
  bool? status;

  MarketOpenResponse({
    this.id,
    this.slug,
    this.name,
    this.thumbnailImage,
    this.condition,
    this.unitPrice,
    this.category,
    this.published,
    this.status,
  });

  factory MarketOpenResponse.fromRawJson(String str) =>
      MarketOpenResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MarketOpenResponse.fromJson(Map<String, dynamic> json) =>
      MarketOpenResponse(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        thumbnailImage: json["thumbnail_image"],
        condition: json["condition"],
        unitPrice: json["unit_price"],
        category: json["category"],
        published: json["published"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "condition": condition,
    "unit_price": unitPrice,
    "category": category,
    "published": published,
    "status": status,
  };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({this.first, this.last, this.prev, this.next});

  factory Links.fromRawJson(String str) => Links.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
  List<Link>? links;
  String? path;
  dynamic perPage;
  dynamic to;
  dynamic total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links:
    json["links"] == null
        ? []
        : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links":
    links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({this.url, this.label, this.active});

  factory Link.fromRawJson(String str) => Link.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(url: json["url"], label: json["label"], active: json["active"]);

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
