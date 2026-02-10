
import 'dart:convert';

class DetailsOpenMarketResponse {
  List<DetailsOpenMarketResponseDatum>? data;
  bool? success;
  int? status;

  DetailsOpenMarketResponse({
    this.data,
    this.success,
    this.status,
  });

  factory DetailsOpenMarketResponse.fromRawJson(String str) => DetailsOpenMarketResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailsOpenMarketResponse.fromJson(Map<String, dynamic> json) => DetailsOpenMarketResponse(
    data: json["data"] == null ? [] : List<DetailsOpenMarketResponseDatum>.from(json["data"]!.map((x) => DetailsOpenMarketResponseDatum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class DetailsOpenMarketResponseDatum {
  int? id;
  String? name;
  String? addedBy;
  String? phone;
  String? condition;
  MetaImage? photos;
  MetaImage? thumbnailImage;
  List<String>? tags;
  String? location;
  String? unitPrice;
  String? unit;
  String? description;
  String? videoLink;
  Brand? brand;
  String? category;
  String? link;
  dynamic metaTitle;
  dynamic metaDescription;
  MetaImage? metaImage;
  MetaImage? pdf;

  DetailsOpenMarketResponseDatum({
    this.id,
    this.name,
    this.addedBy,
    this.phone,
    this.condition,
    this.photos,
    this.thumbnailImage,
    this.tags,
    this.location,
    this.unitPrice,
    this.unit,
    this.description,
    this.videoLink,
    this.brand,
    this.category,
    this.link,
    this.metaTitle,
    this.metaDescription,
    this.metaImage,
    this.pdf,
  });

  factory DetailsOpenMarketResponseDatum.fromRawJson(String str) => DetailsOpenMarketResponseDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailsOpenMarketResponseDatum.fromJson(Map<String, dynamic> json) => DetailsOpenMarketResponseDatum(
    id: json["id"],
    name: json["name"],
    addedBy: json["added_by"],
    phone: json["phone"],
    condition: json["condition"],
    photos: json["photos"] == null ? null : MetaImage.fromJson(json["photos"]),
    thumbnailImage: json["thumbnail_image"] == null ? null : MetaImage.fromJson(json["thumbnail_image"]),
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    location: json["location"],
    unitPrice: json["unit_price"],
    unit: json["unit"],
    description: json["description"],
    videoLink: json["video_link"],
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    category: json["category"],
    link: json["link"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaImage: json["meta_image"] == null ? null : MetaImage.fromJson(json["meta_image"]),
    pdf: json["pdf"] == null ? null : MetaImage.fromJson(json["pdf"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "added_by": addedBy,
    "phone": phone,
    "condition": condition,
    "photos": photos?.toJson(),
    "thumbnail_image": thumbnailImage?.toJson(),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "location": location,
    "unit_price": unitPrice,
    "unit": unit,
    "description": description,
    "video_link": videoLink,
    "brand": brand?.toJson(),
    "category": category,
    "link": link,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_image": metaImage?.toJson(),
    "pdf": pdf?.toJson(),
  };
}

class Brand {
  int? id;
  String? slug;
  String? name;
  String? logo;

  Brand({
    this.id,
    this.slug,
    this.name,
    this.logo,
  });

  factory Brand.fromRawJson(String str) => Brand.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    slug: json["slug"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "slug": slug,
    "name": name,
    "logo": logo,
  };
}

class MetaImage {
  List<MetaImageDatum>? data;

  MetaImage({
    this.data,
  });

  factory MetaImage.fromRawJson(String str) => MetaImage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaImage.fromJson(Map<String, dynamic> json) => MetaImage(
    data: json["data"] == null ? [] : List<MetaImageDatum>.from(json["data"]!.map((x) => MetaImageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MetaImageDatum {
  int? id;
  dynamic fileOriginalName;
  String? fileName;
  String? url;
  int? fileSize;
  String? extension;
  String? type;

  MetaImageDatum({
    this.id,
    this.fileOriginalName,
    this.fileName,
    this.url,
    this.fileSize,
    this.extension,
    this.type,
  });

  factory MetaImageDatum.fromRawJson(String str) => MetaImageDatum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MetaImageDatum.fromJson(Map<String, dynamic> json) => MetaImageDatum(
    id: json["id"],
    fileOriginalName: json["file_original_name"],
    fileName: json["file_name"],
    url: json["url"],
    fileSize: json["file_size"],
    extension: json["extension"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file_original_name": fileOriginalName ,
    "file_name": fileName,
    "url": url,
    "file_size": fileSize,
    "extension": extension,
    "type": type,
  };
}
