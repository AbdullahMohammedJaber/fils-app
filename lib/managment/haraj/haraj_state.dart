// ignore_for_file: must_be_immutable

part of 'haraj_cubit.dart';

@immutable
class HarajState {
  final bool loading;
  final String? error;
  final String? errorHarajInCategory;
  final String? errorDetails;
  final bool hasMore;
  final bool hasMoreHarajInCategory;
  final bool loadingDetails;
  final List<MarketOpenResponse> products;
  final List<MarketOpenResponse>? productInCategory;
  final DetailsOpenMarketResponse? detailsOpenMarketResponse;
  final int? idCategory;
  final String? nameCategory;
  final File? imageProduct;
  final String? idImage;
  bool loadingUploadImage;
  bool loadingAddHaraj;
  bool loadingHarajInCategory;

  HarajState({
    this.loading = false,
    this.loadingDetails = false,
    this.loadingHarajInCategory = false,
    this.loadingAddHaraj = false,
    this.loadingUploadImage = false,
    this.error,
    this.errorHarajInCategory,
    this.idImage,
    this.imageProduct,
    this.detailsOpenMarketResponse,
    this.errorDetails,
    this.hasMore = true,
    this.hasMoreHarajInCategory = true,
    required this.products,
    this.productInCategory,
    this.idCategory,
    this.nameCategory,
  });

  HarajState copyWith({
    bool? loading,
    bool? loadingAddHaraj,
    bool? loadingHarajInCategory,
    bool? loadingDetails,
    String? error,
    String? errorHarajInCategory,
    String? errorDetails,
    bool? hasMore,
    bool? hasMoreHarajInCategory,
    int? idCategory,
    String? nameCategory,
    List<MarketOpenResponse>? product,
    List<MarketOpenResponse>? productInCategory,
    DetailsOpenMarketResponse? detailsOpenMarketResponse,
    File? imageProduct,
    String? idImage,
    bool? loadingUploadImage,
  }) {
    return HarajState(
      loading: loading ?? this.loading,
      loadingHarajInCategory:
          loadingHarajInCategory ?? this.loadingHarajInCategory,
      error: error,
      errorHarajInCategory: errorHarajInCategory,
      errorDetails: errorDetails,
      hasMore: hasMore ?? this.hasMore,
      hasMoreHarajInCategory:
          hasMoreHarajInCategory ?? this.hasMoreHarajInCategory,
      products: product ?? this.products,

      productInCategory: productInCategory,
      detailsOpenMarketResponse: detailsOpenMarketResponse,
      loadingDetails: loadingDetails ?? this.loadingDetails,
      loadingAddHaraj: loadingAddHaraj ?? this.loadingAddHaraj,
      loadingUploadImage: loadingUploadImage ?? this.loadingUploadImage,
      idCategory: idCategory ?? this.idCategory,
      nameCategory: nameCategory ?? this.nameCategory,
      imageProduct: imageProduct ?? this.imageProduct,
      idImage: idImage ?? this.idImage,
    );
  }

  factory HarajState.initial({required List<MarketOpenResponse> list}) {
    return HarajState(
      loadingAddHaraj: false,
      loadingUploadImage: false,
      idImage: null,
      imageProduct: null,
      nameCategory: null,
      idCategory: null,
      products: list,
    );
  }

  factory HarajState.clearList() {
    return HarajState(products: []);
  }

  factory HarajState.clearAttachment({required List<MarketOpenResponse> list}) {
    return HarajState(
      imageProduct: null,
      idImage: null,
      products: list,
    );
  }
}
