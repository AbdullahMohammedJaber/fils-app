// To parse this JSON data, do
//
//     final homeSellerResponse = homeSellerResponseFromJson(jsonString);

  
import 'dart:convert';

import 'package:fils/core/data/response/auction/auction_seller_response.dart';

HomeSellerResponse homeSellerResponseFromJson(String str) =>
    HomeSellerResponse.fromJson(json.decode(str));

String homeSellerResponseToJson(HomeSellerResponse data) =>
    json.encode(data.toJson());

class HomeSellerResponse {
  bool status;
  dynamic code;
  HomeSeller data;

  HomeSellerResponse({
    required this.status,
    required this.code,
    required this.data,
  });

  factory HomeSellerResponse.fromJson(Map<String, dynamic> json) =>
      HomeSellerResponse(
        status: json["status"],
        code: json["code"],
        data: HomeSeller.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "data": data.toJson(),
      };
}

class HomeSeller {
  List<BestProduct> bestProducts;
  AuctionSeller? latestAuction;

  HomeSeller({
    required this.bestProducts,
    required this.latestAuction,
  });

  factory HomeSeller.fromJson(Map<String, dynamic> json) => HomeSeller(
        bestProducts: List<BestProduct>.from(
            json["best_products"].map((x) => BestProduct.fromJson(x))),
        latestAuction: json["latest_auction"] == null
            ? null
            : AuctionSeller.fromJson(json["latest_auction"]),
      );

  Map<String, dynamic> toJson() => {
        "best_products":
            List<dynamic>.from(bestProducts.map((x) => x.toJson())),
        "latest_auction": latestAuction!.toJson(),
      };
}

class BestProduct {
  dynamic id;
  String slug;
  String name;
  List<String> photos;
  String thumbnailImage;
  dynamic basePrice;
  dynamic baseDiscountedPrice;
  dynamic todaysDeal;
  dynamic featured;
  dynamic unit;
  dynamic discount;
  String discountType;
  dynamic rating;
  dynamic sales;

  BestProduct({
    required this.id,
    required this.slug,
    required this.name,
    required this.photos,
    required this.thumbnailImage,
    required this.basePrice,
    required this.baseDiscountedPrice,
    required this.todaysDeal,
    required this.featured,
    required this.unit,
    required this.discount,
    required this.discountType,
    required this.rating,
    required this.sales,
  });

  factory BestProduct.fromJson(Map<String, dynamic> json) => BestProduct(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        photos: List<String>.from(json["photos"].map((x) => x)),
        thumbnailImage: json["thumbnail_image"],
        basePrice: json["base_price"],
        baseDiscountedPrice: json["base_discounted_price"],
        todaysDeal: json["todays_deal"],
        featured: json["featured"],
        unit: json["unit"] ?? "",
        discount: json["discount"],
        discountType: json["discount_type"],
        rating: json["rating"],
        sales: json["sales"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "thumbnail_image": thumbnailImage,
        "base_price": basePrice,
        "base_discounted_price": baseDiscountedPrice,
        "todays_deal": todaysDeal,
        "featured": featured,
        "unit": unit,
        "discount": discount,
        "discount_type": discountType,
        "rating": rating,
        "sales": sales,
      };
}
