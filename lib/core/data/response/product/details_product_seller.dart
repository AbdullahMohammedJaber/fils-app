// ignore_for_file: non_constant_identifier_names, prefer_if_null_operators

import 'dart:convert';

class DetailsProductSellerResponse {
  DetailsProductSeller data;
  bool result;
  dynamic status;

  DetailsProductSellerResponse({
    required this.data,
    required this.result,
    required this.status,
  });

  factory DetailsProductSellerResponse.fromRawJson(dynamic str) =>
      DetailsProductSellerResponse.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory DetailsProductSellerResponse.fromJson(Map<dynamic, dynamic> json) =>
      DetailsProductSellerResponse(
        data: DetailsProductSeller.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "data": data.toJson(),
        "result": result,
        "status": status,
      };
}

class DetailsProductSeller {
  dynamic id;
  dynamic lang;
  dynamic productName;
  dynamic shopId;
  dynamic shopSlug;
  dynamic shopName;
  dynamic shopLogo;
  dynamic productUnit;
  dynamic description;
  dynamic categoryId;
  List<dynamic> categoryIds;
  dynamic brandId;
  MetaImg photos;
  MetaImg thumbnailImg;
  dynamic videoProvider;
  dynamic videoLink;
  dynamic tags;
  dynamic unitPrice;
  dynamic priceAfterDiscount;
  dynamic purchasePrice;
  dynamic variantProduct;
  List<dynamic> attributes;
  List<ChoiceOption> choiceOptions;
  List<dynamic> colors;
  dynamic variations;
  Stocks stocks;
  dynamic todaysDeal;
  dynamic published;
  dynamic approved;
  dynamic stockVisibilityState;
  dynamic cashOnDelivery;
  dynamic featured;
  dynamic sellerFeatured;
  dynamic currentStock;
  dynamic weight;
  dynamic minQty;
  dynamic lowStockQuantity;
  dynamic discount;
  dynamic discountType;
  DateTime discountStartDate;
  DateTime discountEndDate;
  List<dynamic> tax;
  dynamic taxType;
  dynamic shippingType;
  dynamic shippingCost;
  dynamic isQuantityMultiplied;
  dynamic estShippingDays;
  dynamic numOfSale;
  dynamic metaTitle;
  dynamic metaDescription;
  MetaImg metaImg;
  MetaImg pdf;
  dynamic slug;
  dynamic rating;
  dynamic barcode;
  dynamic digital;
  dynamic auctionProduct;
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  dynamic reviews_count;
  dynamic fav_count;
  dynamic externalLinkBtn;
  dynamic wholesaleProduct;
  bool isFavorite;
  DateTime createdAt;
  DateTime updatedAt;

