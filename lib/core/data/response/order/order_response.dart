// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);

import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  List<Orders> data;
  OrderResponseLinks links;
  Meta meta;
  bool success;
  dynamic status;

  OrderResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    data: List<Orders>.from(json["data"].map((x) => Orders.fromJson(x))),
    links: OrderResponseLinks.fromJson(json["links"]),
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

class Orders {
  dynamic id;
  String code;
  dynamic userId;
  String paymentType;
  String paymentStatus;
  String paymentStatusString;
  String deliveryStatus;
  String deliveryStatusString;
  String grandTotal;
  String date;
  List<Product> products;
  DatumLinks links;
  bool isShow = false;

  Orders({
    required this.id,
    required this.code,
    required this.userId,
    required this.paymentType,
    required this.paymentStatus,
    required this.paymentStatusString,
    required this.deliveryStatus,
    required this.deliveryStatusString,
    required this.grandTotal,
    required this.date,
    required this.products,
    required this.links,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
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
    products: List<Product>.from(
        json["products"].map((x) => Product.fromJson(x))),
    links: DatumLinks.fromJson(json["links"]),
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
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "links": links.toJson(),
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

class OrderResponseLinks {
  String first;
  String? last;
  dynamic prev;
  String? next;

  OrderResponseLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory OrderResponseLinks.fromJson(Map<String, dynamic> json) =>
      OrderResponseLinks(
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
  String? path;
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
  String? label;
  bool active;

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
