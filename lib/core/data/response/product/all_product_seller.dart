// To parse this JSON data, do
//
//     final productSellerResponse = productSellerResponseFromJson(jsonString);


import 'dart:convert';

ProductSellerResponse productSellerResponseFromJson(String str) => ProductSellerResponse.fromJson(json.decode(str));

String productSellerResponseToJson(ProductSellerResponse data) => json.encode(data.toJson());

class ProductSellerResponse {
  bool status;
  dynamic code;
  Data data;

  ProductSellerResponse({
    required this.status,
    required this.code,
    required this.data,
  });

  factory ProductSellerResponse.fromJson(Map<String, dynamic> json) => ProductSellerResponse(
    status: json["status"],
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  List<ProductSeller> data;
  Links links;
  Meta meta;

  Data({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<ProductSeller>.from(json["data"].map((x) => ProductSeller.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class ProductSeller {
  dynamic id;
  String name;
  String thumbnailImg;
  String price;
  dynamic currentStock;
  bool status;
  String category;
  bool featured;
  dynamic basePrice;
  dynamic baseDiscountedPrice;
  dynamic unit;
  dynamic discount;
  String discountType;
  dynamic rating;
  dynamic sales;

  ProductSeller({
    required this.id,
    required this.name,
    required this.thumbnailImg,
    required this.price,
    required this.currentStock,
    required this.status,
    required this.category,
    required this.featured,
    required this.basePrice,
    required this.baseDiscountedPrice,
    required this.unit,
    required this.discount,
    required this.discountType,
    required this.rating,
    required this.sales,
  });

  factory ProductSeller.fromJson(Map<String, dynamic> json) => ProductSeller(
    id: json["id"],
    name: json["name"],
    thumbnailImg: json["thumbnail_img"],
    price: json["price"],
    currentStock: json["current_stock"],
    status: json["status"],
    category: json["category"],
    featured: json["featured"],
    basePrice: json["base_price"],
    baseDiscountedPrice: json["base_discounted_price"],
    unit: json["unit"]==null ? "" :json["unit"] ,
    discount: json["discount"],
    discountType: json["discount_type"],
    rating: json["rating"],
    sales: json["sales"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail_img": thumbnailImg,
    "price": price,
    "current_stock": currentStock,
    "status": status,
    "category": category,
    "featured": featured,
    "base_price": basePrice,
    "base_discounted_price": baseDiscountedPrice,
    "unit": unit,
    "discount": discount,
    "discount_type": discountType,
    "rating": rating,
    "sales": sales,
  };
}

class Links {
  String first;
  String last;
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
  dynamic url;
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
