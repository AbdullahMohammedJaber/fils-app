import 'dart:convert';

BidResponse bidResponseFromJson(dynamic str) =>
    BidResponse.fromJson(json.decode(str));

dynamic bidResponseToJson(BidResponse data) => json.encode(data.toJson());

class BidResponse {
  dynamic productId;
  Bid bid;
  dynamic body;
  dynamic title;
  dynamic type;

  BidResponse({
    required this.productId,
    required this.bid,
    required this.body,
    required this.title,
    required this.type,
  });

  factory BidResponse.fromJson(Map<dynamic, dynamic> json) => BidResponse(
    productId: json["product_id"],
    bid: Bid.fromJson(Map<dynamic, dynamic>.from(json["bid"])),
    // Ensure bid is a Map<dynamic, dynamic>
    body: json["body"],
    title: json["title"],
    type: json["type"],
  );

  Map<dynamic, dynamic> toJson() => {
    "product_id": productId,
    "bid": bid.toJson(),
    "body": body,
    "title": title,
    "type": type,
  };
}

class Bid {
  dynamic amount;
  dynamic customer_bid;

  DateTime bidAt;
  dynamic id;
  User user;

  Bid({
    required this.amount,
    required this.customer_bid,
    required this.bidAt,
    required this.id,
    required this.user,
  });

  factory Bid.fromJson(Map<dynamic, dynamic> json) => Bid(
    amount: json["amount"].toString(),
    customer_bid: json["customer_bid"],
    bidAt: DateTime.parse(json["bid_at"]),
    id: json["id"],
    user: User.fromJson(
      Map<dynamic, dynamic>.from(json["user"]),
    ), // Ensure user is a Map<dynamic, dynamic>
  );

  Map<dynamic, dynamic> toJson() => {
    "amount": amount,
    "customer_bid": customer_bid,
    "bid_at":
    "${bidAt.year.toString().padLeft(4, '0')}-${bidAt.month.toString().padLeft(2, '0')}-${bidAt.day.toString().padLeft(2, '0')}",
    "id": id,
    "user": user.toJson(),
  };
}

class User {
  dynamic avatarOriginal;
  dynamic phone;
  dynamic name;
  dynamic id;
  dynamic type;
  dynamic email;

  User({
    required this.avatarOriginal,
    required this.phone,
    required this.name,
    required this.id,
    required this.type,
    required this.email,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
    avatarOriginal: json["avatar_original"] ?? "",
    phone: json["phone"],
    name: json["name"],
    id: json["id"],
    type: json["type"],
    email: json["email"],
  );

  Map<dynamic, dynamic> toJson() => {
    "avatar_original": avatarOriginal,
    "phone": phone,
    "name": name,
    "id": id,
    "type": type,
    "email": email,
  };
}
