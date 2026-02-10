// To parse this JSON data, do
//
//     final reelResponse = reelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:video_player/video_player.dart';

ReelResponse reelResponseFromJson(dynamic str) =>
    ReelResponse.fromJson(json.decode(str));

dynamic reelResponseToJson(ReelResponse data) => json.encode(data.toJson());

class ReelResponse {
  List<Reels> data;
  ReelResponseLinks links;
  Meta meta;
  bool success;
  dynamic status;
  bool result;
  dynamic code;

  ReelResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
    required this.result,
    required this.code,
  });

  factory ReelResponse.fromJson(Map<dynamic, dynamic> json) => ReelResponse(
        data: List<Reels>.from(json["data"].map((x) => Reels.fromJson(x))),
        links: ReelResponseLinks.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
        result: json["result"],
        code: json["code"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "success": success,
        "status": status,
        "result": result,
        "code": code,
      };
}

class Reels {
  dynamic id;
  dynamic slug;
  dynamic name;
  dynamic shopName;
  dynamic shopImage;
  dynamic thumbnailImage;
  bool isFavorite;
  dynamic isAuction;
  dynamic favoriteCount;
  dynamic commentsCount;
  DateTime auctionEndDateString;
  dynamic videoProvider;
  String videoLink;
  DatumLinks links;
  VideoPlayerController? controllers;
  Reels({
    required this.id,
    required this.slug,
    required this.name,
    required this.shopName,
    required this.shopImage,
    required this.thumbnailImage,
    required this.isFavorite,
    required this.isAuction,
    required this.favoriteCount,
    required this.commentsCount,
    required this.auctionEndDateString,
    required this.videoProvider,
    required this.videoLink,
    required this.links,
  }) {
    controllers = VideoPlayerController.networkUrl(Uri.parse(videoLink));
  }

  factory Reels.fromJson(Map<dynamic, dynamic> json) => Reels(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        shopName: json["shop_name"],
        shopImage: json["shop_image"],
        thumbnailImage: json["thumbnail_image"],
        isFavorite: json["is_favorite"],
        isAuction: json["is_auction"],
        favoriteCount: json["favorite_count"],
        commentsCount: json["comments_count"],
        auctionEndDateString: DateTime.parse(json["auction_end_date_string"]),
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
        links: DatumLinks.fromJson(json["links"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "shop_name": shopName,
        "shop_image": shopImage,
        "thumbnail_image": thumbnailImage,
        "is_favorite": isFavorite,
        "is_auction": isAuction,
        "favorite_count": favoriteCount,
        "comments_count": commentsCount,
        "auction_end_date_string": auctionEndDateString.toIso8601String(),
        "video_provider": videoProvider,
        "video_link": videoLink,
        "links": links.toJson(),
      };
}

class DatumLinks {
  dynamic comments;

  DatumLinks({
    required this.comments,
  });

  factory DatumLinks.fromJson(Map<dynamic, dynamic> json) => DatumLinks(
        comments: json["comments"],
      );

  Map<dynamic, dynamic> toJson() => {
        "comments": comments,
      };
}

class ReelResponseLinks {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  ReelResponseLinks({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory ReelResponseLinks.fromJson(Map<dynamic, dynamic> json) =>
      ReelResponseLinks(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<dynamic, dynamic> toJson() => {
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

  factory Meta.fromJson(Map<dynamic, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<dynamic, dynamic> toJson() => {
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

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<dynamic, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<dynamic, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
