// ignore_for_file: must_be_immutable

part of 'auction_cubit.dart';

@immutable
class AuctionState {
  // Get All Auction
  final bool loading;
  final String? error;
  final bool hasMore;
  final List<AuctionResponse>? auctionList;
  // Get Auction By Category
  final bool loadingAuctionCategory;
  final String? errorAuctionCategory;
  final bool hasMoreAuctionCategory;
  final List<AuctionResponse>? auctionListAuctionCategory;
  // Get Details Auction
  final bool loadingDetails;
  final String? errorDetails;
  final DetailsAuctionResponse? detailsAuctionResponse;
  // Get Bids Auction
  final List<BidResponse> bids;
  final bool isLoading;
  final String? errorMessage;
  final double totalPriceBid;
  // Get Gift Auction
  final List<Map<dynamic, dynamic>> gifts;
  final bool loadingGift;
  final String? errorMessageGift;
  final List<String> giftsId;
  final bool showGiftBox;
  final String messageNewGift;
  final String amountNewGift;
  // Control Form Add Auction
  final String? nameCategory;
  final int? idCategory;
  final List<int>? categoresId;
  String? nameCategores;
  final File ?imageProduct;
 final int ? idImage;
 final bool loadingForm ;

  AuctionState({
    this.loading = false,
    this.loadingDetails = false,
    this.loadingForm = false,
    this.imageProduct,
    this.idImage,
    this.errorDetails,
    this.categoresId,
    this.nameCategory,
    this.idCategory,
    this.nameCategores,
    this.detailsAuctionResponse,
    this.error,
    this.hasMore = true,
    this.auctionList,
    this.loadingAuctionCategory = false,
    this.errorAuctionCategory,
    this.hasMoreAuctionCategory = true,
    this.auctionListAuctionCategory,
    this.bids = const [],
    this.isLoading = true,
    this.errorMessage,
    this.totalPriceBid = 0.0,
    this.gifts = const [],
    this.loadingGift = true,
    this.errorMessageGift,
    this.giftsId = const [],
    this.showGiftBox = false,
    this.messageNewGift = "",
    this.amountNewGift = "",
  });

  AuctionState copyWith({
    bool? loading,
    String? error,
    bool? hasMore,
    File? imageProduct,
    List<AuctionResponse>? auctionList,
    bool? loadingAuctionCategory,
    String? errorAuctionCategory,
    bool? hasMoreAuctionCategory,
    List<AuctionResponse>? auctionListAuctionCategory,
    bool? loadingDetails,
    String? errorDetails,
    DetailsAuctionResponse? detailsAuctionResponse,
    List<BidResponse>? bids,
    bool? isLoading,
    String? errorMessage,
    double? totalPriceBid,
    List<Map<dynamic, dynamic>>? gifts,
    bool? loadingGift,
    String? errorMessageGift,
    List<String>? giftsId,
    bool? showGiftBox,
    String? messageNewGift,
    String? amountNewGift,
    String? nameCategory,
    int? idCategory,
    List<int>? categoresId,
    String? nameCategores,
    int ? idImage,
    bool ? loadingForm,
  }) {
    return AuctionState(
      error: error,
      loading: loading ?? this.loading,
      hasMore: hasMore ?? this.hasMore,
      auctionList: auctionList ?? this.auctionList,
      errorAuctionCategory: errorAuctionCategory,
      loadingAuctionCategory:
          loadingAuctionCategory ?? this.loadingAuctionCategory,
      hasMoreAuctionCategory:
          hasMoreAuctionCategory ?? this.hasMoreAuctionCategory,
      auctionListAuctionCategory: auctionListAuctionCategory,
      detailsAuctionResponse:
          detailsAuctionResponse ?? this.detailsAuctionResponse,
      errorDetails: errorDetails,
      loadingDetails: loadingDetails ?? this.loadingDetails,
      bids: bids ?? this.bids,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      totalPriceBid: totalPriceBid ?? this.totalPriceBid,
      gifts: gifts ?? this.gifts,
      loadingGift: loadingGift ?? this.loadingGift,
      errorMessageGift: errorMessageGift ?? this.errorMessageGift,
      giftsId: giftsId ?? this.giftsId,
      showGiftBox: showGiftBox ?? this.showGiftBox,
      messageNewGift: messageNewGift ?? this.messageNewGift,
      amountNewGift: amountNewGift ?? this.amountNewGift,
      idCategory: idCategory ?? this.idCategory,
      nameCategory: nameCategory ?? this.nameCategory,
      categoresId: categoresId ?? this.categoresId,
      nameCategores: nameCategores ?? this.nameCategores,
      imageProduct: imageProduct ?? this.imageProduct,
      idImage: idImage??this.idImage,
      loadingForm: loadingForm??this.loadingForm,
    );
  }

  factory AuctionState.clearList() {
    return AuctionState(auctionList: null);
  }
  factory AuctionState.clearForm() {
    return AuctionState(
      idCategory: null,
      nameCategory: null,
      categoresId: null,
      nameCategores: null,
      imageProduct: null,
      idImage: null,
      loadingForm : false,
    );
  }
  factory AuctionState.clearAttachment() {
    return AuctionState(
       idImage: null,
      imageProduct: null,
    );
  }
}
