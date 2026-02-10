import 'dart:convert';

 
class OrderSellerResponse {
  bool? result;
  Data? data;
  String? message;

  OrderSellerResponse({this.result, this.data, this.message});

  factory OrderSellerResponse.fromRawJson(String str) =>
      OrderSellerResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderSellerResponse.fromJson(Map<String, dynamic> json) =>
      OrderSellerResponse(
        result: json["result"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
    "result": result,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<OrderSeeler>? data;
  DataLinks? links;
  Meta? meta;
  bool? success;
  int? status;

  Data({this.data, this.links, this.meta, this.success, this.status});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data:
        json["data"] == null
            ? []
            : List<OrderSeeler>.from(
              json["data"]!.map((x) => OrderSeeler.fromJson(x)),
            ),
    links: json["links"] == null ? null : DataLinks.fromJson(json["links"]),
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

class OrderSeeler {
  int? id;
  String? code;
  int? userId;
  String? paymentType;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;
  String? grandTotal;
  String? date;
  List<Product>? products;
  DatumLinks? links;
  bool isShow = false;
  OrderSeeler({
    this.id,
    this.code,
    this.userId,
    this.paymentType,
    this.paymentStatus,
    this.paymentStatusString,
    this.deliveryStatus,
    this.deliveryStatusString,
    this.grandTotal,
    this.date,
    this.products,
    this.links,
  });

  factory OrderSeeler.fromRawJson(String str) =>
      OrderSeeler.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderSeeler.fromJson(Map<String, dynamic> json) => OrderSeeler(
    id: json["id"],
    code: json["code"],
    userId: json["user_id"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    paymentStatusString: json["payment_status_string"],
    deliveryStatus: json["delivery_status"],
    deliveryStatusString: json["delivery_status_string"],
    grandTotal: json["grand_total"],
    date: json["date"],
    products:
        json["products"] == null
            ? []
            : List<Product>.from(
              json["products"]!.map((x) => Product.fromJson(x)),
            ),
    links: json["links"] == null ? null : DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "user_id": userId,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "payment_status_string": paymentStatusString,
    "delivery_status": deliveryStatus,
    "delivery_status_string": deliveryStatusString,
    "grand_total": grandTotal,
    "date": date,
    "products":
        products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
    "links": links?.toJson(),
  };
}

class DatumLinks {
  String? details;

  DatumLinks({this.details});

  factory DatumLinks.fromRawJson(String str) =>
      DatumLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DatumLinks.fromJson(Map<String, dynamic> json) =>
      DatumLinks(details: json["details"]);

  Map<String, dynamic> toJson() => {"details": details};
}

class DataLinks {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  DataLinks({this.first, this.last, this.prev, this.next});

  factory DataLinks.fromRawJson(String str) =>
      DataLinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataLinks.fromJson(Map<String, dynamic> json) => DataLinks(
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
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

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
class Product {
  dynamic id;
  dynamic productId;
  String? productName;
  String? thumbnailImage;
  String? slug;
  String? shopName;
  String? variation;
  String? price;
  String? tax;
  String? shippingCost;
  String? couponDiscount;
  dynamic quantity;
  String? paymentStatus;
  String? paymentStatusString;
  String? deliveryStatus;
  String? deliveryStatusString;

  Product({
    required this.id,
    required this.productId,
    required this.productName,
    required this.thumbnailImage,
    required this.slug,
    required this.shopName,
    required this.variation,
    required this.price,
    required this.tax,
    required this.shippingCost,
    required this.couponDiscount,
    required this.quantity,
    required this.paymentStatus,
    required this.paymentStatusString,
    required this.deliveryStatus,
    required this.deliveryStatusString,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        thumbnailImage: json["thumbnail_image"],
        slug: json["slug"],
        shopName: json["shop_name"],
        variation: json["variation"],
        price: json["price"],
        tax: json["tax"],
        shippingCost: json["shipping_cost"],
        couponDiscount: json["coupon_discount"],
        quantity: json["quantity"],
        paymentStatus: json["payment_status"],
        paymentStatusString: json["payment_status_string"],
        deliveryStatus: json["delivery_status"],
        deliveryStatusString: json["delivery_status_string"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "thumbnail_image": thumbnailImage,
        "slug": slug,
        "shop_name": shopName,
        "variation": variation,
        "price": price,
        "tax": tax,
        "shipping_cost": shippingCost,
        "coupon_discount": couponDiscount,
        "quantity": quantity,
        "payment_status": paymentStatus,
        "payment_status_string": paymentStatusString,
        "delivery_status": deliveryStatus,
        "delivery_status_string": deliveryStatusString,
      };
}