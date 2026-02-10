// To parse this JSON data, do
//
//     final detailsProductResponse = detailsProductResponseFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

DetailsProductResponse detailsProductResponseFromJson(dynamic str) =>
    DetailsProductResponse.fromJson(json.decode(str));

dynamic detailsProductResponseToJson(DetailsProductResponse data) =>
    json.encode(data.toJson());

class DetailsProductResponse {
  bool result;
  DetailsProductResponseData data;
  num code;

  DetailsProductResponse({
    required this.result,
    required this.data,
    required this.code,
  });

  factory DetailsProductResponse.fromJson(Map<dynamic, dynamic> json) =>
      DetailsProductResponse(
        result: json["result"],
        data: DetailsProductResponseData.fromJson(json["data"]),
        code: json["code"],
      );

  Map<dynamic, dynamic> toJson() => {
        "result": result,
        "data": data.toJson(),
        "code": code,
      };
}

class DetailsProductResponseData {
  Product product;

  DetailsProductResponseData({
    required this.product,
  });

  factory DetailsProductResponseData.fromJson(Map<dynamic, dynamic> json) =>
      DetailsProductResponseData(
        product: Product.fromJson(json["product"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "product": product.toJson(),
      };
}

class Product {
  ProductData data;
  bool result;
  dynamic status;

  Product({
    required this.data,
    required this.result,
    required this.status,
  });

  factory Product.fromJson(Map<dynamic, dynamic> json) => Product(
        data: ProductData.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "result": result,
        "status": status,
      };
}

class ProductData {
  dynamic id;
  dynamic lang;
  dynamic productName;
  dynamic shopId;
  dynamic shopSlug;
  dynamic shopName;
  dynamic shopLogo;
  dynamic price_after_discount;
  dynamic productUnit;
  dynamic description;
  dynamic categoryId;
  List<dynamic>? categoryIds;
  dynamic brandId;
  Photos? photos;
  Img? thumbnailImg;
  dynamic videoProvider;
  dynamic videoLink;
  dynamic tags;
  num? unitPrice;
  dynamic purchasePrice;
  num? variantProduct;
  List<dynamic>? attributes;
  List<ChoiceOption>? choiceOptions;
  List<dynamic>? colors;
  dynamic variations;
  Stocks? stocks;
  num? todaysDeal;
  num? published;
  num? approved;
  dynamic stockVisibilityState;
  num? cashOnDelivery;
  num? featured;
  num? sellerFeatured;
  dynamic currentStock;
  double? weight;
  num? minQty;
  num? lowStockQuantity;
  num? discount;
  dynamic discountType;
  DateTime? discountStartDate;
  DateTime? discountEndDate;
  List<Tax>? tax;
  dynamic taxType;
  dynamic shippingType;
  num? shippingCost;
  num? isQuantityMultiplied;
  num? estShippingDays;
  num? numOfSale;
  dynamic metaTitle;
  dynamic metaDescription;
  Img? metaImg;
  Pdf? pdf;
  dynamic slug;
  num? rating;
  dynamic barcode;
  num? digital;
  num? auctionProduct;
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  dynamic externalLinkBtn;
  num? wholesaleProduct;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool is_favorite;

  ProductData({
    required this.id,
    required this.is_favorite,
    required this.lang,
    required this.productName,
    required this.shopId,
    required this.shopSlug,
    required this.shopName,
    required this.shopLogo,
    required this.productUnit,
    required this.description,
    required this.categoryId,
    required this.categoryIds,
    required this.brandId,
    required this.photos,
    required this.price_after_discount,
    required this.thumbnailImg,
    required this.videoProvider,
    required this.videoLink,
    required this.tags,
    required this.unitPrice,
    required this.purchasePrice,
    required this.variantProduct,
    required this.attributes,
    required this.choiceOptions,
    required this.colors,
    required this.variations,
    required this.stocks,
    required this.todaysDeal,
    required this.published,
    required this.approved,
    required this.stockVisibilityState,
    required this.cashOnDelivery,
    required this.featured,
    required this.sellerFeatured,
    required this.currentStock,
    required this.weight,
    required this.minQty,
    required this.lowStockQuantity,
    required this.discount,
    required this.discountType,
    required this.discountStartDate,
    required this.discountEndDate,
    required this.tax,
    required this.taxType,
    required this.shippingType,
    required this.shippingCost,
    required this.isQuantityMultiplied,
    required this.estShippingDays,
    required this.numOfSale,
    required this.metaTitle,
    required this.metaDescription,
    required this.metaImg,
    required this.pdf,
    required this.slug,
    required this.rating,
    required this.barcode,
    required this.digital,
    required this.auctionProduct,
    required this.fileName,
    required this.filePath,
    required this.externalLink,
    required this.externalLinkBtn,
    required this.wholesaleProduct,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductData.fromJson(Map<dynamic, dynamic> json) => ProductData(
        id: json["id"],
        is_favorite: json["is_favorite"],
        lang: json["lang"] ?? "",
        productName: json["product_name"],
        shopId: json["shop_id"],
        price_after_discount: json["price_after_discount"],
        shopSlug: json["shop_slug"],
        shopName: json["shop_name"],
        shopLogo: json["shop_logo"],
        productUnit: json["product_unit"],
        description: json["description"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"] == null
            ? null
            : List<dynamic>.from(json["category_ids"].map((x) => x)),
        brandId: json["brand_id"],
        photos: json["photos"] == null ? null : Photos.fromJson(json["photos"]),
        thumbnailImg: json["thumbnail_img"] == null
            ? null
            : Img.fromJson(json["thumbnail_img"]),
        videoProvider: json["video_provider"] ?? "",
        videoLink: json["video_link"] ?? "",
        tags: json["tags"] ?? "",
        unitPrice: json["unit_price"] ?? 0,
        purchasePrice: json["purchase_price"] ?? 0,
        variantProduct: json["variant_product"] ?? 0,
        attributes: json["attributes"] == null
            ? null
            : List<dynamic>.from(json["attributes"].map((x) => x)),
        choiceOptions: json["choice_options"] == null
            ? null
            : List<ChoiceOption>.from(
                json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
        colors: json["colors"] == null
            ? null
            : List<dynamic>.from(json["colors"].map((x) => x)),
        variations: json["variations"] ?? 0,
        stocks: json["stocks"] == null ? null : Stocks.fromJson(json["stocks"]),
        todaysDeal: json["todays_deal"],
        published: json["published"],
        approved: json["approved"],
        stockVisibilityState: json["stock_visibility_state"],
        cashOnDelivery: json["cash_on_delivery"],
        featured: json["featured"],
        sellerFeatured: json["seller_featured"],
        currentStock: json["current_stock"],
        weight: json["weight"].toDouble(),
        minQty: json["min_qty"],
        lowStockQuantity: json["low_stock_quantity"],
        discount: json["discount"],
        discountType: json["discount_type"],
        discountStartDate: DateTime.parse(json["discount_start_date"]),
        discountEndDate: DateTime.parse(json["discount_end_date"]),
        tax: json["tax"] == null
            ? null
            : List<Tax>.from(json["tax"].map((x) => Tax.fromJson(x))),
        taxType: json["tax_type"],
        shippingType: json["shipping_type"],
        shippingCost: json["shipping_cost"],
        isQuantityMultiplied: json["is_quantity_multiplied"],
        estShippingDays: json["est_shipping_days"],
        numOfSale: json["num_of_sale"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg:
            json["meta_img"] == null ? null : Img.fromJson(json["meta_img"]),
        pdf: json["pdf"] == null ? null : Pdf.fromJson(json["pdf"]),
        slug: json["slug"],
        rating: json["rating"],
        barcode: json["barcode"],
        digital: json["digital"],
        auctionProduct: json["auction_product"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        externalLink: json["external_link"],
        externalLinkBtn: json["external_link_btn"],
        wholesaleProduct: json["wholesale_product"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "is_favorite": is_favorite,
        "price_after_discount": price_after_discount,
        "product_name": productName,
        "shop_id": shopId,
        "shop_slug": shopSlug,
        "shop_name": shopName,
        "shop_logo": shopLogo,
        "product_unit": productUnit,
        "description": description,
        "category_id": categoryId,
        "category_ids": List<dynamic>.from(categoryIds!.map((x) => x)),
        "brand_id": brandId,
        "photos": photos!.toJson(),
        "thumbnail_img": thumbnailImg!.toJson(),
        "video_provider": videoProvider,
        "video_link": videoLink,
        "tags": tags,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes!.map((x) => x)),
        "choice_options":
            List<dynamic>.from(choiceOptions!.map((x) => x.toJson())),
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "variations": variations,
        "stocks": stocks!.toJson(),
        "todays_deal": todaysDeal,
        "published": published,
        "approved": approved,
        "stock_visibility_state": stockVisibilityState,
        "cash_on_delivery": cashOnDelivery,
        "featured": featured,
        "seller_featured": sellerFeatured,
        "current_stock": currentStock,
        "weight": weight,
        "min_qty": minQty,
        "low_stock_quantity": lowStockQuantity,
        "discount": discount,
        "discount_type": discountType,
        "discount_start_date":
            "${discountStartDate!.year.toString().padLeft(4, '0')}-${discountStartDate!.month.toString().padLeft(2, '0')}-${discountStartDate!.day.toString().padLeft(2, '0')}",
        "discount_end_date":
            "${discountEndDate!.year.toString().padLeft(4, '0')}-${discountEndDate!.month.toString().padLeft(2, '0')}-${discountEndDate!.day.toString().padLeft(2, '0')}",
        "tax": List<dynamic>.from(tax!.map((x) => x.toJson())),
        "tax_type": taxType,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "is_quantity_multiplied": isQuantityMultiplied,
        "est_shipping_days": estShippingDays,
        "num_of_sale": numOfSale,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg!.toJson(),
        "pdf": pdf!.toJson(),
        "slug": slug,
        "rating": rating,
        "barcode": barcode,
        "digital": digital,
        "auction_product": auctionProduct,
        "file_name": fileName,
        "file_path": filePath,
        "external_link": externalLink,
        "external_link_btn": externalLinkBtn,
        "wholesale_product": wholesaleProduct,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ChoiceOption {
  dynamic attributeId;
  List<dynamic>? values;

  ChoiceOption({
    required this.attributeId,
    required this.values,
  });

  factory ChoiceOption.fromJson(Map<dynamic, dynamic> json) => ChoiceOption(
        attributeId: json["attribute_id"],
        values: List<dynamic>.from(json["values"].map((x) => x)),
      );

  Map<dynamic, dynamic> toJson() => {
        "attribute_id": attributeId,
        "values": List<dynamic>.from(values!.map((x) => x)),
      };
}

class Img {
  List<MetaImgDatum> data;

  Img({
    required this.data,
  });

  factory Img.fromJson(Map<dynamic, dynamic> json) => Img(
        data: List<MetaImgDatum>.from(
            json["data"].map((x) => MetaImgDatum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MetaImgDatum {
  dynamic id;
  dynamic fileOriginalName;
  dynamic fileName;
  dynamic url;
  dynamic fileSize;
  dynamic extension;
  dynamic type;

  MetaImgDatum({
    required this.id,
    required this.fileOriginalName,
    required this.fileName,
    required this.url,
    required this.fileSize,
    required this.extension,
    required this.type,
  });

  factory MetaImgDatum.fromJson(Map<dynamic, dynamic> json) => MetaImgDatum(
        id: json["id"],
        fileOriginalName: json["file_original_name"],
        fileName: json["file_name"],
        url: json["url"],
        fileSize: json["file_size"],
        extension: json["extension"],
        type: json["type"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "file_original_name": fileOriginalName,
        "file_name": fileName,
        "url": url,
        "file_size": fileSize,
        "extension": extension,
        "type": type,
      };
}

class Pdf {
  List<dynamic>? data;

  Pdf({
    required this.data,
  });

  factory Pdf.fromJson(Map<dynamic, dynamic> json) => Pdf(
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x)),
      };
}

class Photos {
  List<PhotosDatum> data;

  Photos({
    required this.data,
  });

  factory Photos.fromJson(Map<dynamic, dynamic> json) => Photos(
        data: List<PhotosDatum>.from(
            json["data"].map((x) => PhotosDatum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PhotosDatum {
  dynamic id;
  dynamic fileOriginalName;
  dynamic fileName;
  dynamic url;
  dynamic fileSize;
  dynamic extension;
  dynamic type;

  PhotosDatum({
    required this.id,
    required this.fileOriginalName,
    required this.fileName,
    required this.url,
    required this.fileSize,
    required this.extension,
    required this.type,
  });

  factory PhotosDatum.fromJson(Map<dynamic, dynamic> json) => PhotosDatum(
        id: json["id"],
        fileOriginalName: json["file_original_name"],
        fileName: json["file_name"],
        url: json["url"],
        fileSize: json["file_size"],
        extension: json["extension"],
        type: json["type"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "file_original_name": fileOriginalName,
        "file_name": fileName,
        "url": url,
        "file_size": fileSize,
        "extension": extension,
        "type": type,
      };
}

class Stocks {
  List<StocksDatum> data;

  Stocks({
    required this.data,
  });

  factory Stocks.fromJson(Map<dynamic, dynamic> json) => Stocks(
        data: List<StocksDatum>.from(
            json["data"].map((x) => StocksDatum.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StocksDatum {
  dynamic id;
  dynamic productId;
  dynamic variant;
  dynamic sku;
  dynamic price;
  dynamic qty;
  Pdf image;

  StocksDatum({
    required this.id,
    required this.productId,
    required this.variant,
    required this.sku,
    required this.price,
    required this.qty,
    required this.image,
  });

  factory StocksDatum.fromJson(Map<dynamic, dynamic> json) => StocksDatum(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        sku: json["sku"],
        price: json["price"],
        qty: json["qty"],
        image: Pdf.fromJson(json["image"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variant": variant,
        "sku": sku,
        "price": price,
        "qty": qty,
        "image": image.toJson(),
      };
}

class Tax {
  dynamic id;
  dynamic productId;
  dynamic taxId;
  dynamic tax;
  dynamic taxType;
  DateTime createdAt;
  DateTime updatedAt;

  Tax({
    required this.id,
    required this.productId,
    required this.taxId,
    required this.tax,
    required this.taxType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Tax.fromJson(Map<dynamic, dynamic> json) => Tax(
        id: json["id"],
        productId: json["product_id"],
        taxId: json["tax_id"],
        tax: json["tax"],
        taxType: json["tax_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "tax_id": taxId,
        "tax": tax,
        "tax_type": taxType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
