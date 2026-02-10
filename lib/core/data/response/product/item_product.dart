// ignore_for_file: non_constant_identifier_names



import '../home/home_response.dart';

class ProductListModel {
  dynamic id;
  dynamic slug;
  dynamic name;
  dynamic thumbnailImage;
  bool? hasDiscount;
  dynamic discount;
  dynamic strokedPrice;
  dynamic mainPrice;
  dynamic rating;
  dynamic sales;
  bool? isWholesale;
  bool? is_favorite;
  Links? links;
  dynamic shop_name;
  dynamic shop_logo;
  dynamic current_stock;
  ProductListModel({
    required this.id,
    required this.current_stock,
    required this.shop_name,
    required this.shop_logo,
    required this.is_favorite,
    required this.slug,
    required this.name,
    required this.thumbnailImage,
    required this.hasDiscount,
    required this.discount,
    required this.strokedPrice,
    required this.mainPrice,
    required this.rating,
    required this.sales,
    required this.isWholesale,
    required this.links,
  });

  factory ProductListModel.fromJson(Map<dynamic, dynamic> json) =>
      ProductListModel(
        id: json["id"],
        current_stock: json["current_stock"],
        slug: json["slug"],
        shop_logo: json["shop_logo"],
        is_favorite: json["is_favorite"],
        name: json["name"],
        shop_name: json["shop_name"],
        thumbnailImage: json["thumbnail_image"],
        hasDiscount: json["has_discount"],
        discount: json["discount"],
        strokedPrice: json["stroked_price"],
        mainPrice: json["main_price"],
        rating: json["rating"],
        sales: json["sales"],
        isWholesale: json["is_wholesale"],
        links: Links.fromJson(json["links"]),
      );

  Map<dynamic, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "current_stock": current_stock,
    "shop_logo": shop_logo,
    "is_favorite": is_favorite,
    "name": name,
    "shop_name": shop_name,
    "thumbnail_image": thumbnailImage,
    "has_discount": hasDiscount,
    "discount": discount,
    "stroked_price": strokedPrice,
    "main_price": mainPrice,
    "rating": rating,
    "sales": sales,
    "is_wholesale": isWholesale,
    "links": links!.toJson(),
  };
}