  DetailsProductSeller({
    required this.id,
    required this.lang,
    required this.reviews_count,
    required this.fav_count,
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
    required this.thumbnailImg,
    required this.videoProvider,
    required this.videoLink,
    required this.tags,
    required this.unitPrice,
    required this.priceAfterDiscount,
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
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DetailsProductSeller.fromRawJson(dynamic str) =>
      DetailsProductSeller.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory DetailsProductSeller.fromJson(Map<dynamic, dynamic> json) =>
      DetailsProductSeller(
        id: json["id"],
        lang: json["lang"],
        reviews_count:
            json["reviews_count"] == null ? "11" : json["reviews_count"],
        fav_count: json["fav_count"] == null ? "15" : json["fav_count"],
        productName: json["product_name"],
        shopId: json["shop_id"],
        shopSlug: json["shop_slug"],
        shopName: json["shop_name"],
        shopLogo: json["shop_logo"],
        productUnit: json["product_unit"],
        description: json["description"],
        categoryId: json["category_id"],
        categoryIds: List<dynamic>.from(json["category_ids"].map((x) => x)),
        brandId: json["brand_id"],
        photos: MetaImg.fromJson(json["photos"]),
        thumbnailImg: MetaImg.fromJson(json["thumbnail_img"]),
        videoProvider:
            json["video_provider"] == null ? "" : json["video_provider"],
        videoLink: json["video_link"],
        tags: json["tags"],
        unitPrice: json["unit_price"],
        priceAfterDiscount: json["price_after_discount"],
        purchasePrice:
            json["purchase_price"] == null ? "" : json["purchase_price"],
        variantProduct: json["variant_product"],
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        choiceOptions: List<ChoiceOption>.from(
            json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
        colors: List<dynamic>.from(json["colors"].map((x) => x)),
        variations: json["variations"],
        stocks: Stocks.fromJson(json["stocks"]),
        todaysDeal: json["todays_deal"],
        published: json["published"],
        approved: json["approved"],
        stockVisibilityState: json["stock_visibility_state"],
        cashOnDelivery: json["cash_on_delivery"],
        featured: json["featured"],
        sellerFeatured: json["seller_featured"],
        currentStock: json["current_stock"],
        weight: json["weight"],
        minQty: json["min_qty"],
        lowStockQuantity: json["low_stock_quantity"],
        discount: json["discount"],
        discountType: json["discount_type"],
        discountStartDate: DateTime.parse(json["discount_start_date"]),
        discountEndDate: DateTime.parse(json["discount_end_date"]),
        tax: List<dynamic>.from(json["tax"].map((x) => x)),
        taxType: json["tax_type"],
        shippingType: json["shipping_type"],
        shippingCost: json["shipping_cost"],
        isQuantityMultiplied: json["is_quantity_multiplied"],
        estShippingDays:
            json["est_shipping_days"] == null ? "" : json["est_shipping_days"],
        numOfSale: json["num_of_sale"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg: MetaImg.fromJson(json["meta_img"]),
        pdf: MetaImg.fromJson(json["pdf"]),
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
        isFavorite: json["is_favorite"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "product_name": productName,
        "fav_count": fav_count,
        "reviews_count": reviews_count,
        "shop_id": shopId,
        "shop_slug": shopSlug,
        "shop_name": shopName,
        "shop_logo": shopLogo,
        "product_unit": productUnit,
        "description": description,
        "category_id": categoryId,
        "category_ids": List<dynamic>.from(categoryIds.map((x) => x)),
        "brand_id": brandId,
        "photos": photos.toJson(),
        "thumbnail_img": thumbnailImg.toJson(),
        "video_provider": videoProvider,
        "video_link": videoLink,
        "tags": tags,
        "unit_price": unitPrice,
        "price_after_discount": priceAfterDiscount,
        "purchase_price": purchasePrice,
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes.map((x) => x)),
        "choice_options":
            List<dynamic>.from(choiceOptions.map((x) => x.toJson())),
        "colors": List<dynamic>.from(colors.map((x) => x)),
        "variations": variations,
        "stocks": stocks.toJson(),
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
            "${discountStartDate.year.toString().padLeft(4, '0')}-${discountStartDate.month.toString().padLeft(2, '0')}-${discountStartDate.day.toString().padLeft(2, '0')}",
        "discount_end_date":
            "${discountEndDate.year.toString().padLeft(4, '0')}-${discountEndDate.month.toString().padLeft(2, '0')}-${discountEndDate.day.toString().padLeft(2, '0')}",
        "tax": List<dynamic>.from(tax.map((x) => x)),
        "tax_type": taxType,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "is_quantity_multiplied": isQuantityMultiplied,
        "est_shipping_days": estShippingDays,
        "num_of_sale": numOfSale,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg.toJson(),
        "pdf": pdf.toJson(),
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
        "is_favorite": isFavorite,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class ChoiceOption {
  dynamic attributeId;
  List<dynamic> values;

  ChoiceOption({
    required this.attributeId,
    required this.values,
  });

  factory ChoiceOption.fromRawJson(dynamic str) =>
      ChoiceOption.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory ChoiceOption.fromJson(Map<dynamic, dynamic> json) => ChoiceOption(
        attributeId: json["attribute_id"],
        values: List<dynamic>.from(json["values"].map((x) => x)),
      );

  Map<dynamic, dynamic> toJson() => {
        "attribute_id": attributeId,
        "values": List<dynamic>.from(values.map((x) => x)),
      };
}

class MetaImg {
  List<MetaImgDatum> data;

  MetaImg({
    required this.data,
  });

  factory MetaImg.fromRawJson(dynamic str) => MetaImg.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory MetaImg.fromJson(Map<dynamic, dynamic> json) => MetaImg(
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

  factory MetaImgDatum.fromRawJson(dynamic str) =>
      MetaImgDatum.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

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

class Stocks {
  List<StocksDatum> data;

  Stocks({
    required this.data,
  });

  factory Stocks.fromRawJson(dynamic str) => Stocks.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

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
  MetaImg image;

  StocksDatum({
    required this.id,
    required this.productId,
    required this.variant,
    required this.sku,
    required this.price,
    required this.qty,
    required this.image,
  });

  factory StocksDatum.fromRawJson(dynamic str) =>
      StocksDatum.fromJson(json.decode(str));

  dynamic toRawJson() => json.encode(toJson());

  factory StocksDatum.fromJson(Map<dynamic, dynamic> json) => StocksDatum(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        sku: json["sku"] == null ? "" : json["sku"],
        price: json["price"],
        qty: json["qty"],
        image: MetaImg.fromJson(json["image"]),
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
