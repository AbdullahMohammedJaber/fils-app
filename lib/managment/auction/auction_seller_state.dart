part of 'auction_seller_cubit.dart';

class AuctionSellerState {
  final bool loading;
  final String? error;
  final bool hasMore;
  final List<AuctionSeller>? auctions;
  // Control Form
  final String? nameCategory;
  final int? idCategory;
  final List<int>? categoresId;
  String? nameCategores;
  final File? imageProduct;
  final int? idImage;
  final bool loadingForm;
  final bool typeNormal;
   final List<File>  imageProducts;
     final List<String>? imageIds; 
     final bool loadingUploadImages;
  AuctionSellerState({
    this.loading = true,
    this.typeNormal = true,
    this.error,
    this.hasMore = true,
    this.auctions,
    this.nameCategory,
    this.idCategory,
    this.categoresId,
    this.nameCategores,
    this.imageProduct,
    this.idImage,
    this.loadingForm = false,
    this.loadingUploadImages = false,
    this.imageProducts = const [],
    this.imageIds,
  });
  AuctionSellerState copyWith({
    bool? loading,
    String? error,
    bool? hasMore,
    List<AuctionSeller>? auctions,
    // Form Controll
    String? nameCategory,
    int? idCategory,
    List<int>? categoresId,
    String? nameCategores,
    File? imageProduct,
    int? idImage,
    bool? loadingForm,
    bool? typeNormal,
     List<File>? imageProducts,
    List<String>? imageIds,
    bool? loadingUploadImages,
  }) {
    return AuctionSellerState(
        imageProducts: imageProducts ?? this.imageProducts,
      imageIds: imageIds ?? this.imageIds,
      loadingUploadImages: loadingUploadImages ?? this.loadingUploadImages,
      auctions: auctions ?? this.auctions,
      error: error,
      hasMore: hasMore ?? this.hasMore,
      loading: loading ?? this.loading,
      categoresId: categoresId ?? this.categoresId,
      idCategory: idCategory ?? this.idCategory,
      idImage: idImage ?? this.idImage,
      imageProduct: imageProduct ?? this.imageProduct,
      loadingForm: loadingForm ?? this.loadingForm,
      nameCategores: nameCategores ?? this.nameCategores,
      nameCategory: nameCategory ?? this.nameCategory,
      typeNormal: typeNormal ?? this.typeNormal,
    );
  }

  factory AuctionSellerState.clearList() {
    return AuctionSellerState(auctions: null);
  }
  factory AuctionSellerState.clearAttachment({
    required List<AuctionSeller> list,
    final String? nameCategory,
    final int? idCategory,
    final List<int>? categoresId,
    String? nameCategores,
  }) {
    return AuctionSellerState(
      idImage: null,
      imageProduct: null,
      categoresId: categoresId,
      idCategory: idCategory,
      nameCategores: nameCategores,
      nameCategory: nameCategory,
    );
  }
  factory AuctionSellerState.clearForm({required List<AuctionSeller>? list}) {
    return AuctionSellerState(
      categoresId: null,
      idCategory: null,
      idImage: null,
      imageProduct: null,
      loadingForm: false,
      nameCategores: null,
      nameCategory: null,
      auctions: list,
      hasMore: false,
      error: null,
      loading: false,
         imageProducts: const [],
      imageIds: null,
       loadingUploadImages: false,
    );
  }
  deleteImageAtIndex({required int index}) {

    imageProducts.removeAt(index  ) ;
    imageIds?.removeAt(index) ;
  }
}
