// To parse this JSON data, do
//
//     final detailsAuction = detailsAuctionFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

DetailsAuctionResponse detailsAuctionFromJson(String str) =>
    DetailsAuctionResponse.fromJson(json.decode(str));

String detailsAuctionToJson(DetailsAuctionResponse data) =>
    json.encode(data.toJson());

class DetailsAuctionResponse {
  Auction data;
  bool success;
  dynamic status;
  dynamic code;

  DetailsAuctionResponse({
    required this.data,
    required this.success,
    required this.status,
    required this.code,
  });

  factory DetailsAuctionResponse.fromJson(Map<String, dynamic> json) =>
      DetailsAuctionResponse(
        data: Auction.fromJson(json["data"]),
        success: json["success"],
        status: json["status"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "success": success,
    "status": status,
    "code": code,
  };
}

class Auction {
  dynamic id;
  String name;
  String addedBy;
  dynamic sellerId;
  dynamic shopId;
  String? shopSlug;
  String? shopName;
  String? shopLogo;
  List<Photo> photos;
  String thumbnailImage;
  List<String> tags;
  dynamic rating;
  dynamic ratingCount;
  Brand brand;
  DateTime auctionStartAt;
  AuctionEndDate auctionEndDate;
  AuctionEndDate? auction_start_date;
  AuctionEndDate auction_period;
  DateTime auctionEndDateString;
  dynamic startingBid;
  String unit;
  dynamic minBidPrice;
  dynamic highestBid;
  String description;
  String videoLink;
  String link;
  String status;
  String auction_type;
  List<dynamic> choiceOptions;
  List<dynamic> colors;
  List<dynamic> bids;
  bool is_favorite;
  Channel? channel;
  dynamic assuranceFee;
  bool isPaidAssuranceFee;
  dynamic isLive;
  dynamic isPaused;

  Auction({
    required this.id,
    required this.name,
    required this.is_favorite,
    required this.auction_period,
    required this.addedBy,
    required this.auction_type,
    required this.sellerId,
    required this.shopId,
    required this.shopSlug,
    required this.shopName,
    required this.shopLogo,
    required this.photos,
    required this.thumbnailImage,
    required this.tags,
    required this.rating,
    required this.ratingCount,
    required this.brand,
    required this.auction_start_date,
    required this.auctionStartAt,
    required this.auctionEndDate,
    required this.auctionEndDateString,
    required this.startingBid,
    required this.unit,
    required this.minBidPrice,
    required this.highestBid,
    required this.description,
    required this.videoLink,
    required this.link,
    required this.status,
    required this.choiceOptions,
    required this.colors,
    required this.bids,
    this.channel,
    required this.assuranceFee,
    required this.isPaidAssuranceFee,
    required this.isLive,
    required this.isPaused,
  });

