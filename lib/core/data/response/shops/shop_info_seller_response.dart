// To parse this JSON data, do
//
//     final shopInfoResponse = shopInfoResponseFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

ShopInfoResponse shopInfoResponseFromJson(dynamic str) =>
    ShopInfoResponse.fromJson(json.decode(str));

dynamic shopInfoResponseToJson(ShopInfoResponse data) =>
    json.encode(data.toJson());

class ShopInfoResponse {
  Data? data;
  bool success;
  dynamic status;

  ShopInfoResponse({
    required this.data,
    required this.success,
    required this.status,
  });

  factory ShopInfoResponse.fromJson(Map<dynamic, dynamic> json) =>
      ShopInfoResponse(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
    "data": data!.toJson(),
    "success": success,
    "status": status,
  };
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic title;
  dynamic description;
  dynamic deliveryPickupLatitude;
  dynamic deliveryPickupLongitude;
  dynamic logo;
  dynamic packageInvalidAt;
  dynamic productUploadLimit;
  dynamic sellerPackage;
  dynamic sellerPackageImg;
  dynamic uploadId;
  List<dynamic> sliders;
  dynamic slidersId;
  dynamic address;
  dynamic adminToPay;
  dynamic phone;
  dynamic facebook;
  dynamic google;
  dynamic twitter;
  dynamic instagram;
  dynamic youtube;
  dynamic cashOnDeliveryStatus;
  dynamic bankPaymentStatus;
  dynamic bankName;
  dynamic bankAccName;
  dynamic bankAccNo;
  dynamic bankRoutingNo;
  dynamic rating;
  bool verified;
  bool isSubmittedForm;
  dynamic verifiedImg;
  dynamic verifyText;
  dynamic email;
  dynamic products;
  dynamic orders;
  dynamic sales;

  User? user;

  Data({
    required this.id,
    required this.userId,
    required this.name,
    required this.title,
    required this.description,
    required this.deliveryPickupLatitude,
    required this.deliveryPickupLongitude,
    required this.logo,
    required this.packageInvalidAt,
    required this.productUploadLimit,
    required this.sellerPackage,
    required this.sellerPackageImg,
    required this.uploadId,
    required this.sliders,
    required this.slidersId,
    required this.address,
    required this.adminToPay,
    required this.phone,
    required this.facebook,
    required this.google,
    required this.twitter,
    required this.instagram,
    required this.youtube,
    required this.cashOnDeliveryStatus,
    required this.bankPaymentStatus,
    required this.bankName,
    required this.bankAccName,
    required this.bankAccNo,
    required this.bankRoutingNo,
    required this.rating,
    required this.verified,
    required this.isSubmittedForm,
    required this.verifiedImg,
    required this.verifyText,
    required this.email,
    required this.products,
    required this.orders,
    required this.sales,
    required this.user,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
    title: json["title"] == null ? "null" : json["title"],
    description: json["description"] == null ? "null" : json["description"],
    deliveryPickupLatitude: json["delivery_pickup_latitude"],
    deliveryPickupLongitude: json["delivery_pickup_longitude"],
    logo: json["logo"],
    packageInvalidAt: json["package_invalid_at"],
    productUploadLimit: json["product_upload_limit"],
    sellerPackage: json["seller_package"],
    sellerPackageImg: json["seller_package_img"],
    uploadId: json["upload_id"],
    sliders: List<dynamic>.from(json["sliders"].map((x) => x)),
    slidersId: json["sliders_id"],
    address: json["address"],
    adminToPay: json["admin_to_pay"],
    phone: json["phone"],
    facebook: json["facebook"],
    google: json["google"],
    twitter: json["twitter"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    cashOnDeliveryStatus: json["cash_on_delivery_status"],
    bankPaymentStatus: json["bank_payment_status"],
    bankName: json["bank_name"] == null ? "null" : json["bank_name"],
    bankAccName: json["bank_acc_name"] == null ? "null" : json["bank_acc_name"],
    bankAccNo: json["bank_acc_no"] == null ? "null" : json["bank_acc_no"],
    bankRoutingNo: json["bank_routing_no"],
    rating: json["rating"],
    verified: json["verified"],
    isSubmittedForm: json["is_submitted_form"],
    verifiedImg: json["verified_img"],
    verifyText: json["verify_text"],
    email: json["email"],
    products: json["products"],
    orders: json["orders"],
    sales: json["sales"],
    user: User.fromJson(json["user"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "title": title,
    "description": description,
    "delivery_pickup_latitude": deliveryPickupLatitude,
    "delivery_pickup_longitude": deliveryPickupLongitude,
    "logo": logo,
    "package_invalid_at": packageInvalidAt,
    "product_upload_limit": productUploadLimit,
    "seller_package": sellerPackage,
    "seller_package_img": sellerPackageImg,
    "upload_id": uploadId,
    "sliders": List<dynamic>.from(sliders.map((x) => x)),
    "sliders_id": slidersId,
    "address": address,
    "admin_to_pay": adminToPay,
    "phone": phone,
    "facebook": facebook,
    "google": google,
    "twitter": twitter,
    "instagram": instagram,
    "youtube": youtube,
    "cash_on_delivery_status": cashOnDeliveryStatus,
    "bank_payment_status": bankPaymentStatus,
    "bank_name": bankName,
    "bank_acc_name": bankAccName,
    "bank_acc_no": bankAccNo,
    "bank_routing_no": bankRoutingNo,
    "rating": rating,
    "verified": verified,
    "is_submitted_form": isSubmittedForm,
    "verified_img": verifiedImg,
    "verify_text": verifyText,
    "email": email,
    "products": products,
    "orders": orders,
    "sales": sales,
    "user": user!.toJson(),
  };
}

class User {
  dynamic name;
  dynamic idNumber;

  User({required this.name, required this.idNumber});

  factory User.fromJson(Map<dynamic, dynamic> json) =>
      User(name: json["name"], idNumber: json["id_number"]);

  Map<dynamic, dynamic> toJson() => {"name": name, "id_number": idNumber};
}
