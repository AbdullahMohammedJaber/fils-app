// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  List<Notifications> data;
  Links links;
  Meta meta;
  bool success;
  dynamic status;
  bool result;
  dynamic code;
  dynamic countUnreadNotifications;

  NotificationResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
    required this.status,
    required this.result,
    required this.code,
    required this.countUnreadNotifications,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        data: List<Notifications>.from(
          json["data"].map((x) => Notifications.fromJson(x)),
        ),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
        result: json["result"],
        code: json["code"],
        countUnreadNotifications: json["count_unread_notifications"],
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "success": success,
    "status": status,
    "result": result,
    "code": code,
    "count_unread_notifications": countUnreadNotifications,
  };
}

class Notifications {
  String? id;
  bool? isChecked;
  String? type;
  Data? data;
  String? notificationText;
  String? image;
  String? date;
  DateTime? readAt;

  Notifications({
    required this.id,
    required this.isChecked,
    required this.type,
    required this.data,
    required this.notificationText,
    required this.image,
    required this.date,
    required this.readAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
    id: json["id"],
    isChecked: json["isChecked"],
    type: json["type"],
    data: Data.fromJson(json["data"]),
    notificationText: json["notification_text"],
    image: json["image"],
    date: json["date"],
    readAt: DateTime.parse(json["read_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "isChecked": isChecked,
    "type": type,
    "data": data!.toJson(),
    "notification_text": notificationText,
    "image": image,
    "date": date,
    "read_at": readAt!.toIso8601String(),
  };
}

class Data {
  dynamic orderId;
  String? orderCode;
  dynamic userId;
  dynamic sellerId;
  String? status;

  Data({
    required this.orderId,
    required this.orderCode,
    required this.userId,
    required this.sellerId,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
    orderCode: json["order_code"],
    userId: json["user_id"],
    sellerId: json["seller_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_code": orderCode,
    "user_id": userId,
    "seller_id": sellerId,
    "status": status,
  };
}

class Links {
  dynamic first;
  dynamic last;
  dynamic prev;
  dynamic next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
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
