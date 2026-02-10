// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';



import 'package:fils/core/data/response/auction/auction_response.dart';

import '../product/item_product.dart';

HomeResponse homeResponseFromJson(dynamic str) =>
    HomeResponse.fromJson(json.decode(str));

dynamic homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  bool result;
  Data? data;
  dynamic code;

  HomeResponse({required this.result, required this.data, required this.code});

  factory HomeResponse.fromJson(Map<dynamic, dynamic> json) => HomeResponse(
    result: json["result"],
    data: Data.fromJson(json["data"]),
    code: json["code"],
  );
factory  HomeResponse.noData() => HomeResponse(code: '',data: null,result: false);
  Map<dynamic, dynamic> toJson() => {
    "result": result,
    "data": data!.toJson(),
    "code": code,
  };
}

class Data {
  AuctionResponse? latestAuction;
  Products newProducts;
  Products relatedProducts;
  Shops shops;

  Data({
    required this.latestAuction,
    required this.newProducts,
    required this.relatedProducts,
    required this.shops,
  });

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    latestAuction:
        json["latest_auction"] == null
            ? null
            : AuctionResponse.fromJson(json["latest_auction"]),
    newProducts: Products.fromJson(json["new_products"]),
    relatedProducts: Products.fromJson(json["related_products"]),
    shops: Shops.fromJson(json["shops"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "latest_auction": latestAuction!.toJson(),
    "new_products": newProducts.toJson(),
    "related_products": relatedProducts.toJson(),
    "shops": shops.toJson(),
  };
}

class LatestAuction {
  dynamic id;
  dynamic slug;
  dynamic sellerId;
  dynamic shopId;
  dynamic shopSlug;
  dynamic shopName;
  dynamic shopLogo;
  dynamic name;
  dynamic thumbnailImage;
  List<dynamic> photos;
  dynamic description;
  bool hasDiscount;
  dynamic mainPrice;
  dynamic rating;
  dynamic sales;
  dynamic status;
  AuctionEndDate auctionPeriod;
  AuctionEndDate auctionTimeLeft;
  DateTime auctionEndDateString;
  bool isFavorite;
  dynamic assuranceFee;
  bool isPaidAssuranceFee;
  dynamic isLive;
  dynamic isPaused;
  Links links;

  LatestAuction({
    required this.id,
    required this.slug,
    required this.sellerId,
    required this.shopId,
    required this.shopSlug,
    required this.shopName,
    required this.shopLogo,
    required this.name,
    required this.thumbnailImage,
    required this.photos,
    required this.description,
    required this.hasDiscount,
    required this.mainPrice,
    required this.rating,
    required this.sales,
    required this.status,
    required this.auctionPeriod,
    required this.auctionTimeLeft,
    required this.auctionEndDateString,
    required this.isFavorite,
    required this.assuranceFee,
    required this.isPaidAssuranceFee,
    required this.isLive,
    required this.isPaused,
    required this.links,
  });

  factory LatestAuction.fromJson(Map<dynamic, dynamic> json) => LatestAuction(
    id: json["id"],
    slug: json["slug"],
    sellerId: json["seller_id"],
    shopId: json["shop_id"],
    shopSlug: json["shop_slug"],
    shopName: json["shop_name"],
    shopLogo: json["shop_logo"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    photos: List<dynamic>.from(json["photos"].map((x) => x)),
    description: json["description"],
    hasDiscount: json["has_discount"],
    mainPrice: json["main_price"],
    rating: json["rating"],
    sales: json["sales"],
    status: json["status"],
    auctionPeriod: AuctionEndDate.fromJson(json["auction_period"]),
    auctionTimeLeft: AuctionEndDate.fromJson(json["auction_time_left"]),
    auctionEndDateString: DateTime.parse(json["auction_end_date_string"]),
    isFavorite: json["is_favorite"],
    assuranceFee: json["assurance_fee"],
    isPaidAssuranceFee: json["is_paid_assurance_fee"],
    isLive: json["is_live"],
    isPaused: json["is_paused"],
    links: Links.fromJson(json["links"]),
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "seller_id": sellerId,
    "shop_id": shopId,
    "shop_slug": shopSlug,
    "shop_name": shopName,
    "shop_logo": shopLogo,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "photos": List<dynamic>.from(photos.map((x) => x)),
    "description": description,
    "has_discount": hasDiscount,
    "main_price": mainPrice,
    "rating": rating,
    "sales": sales,
    "status": status,
    "auction_period": auctionPeriod.toJson(),
    "auction_time_left": auctionTimeLeft.toJson(),
    "auction_end_date_string": auctionEndDateString.toIso8601String(),
    "is_favorite": isFavorite,
    "assurance_fee": assuranceFee,
    "is_paid_assurance_fee": isPaidAssuranceFee,
    "is_live": isLive,
    "is_paused": isPaused,
    "links": links.toJson(),
  };
}

class AuctionEndDate {
  dynamic days;
  dynamic hours;
  dynamic minutes;
  dynamic seconds;

  AuctionEndDate({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory AuctionEndDate.fromJson(Map<dynamic, dynamic> json) => AuctionEndDate(
    days: json["days"],
    hours: json["hours"],
    minutes: json["minutes"],
    seconds: json["seconds"],
  );

  Map<dynamic, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "minutes": minutes,
    "seconds": seconds,
  };
}

class Links {
  dynamic details;

  Links({required this.details});

  factory Links.fromJson(Map<dynamic, dynamic> json) =>
      Links(details: json["details"]);

  Map<dynamic, dynamic> toJson() => {"details": details};
}

class Products {
  List<ProductListModel>? data;

  Products({required this.data});

  factory Products.fromJson(Map<dynamic, dynamic> json) => Products(
    data: List<ProductListModel>.from(
      json["data"].map((x) => ProductListModel.fromJson(x)),
    ),
  );

  Map<dynamic, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Shops {
  List<ShopsDatum> data;

  Shops({required this.data});

  factory Shops.fromJson(Map<dynamic, dynamic> json) => Shops(
    data: List<ShopsDatum>.from(
      json["data"].map((x) => ShopsDatum.fromJson(x)),
    ),
  );

  Map<dynamic, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ShopsDatum {
  dynamic id;
  dynamic slug;
  dynamic name;
  dynamic logo;
  dynamic rating;
  dynamic productsCount;
  dynamic totalSales;
  dynamic address;
  dynamic description;

  ShopsDatum({
    required this.id,
    required this.slug,
    required this.name,
    required this.logo,
    required this.rating,
    required this.productsCount,
    required this.totalSales,
    required this.address,
    required this.description,
  });

  factory ShopsDatum.fromJson(Map<dynamic, dynamic> json) => ShopsDatum(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    logo: json["logo"],
    rating: json["rating"],
    productsCount: json["products_count"] ?? "0",
    totalSales: json["total_sales"],
    address: json["address"],
    description: json["description"],
  );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "logo": logo,
    "rating": rating,
    "description": description,
    "products_count": productsCount ?? "0",
    "total_sales": totalSales,
    "address": address,
  };
}