  factory Auction.fromJson(Map<String, dynamic> json) => Auction(
    id: json["id"],
    name: json["name"],
    is_favorite: json["is_favorite"],
    auction_type: json["auction_type"],
    addedBy: json["added_by"],
    sellerId: json["seller_id"],
    shopId: json["shop_id"],
    shopSlug: json["shop_slug"] ?? "",
    shopName: json["shop_name"] ?? "",
    shopLogo: json["shop_logo"] ?? "",
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    thumbnailImage: json["thumbnail_image"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    rating: json["rating"],
    ratingCount: json["rating_count"],
    brand: Brand.fromJson(json["brand"]),
    auctionStartAt: DateTime.parse(json["auction_start_at"]),
    auctionEndDate: AuctionEndDate.fromJson(json["auction_time_left"]),
    auction_period: AuctionEndDate.fromJson(json["auction_period"]),
    auction_start_date:
        json["auction_start_date"] == null
            ? null
            : AuctionEndDate.fromJson(json["auction_start_date"]),
    auctionEndDateString: DateTime.parse(json["auction_end_date_string"]),
    startingBid: json["starting_bid"],
    unit: json["unit"],
    minBidPrice: json["min_bid_price"].toString(),
    highestBid: json["highest_bid"],
    description: json["description"],
    videoLink: json["video_link"],
    link: json["link"],
    status: json["status"],
    choiceOptions: List<dynamic>.from(json["choice_options"].map((x) => x)),
    colors: List<dynamic>.from(json["colors"].map((x) => x)),
    bids: List<dynamic>.from(json["bids"].map((x) => x)),
    channel: json["channel"] == null ? null : Channel.fromJson(json["channel"]),
    assuranceFee: json["assurance_fee"],
    isPaidAssuranceFee: json["is_paid_assurance_fee"],
    isLive: json["is_live"],
    isPaused: json["is_paused"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": addedBy,
    "auction_type": auction_type,
    "seller_id": sellerId,
    "is_favorite": is_favorite,
    "shop_id": shopId,
    "shop_slug": shopSlug,
    "shop_name": shopName,
    "shop_logo": shopLogo,
    "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
    "thumbnail_image": thumbnailImage,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "rating": rating,
    "rating_count": ratingCount,
    "brand": brand.toJson(),
    "auction_start_at": auctionStartAt.toIso8601String(),

    "auction_end_date": auctionEndDate.toJson(),
    "auction_start_date": auction_start_date!.toJson(),
    "auction_period": auction_period.toJson(),
    "auction_end_date_string": auctionEndDateString.toIso8601String(),
    "starting_bid": startingBid,
    "unit": unit,
    "min_bid_price": minBidPrice.toString(),
    "highest_bid": highestBid,
    "description": description,
    "video_link": videoLink,
    "link": link,
    "status": status,
    "choice_options": List<dynamic>.from(choiceOptions.map((x) => x)),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "bids": List<dynamic>.from(bids.map((x) => x)),
    "channel": channel!.toJson(),
    "assurance_fee": assuranceFee,
    "is_paid_assurance_fee": isPaidAssuranceFee,
    "is_live": isLive,
    "is_paused": isPaused,
  };
}

class Channel {
  dynamic id;
  AuctionClass auction;
  dynamic streamKey;
  dynamic channelArn;
  dynamic playbackUrl;
  String rtmpUrl;

  Channel({
    required this.id,
    required this.auction,
    required this.streamKey,
    required this.channelArn,
    required this.playbackUrl,
    required this.rtmpUrl,
  });

  factory Channel.fromJson(Map<String, dynamic> json) => Channel(
    id: json["id"],
    auction: AuctionClass.fromJson(json["auction"]),
    streamKey: json["stream_key"],
    channelArn: json["channel_arn"],
    playbackUrl: json["playback_url"],
    rtmpUrl: json["rtmp_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "auction": auction.toJson(),
    "stream_key": streamKey,
    "channel_arn": channelArn,
    "playback_url": playbackUrl,
    "rtmp_url": rtmpUrl,
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

class Brand {
  String id;
  String name;
  String logo;

  Brand({required this.id, required this.name, required this.logo});

  factory Brand.fromJson(Map<String, dynamic> json) =>
      Brand(id: json["id"], name: json["name"], logo: json["logo"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "logo": logo};
}

class Photo {
  String variant;
  String path;

  Photo({required this.variant, required this.path});

  factory Photo.fromJson(Map<String, dynamic> json) =>
      Photo(variant: json["variant"], path: json["path"]);

  Map<String, dynamic> toJson() => {"variant": variant, "path": path};
}

class AuctionClass {
  dynamic id;
  String slug;
  dynamic sellerId;
  dynamic shopId;
  String shopSlug;
  String shopName;
  String shopLogo;
  String name;
  String thumbnailImage;
  List<dynamic> photos;
  String description;
  bool hasDiscount;
  String mainPrice;
  dynamic rating;
  dynamic sales;
  String status;
  AuctionEndDate auctionPeriod;
  AuctionEndDate auctionTimeLeft;
  DateTime auctionEndDateString;
  bool isFavorite;
  dynamic assuranceFee;
  bool isPaidAssuranceFee;
  dynamic isLive;
  dynamic isPaused;
  Links links;

  AuctionClass({
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

  factory AuctionClass.fromJson(Map<String, dynamic> json) => AuctionClass(
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

  Map<String, dynamic> toJson() => {
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

class Links {
  String details;

  Links({required this.details});

  factory Links.fromJson(Map<String, dynamic> json) =>
      Links(details: json["details"]);

  Map<String, dynamic> toJson() => {"details": details};
}
