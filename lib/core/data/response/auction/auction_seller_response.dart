// To parse this JSON data, do
//
//     final allAuctionSellerResponse = allAuctionSellerResponseFromJson(jsonString);

import 'dart:convert';

AllAuctionSellerResponse allAuctionSellerResponseFromJson(String str) =>
    AllAuctionSellerResponse.fromJson(json.decode(str));

String allAuctionSellerResponseToJson(AllAuctionSellerResponse data) =>
    json.encode(data.toJson());

class AllAuctionSellerResponse {
  bool status;
  dynamic code;
  Data data;

  AllAuctionSellerResponse({
    required this.status,
    required this.code,
    required this.data,
  });

  factory AllAuctionSellerResponse.fromJson(Map<String, dynamic> json) =>
      AllAuctionSellerResponse(
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
  List<AuctionSeller> data;
  DataLinks links;
  Meta meta;
  bool success;
  dynamic status;
  dynamic code;

  Data({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
    required this.code,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<AuctionSeller>.from(
      json["data"].map((x) => AuctionSeller.fromJson(x)),
    ),
    links: DataLinks.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    success: json["success"],
    status: json["status"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "success": success,
    "status": status,
    "code": code,
  };
}

class AuctionSeller {
  dynamic id;
  String slug;
  dynamic sellerId;
  dynamic shopId;
  String shopSlug;
  String shopName;
  String shopLogo;
  String name;
  String thumbnailImage;
  List<String> photos;
  String description;
  bool hasDiscount;
  String mainPrice;
  dynamic auction_type;
  dynamic rating;
  dynamic sales;
  String status;
  Auction auctionPeriod;
  Auction auction_start_date;
  Auction auctionTimeLeft;
  DateTime auctionEndDateString;
  bool isFavorite;
  dynamic assuranceFee;
  bool isPaidAssuranceFee;
  dynamic isLive;
  dynamic isPaused;
  DatumLinks links;

  AuctionSeller({
    required this.id,
    required this.slug,
    required this.sellerId,
    required this.shopId,
    required this.shopSlug,
    required this.auction_type,
    required this.auction_start_date,
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

  factory AuctionSeller.fromJson(Map<String, dynamic> json) => AuctionSeller(
    id: json["id"],
    slug: json["slug"],
    auction_type: json["auction_type"],
    sellerId: json["seller_id"],
    shopId: json["shop_id"],
    shopSlug: json["shop_slug"],
    shopName: json["shop_name"],
    shopLogo: json["shop_logo"],
    name: json["name"],
    thumbnailImage: json["thumbnail_image"],
    photos: List<String>.from(json["photos"].map((x) => x)),
    description: json["description"],
    hasDiscount: json["has_discount"],
    mainPrice: json["main_price"],
    rating: json["rating"],
    sales: json["sales"],
    status: json["status"],
    auctionPeriod: Auction.fromJson(json["auction_period"]),
    auctionTimeLeft: Auction.fromJson(json["auction_time_left"]),
    auction_start_date: Auction.fromJson(json["auction_start_date"]),
    auctionEndDateString: DateTime.parse(json["auction_end_date_string"]),
    isFavorite: json["is_favorite"],
    assuranceFee: json["assurance_fee"],
    isPaidAssuranceFee: json["is_paid_assurance_fee"],
    isLive: json["is_live"],
    isPaused: json["is_paused"],
    links: DatumLinks.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "seller_id": sellerId,
    "auction_type": auction_type,
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
    "auction_start_date": auction_start_date.toJson(),
    "auction_end_date_string": auctionEndDateString.toIso8601String(),
    "is_favorite": isFavorite,
    "assurance_fee": assuranceFee,
    "is_paid_assurance_fee": isPaidAssuranceFee,
    "is_live": isLive,
    "is_paused": isPaused,
    "links": links.toJson(),
  };
}

class Auction {
  dynamic days;
  dynamic hours;
  dynamic minutes;
  dynamic seconds;

  Auction({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
    days: json["days"],
    hours: json["hours"],
    minutes: json["minutes"],
    seconds: json["seconds"],
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
    "minutes": minutes,
    "seconds": seconds,
  };
}

class DatumLinks {
  String details;

  DatumLinks({required this.details});

  factory DatumLinks.fromJson(Map<String, dynamic> json) =>
      DatumLinks(details: json["details"]);

  Map<String, dynamic> toJson() => {"details": details};
}

class DataLinks {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  DataLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

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
  bool active;

  Link({required this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(url: json["url"], label: json["label"], active: json["active"]);

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
