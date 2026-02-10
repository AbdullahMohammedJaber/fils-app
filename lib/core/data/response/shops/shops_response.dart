// To parse this JSON data, do
//
//     final shopsResponse = shopsResponseFromJson(jsonString);

import 'dart:convert';

ShopsResponse shopsResponseFromJson(String str) => ShopsResponse.fromJson(json.decode(str));

String shopsResponseToJson(ShopsResponse data) => json.encode(data.toJson());

class ShopsResponse {
    Data data;
    String message;
    bool result;
    int code;

    ShopsResponse({
        required this.data,
        required this.message,
        required this.result,
        required this.code,
    });

    factory ShopsResponse.fromJson(Map<String, dynamic> json) => ShopsResponse(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        result: json["result"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "result": result,
        "code": code,
    };
}

class Data {
    List<Shop> data;
    bool success;
    int status;

    Data({
        required this.data,
        required this.success,
        required this.status,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Shop>.from(json["data"].map((x) => Shop.fromJson(x))),
        success: json["success"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
        "status": status,
    };
}

class Shop {
    int id;
    String slug;
    String name;
    String logo;
    int rating;
    dynamic productsCount;
    int totalSales;
    String address;
    String description;

    Shop({
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

    factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        id: json["id"],
        slug: json["slug"],
        name: json["name"],
        logo: json["logo"],
        rating: json["rating"],
        productsCount: json["products_count"],
        totalSales: json["total_sales"],
        address: json["address"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "slug": slug,
        "name": name,
        "logo": logo,
        "rating": rating,
        "products_count": productsCount,
        "total_sales": totalSales,
        "address": address,
        "description": description,
    };
}
