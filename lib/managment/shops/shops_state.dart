part of 'shops_cubit.dart';

class ShopsState {
  final ShopsResponse? shopsResponse;
  final bool isLoading;
  final bool hasMore;

  final File? shopImage;
  final File? shopLinciseImage;

  final String? shopImageId;

  ShopsState({
    this.shopsResponse,
    this.isLoading = false,
    this.hasMore = true,
    this.shopImage,
    this.shopImageId,
    this.shopLinciseImage,
  });

  ShopsState copyWith({
    ShopsResponse? shopsResponse,
    bool? isLoading,
    bool? hasMore,
    File? shopImage,
    String? shopImageId,
    File? shopLinciseImage,
  }) {
    return ShopsState(
      shopsResponse: shopsResponse ?? this.shopsResponse,
      isLoading: isLoading ?? this.isLoading,
      hasMore: hasMore ?? this.hasMore,
      shopImage: shopImage ?? this.shopImage,
      shopImageId: shopImageId ?? this.shopImageId,
      shopLinciseImage: shopLinciseImage ?? this.shopLinciseImage,
    );
  }

  factory ShopsState.clearAttachment() {
    return ShopsState(
      shopImage: null,
      shopImageId: null,
      shopLinciseImage: null,
    );
  }
}
