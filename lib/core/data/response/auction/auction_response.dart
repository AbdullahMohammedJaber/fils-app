// To parse this JSON data, do
//
//     final allAuctionResponse = allAuctionResponseFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

AllAuctionResponse allAuctionResponseFromJson(String str) =>
    AllAuctionResponse.fromJson(json.decode(str));

String allAuctionResponseToJson(AllAuctionResponse data) =>
    json.encode(data.toJson());

class AllAuctionResponse {
  List<AuctionResponse> data;
  AllAuctionResponseLinks links;
  Meta meta;
  bool success;
  dynamic status;
  dynamic code;

  AllAuctionResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
    required this.code,
  });

  factory AllAuctionResponse.fromJson(Map<String, dynamic> json) =>
      AllAuctionResponse(
        data: List<AuctionResponse>.from(
          json["data"].map((x) => AuctionResponse.fromJson(x)),
        ),
        links: AllAuctionResponseLinks.fromJson(json["links"]),
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

class AuctionResponse {
  dynamic id;
  dynamic slug;
  dynamic sellerId;
  dynamic shopId;
  dynamic shopSlug;
  dynamic shopName;
  dynamic shopLogo;
  dynamic name;
  dynamic thumbnailImage;
  bool hasDiscount;
  dynamic mainPrice;
  dynamic rating;
  dynamic sales;
  dynamic status;
  AuctionEndDate auctionEndDate;
  AuctionEndDate auction_period;
  AuctionEndDate auction_start_date;
  DateTime auctionEndDateString;
  DatumLinks links;
  bool is_favorite;

  AuctionResponse({
    required this.id,
    required this.slug,
    required this.is_favorite,
    required this.auction_period,
    required this.auction_start_date,
    required this.sellerId,
    required this.shopId,
    required this.shopSlug,
    required this.shopName,
    required this.shopLogo,
    required this.name,
    required this.thumbnailImage,
    required this.hasDiscount,
    required this.mainPrice,
    required this.rating,
    required this.sales,
    required this.status,
    required this.auctionEndDate,
    required this.auctionEndDateString,
    required this.links,
  });

  factory AuctionResponse.fromJson(Map<String, dynamic> json) =>
      AuctionResponse(
        id: json["id"],
        is_favorite: json["is_favorite"],
        slug: json["slug"],
        sellerId: json["seller_id"],
        shopId: json["shop_id"],
        shopSlug: json["shop_slug"] ?? "",
        shopName: json["shop_name"] ?? "",
        shopLogo: json["shop_logo"] ?? "",
        name: json["name"],
        thumbnailImage: json["thumbnail_image"],
        hasDiscount: json["has_discount"],
        mainPrice: json["main_price"],
        rating: json["rating"],
        sales: json["sales"],
        status: json["status"],
        auction_period: AuctionEndDate.fromJson(json["auction_period"]),
        auction_start_date: AuctionEndDate.fromJson(json["auction_start_date"]),
        auctionEndDate: AuctionEndDate.fromJson(json["auction_time_left"]),
        auctionEndDateString: DateTime.parse(json["auction_end_date_string"]),
        links: DatumLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "is_favorite": is_favorite,
    "seller_id": sellerId,
    "shop_id": shopId,
    "shop_slug": shopSlug,
    "shop_name": shopName,
    "shop_logo": shopLogo,
    "name": name,
    "thumbnail_image": thumbnailImage,
    "has_discount": hasDiscount,
    "main_price": mainPrice,
    "rating": rating,
    "sales": sales,
    "status": status,
    "auction_end_date": auctionEndDate.toJson(),
    "auction_period": auction_period.toJson(),
    "auction_start_date": auction_start_date.toJson(),
    "auction_end_date_string": auctionEndDateString.toIso8601String(),
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

  factory AuctionEndDate.fromJson(Map<String, dynamic> json) => AuctionEndDate(
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

class AllAuctionResponseLinks {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  AllAuctionResponseLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory AllAuctionResponseLinks.fromJson(Map<String, dynamic> json) =>
      AllAuctionResponseLinks(
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

  Link({required this.url, required this.label, required this.active});

  factory Link.fromJson(Map<String, dynamic> json) =>
      Link(url: json["url"], label: json["label"], active: json["active"]);

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
