// ignore_for_file: must_be_immutable

part of 'product_seller_cubit.dart';

@immutable
class ProductSellerState {
  final bool loading;
  // Data Form
  final bool loadingUploadImage;
  final int? idCategory;
  final String? nameCategory;
  final String? nameCategores;
  final File? imageProduct;
  final String? idImage;
  final List<int> categoryIds;

  // get All Product Seller State
  final bool loadingGetAllProduct;
  List<ProductSeller> products;
  final String? error;
  final bool hasMore;
  // get Details Product
  final DetailsProductSellerResponse? detailsProductSellerResponse;
  final bool loadingGetDetailsProduct;
  final String? errorDetails;
  // Color & Size List
  final String hintOption;
  final bool selectColor;
  final bool selectSize;
  final List<Value>? sizeList;
  final List<Value>  sizeSelect;

  final List<ColorProduct>? colorList;
  final List<ColorProduct>  colorSelect;

  ProductSellerState({
    this.errorDetails,
    this.hintOption = "Add Options (Colors, size)",
    this.selectColor = false,
    this.selectSize = false,
    this.sizeList,
    this.colorList,
    this.colorSelect = const [],
    this.sizeSelect = const [],
    this.loadingGetDetailsProduct = true,
    this.detailsProductSellerResponse,
    this.loading = false,
    this.loadingGetAllProduct = false,
    this.hasMore = true,
    this.products = const [],
    this.error,
    this.nameCategores,
    this.categoryIds = const [],
    this.idCategory,
    this.nameCategory,
    this.imageProduct,
    this.idImage,
    this.loadingUploadImage = false,
  });

  ProductSellerState copyWith({
    bool? loading,
    bool? loadingGetAllProduct,
    List<ProductSeller>? products,
    String? error,
    bool? hasMore,
    DetailsProductSellerResponse? detailsProductSellerResponse,
    bool? loadingGetDetailsProduct,
    String? errorDetails,
    String? hintOption,
    int? idCategory,
    String? nameCategory,
    File? imageProduct,
    String? idImage,
    bool? loadingUploadImage,
    List<int>? categoryIds,
    String? nameCategores,
    bool? selectColor,
    bool? selectSize,
    List<Value>? sizeList,
    List<ColorProduct>? colorList,
    List<Value>? sizeSelect,
    List<ColorProduct>? colorSelect,
  }) {
    return ProductSellerState(
      loading: loading ?? this.loading,
      loadingGetAllProduct: loadingGetAllProduct ?? this.loadingGetAllProduct,
      products: products ?? this.products,
      error: error  ,
      hasMore: hasMore ?? this.hasMore,
      idCategory: idCategory ?? this.idCategory,
      nameCategory: nameCategory ?? this.nameCategory,
      imageProduct: imageProduct ?? this.imageProduct,
      idImage: idImage ?? this.idImage,
      loadingUploadImage: loadingUploadImage ?? this.loadingUploadImage,
      categoryIds: categoryIds ?? this.categoryIds,
      nameCategores: nameCategores ?? this.nameCategores,
      detailsProductSellerResponse:
          detailsProductSellerResponse ?? this.detailsProductSellerResponse,
      errorDetails: errorDetails,
      loadingGetDetailsProduct:
          loadingGetDetailsProduct ?? this.loadingGetDetailsProduct,
      hintOption: hintOption ?? this.hintOption,
      selectColor: selectColor ?? this.selectColor,
      selectSize: selectSize ?? this.selectSize,
      sizeList: sizeList ?? this.sizeList,
      colorList: colorList ?? this.colorList,
      colorSelect: colorSelect ?? this.colorSelect,
      sizeSelect: sizeSelect ?? this.sizeSelect,
    );
  }

  factory ProductSellerState.initial({required List<ProductSeller> products}) {
    return ProductSellerState(
      loading: false,
      loadingGetAllProduct: false,
      hasMore: false,
      products: products,
      error: null,
      selectColor: false,
      idCategory: null,
      nameCategory: null,
      imageProduct: null,
      idImage: null,
      loadingUploadImage: false,
      categoryIds: [],
      nameCategores: null,
      selectSize: false,
      sizeList: null,
      colorList: null,
      sizeSelect: [],
      colorSelect: [],
    );
  }

  factory ProductSellerState.clearAttachment({
    List<int>? categoryIds,
    String? nameCategores,
    int? idCategory,
    String? nameCategory,
    List<Value>? sizeLSelect,
    List<ColorProduct>? colorSelect,
  }) {
    return ProductSellerState(
      imageProduct: null,
      idImage: null,
      loadingUploadImage: false,
      categoryIds: categoryIds ?? [],
      nameCategores: nameCategores,
      idCategory: idCategory,
      nameCategory: nameCategory,
      colorSelect: colorSelect!,
      sizeSelect:  sizeLSelect!,
    );
  }
}
