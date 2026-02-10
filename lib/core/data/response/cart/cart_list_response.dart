// To parse this JSON data, do
//
//     final cartListResponse = cartListResponseFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

CartListResponse cartListResponseFromJson(String str) =>
    CartListResponse.fromJson(json.decode(str));

String cartListResponseToJson(CartListResponse data) =>
    json.encode(data.toJson());

class CartListResponse {
  String grandTotal;
  String order_amount;
  dynamic shipping_cost;
  List<Datum> data;

  CartListResponse({
    required this.grandTotal,
    required this.order_amount,
    required this.data,
    this.shipping_cost,
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) =>
      CartListResponse(
        grandTotal: json["grand_total"],
        shipping_cost: json["shipping_cost"],
        order_amount: json["order_amount"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "grand_total": grandTotal,
    "order_amount": order_amount,
    "shipping_cost": shipping_cost,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String name;
  dynamic ownerId;
  String subTotal;

  List<CartItem> cartItems;

  Datum({
    required this.name,
    required this.ownerId,
    required this.subTotal,
    required this.cartItems,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"],
    ownerId: json["owner_id"],
    subTotal: json["sub_total"],
    cartItems: List<CartItem>.from(
      json["cart_items"].map((x) => CartItem.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "owner_id": ownerId,
    "sub_total": subTotal,
    "cart_items": List<dynamic>.from(cartItems.map((x) => x.toJson())),
  };
}

class CartItem {
  dynamic id;
  dynamic status;
  dynamic ownerId;
  dynamic shopName;
  dynamic userId;
  dynamic productId;
  String productName;
  dynamic auctionProduct;
  String productThumbnailImage;
  String? variation;
  dynamic unitPrice;
  String currencySymbol;
  String tax;
  String price;
  dynamic shippingCost;
  dynamic quantity;
  dynamic lowerLimit;
  dynamic upperLimit;

  CartItem({
    required this.id,
    required this.status,
    required this.ownerId,
    required this.shopName,
    required this.userId,
    required this.productId,
    required this.productName,
    required this.auctionProduct,
    required this.productThumbnailImage,
    required this.variation,
    required this.unitPrice,
    required this.currencySymbol,
    required this.tax,
    required this.price,
    required this.shippingCost,
    required this.quantity,
    required this.lowerLimit,
    required this.upperLimit,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"],
    status: json["status"],
    ownerId: json["owner_id"],
    shopName: json["shop_name"],
    userId: json["user_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    auctionProduct: json["auction_product"],
    productThumbnailImage: json["product_thumbnail_image"],
    variation: json["variation"] ?? "",
    unitPrice: json["unit_price"],
    currencySymbol: json["currency_symbol"],
    tax: json["tax"],
    price: json["price"],
    shippingCost: json["shipping_cost"],
    quantity: json["quantity"],
    lowerLimit: json["lower_limit"],
    upperLimit: json["upper_limit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "owner_id": ownerId,
    "shop_name": shopName,
    "user_id": userId,
    "product_id": productId,
    "product_name": productName,
    "auction_product": auctionProduct,
    "product_thumbnail_image": productThumbnailImage,
    "variation": variation,
    "unit_price": unitPrice,
    "currency_symbol": currencySymbol,
    "tax": tax,
    "price": price,
    "shipping_cost": shippingCost,
    "quantity": quantity,
    "lower_limit": lowerLimit,
    "upper_limit": upperLimit,
  };
}
