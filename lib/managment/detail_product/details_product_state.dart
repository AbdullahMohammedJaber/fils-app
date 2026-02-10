part of 'details_product_cubit.dart';

class DetailsProductState {
  final bool loadingDetails;
  final bool loadingAddCart;
  final bool loadingAddCartGoCart;
  final int countItem;
  final String? error;
  final String? nameVariant;
  final DetailsProductResponse? detailsProductResponse;

  DetailsProductState({
    this.loadingDetails = false,
    this.loadingAddCart = false,
    this.loadingAddCartGoCart = false,
    this.countItem = 1,
    this.error,
    this.nameVariant,
    this.detailsProductResponse,
  });

  DetailsProductState copyWith({
    bool? loadingDetails,
    bool? loadingAddCart,
    bool? loadingAddCartGoCart,
    int? countItem,
    String? error,
    String? nameVariant,
    DetailsProductResponse? detailsProductResponse,
  }) {
    return DetailsProductState(
      error: error,
      nameVariant: nameVariant ?? this.nameVariant,
      countItem: countItem ?? this.countItem,
      detailsProductResponse:
          detailsProductResponse ?? this.detailsProductResponse,
      loadingDetails: loadingDetails ?? this.loadingDetails,
      loadingAddCart: loadingAddCart ?? this.loadingAddCart,
      loadingAddCartGoCart: loadingAddCartGoCart ?? this.loadingAddCartGoCart,
    );
  }
}
