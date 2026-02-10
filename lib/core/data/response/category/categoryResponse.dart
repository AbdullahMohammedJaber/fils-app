// To parse this JSON data, do
//
//     final CategoryResponse = CategoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse CategoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String CategoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  List<Category> data;
  bool success;
  dynamic status;

  CategoryResponse({
    required this.data,
    required this.success,
    required this.status,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        data: List<Category>.from(
          json["data"].map((x) => Category.fromJson(x)),
        ),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class Category {
  dynamic id;
  String slug;
  String name;
  String banner;
  String icon;
  dynamic numberOfChildren;
  Links links;

  Category({
    required this.id,
    required this.slug,
    required this.name,
    required this.banner,
    required this.icon,
    required this.numberOfChildren,
    required this.links,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    banner: json["banner"],
    icon: json["icon"],
    numberOfChildren: json["number_of_children"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "banner": banner,
    "icon": icon,
    "number_of_children": numberOfChildren,
    "links": links.toJson(),
  };
}

class Links {
  String products;
  String subCategories;
  String stores;

  Links({
    required this.products,
    required this.subCategories,
    required this.stores,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    products: json["products"],
    subCategories: json["sub_categories"],
    stores: json["stores"],
  );

  Map<String, dynamic> toJson() => {
    "products": products,
    "sub_categories": subCategories,
    "stores": stores,
  };
}
