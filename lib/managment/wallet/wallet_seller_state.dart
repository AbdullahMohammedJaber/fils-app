part of 'wallet_seller_cubit.dart';

class WalletSellerState {
  final double totalWallet;
  final WalletSellerResponse? walletSellerResponse;
  final bool loading;
  final String? error;
  /////////// Widthrow
  
  bool stepOne;
  bool stepTow;
  WalletSellerState({
    this.totalWallet = 0.0,
    this.walletSellerResponse,
    this.loading = true,
    this.error,
    this.stepOne = true,
    this.stepTow = false,
  
  }) ;

  WalletSellerState copyWith({
    double? totalWallet,
    WalletSellerResponse? walletSellerResponse,
    bool? loading,
    String? error,
    bool? stepOne,
    bool? stepTow,
    TextEditingController? priceController,
  }) {
    return WalletSellerState(
      error: error,
      loading: loading ?? this.loading,
      totalWallet: totalWallet ?? this.totalWallet,
      walletSellerResponse: walletSellerResponse ?? this.walletSellerResponse,
      stepOne: stepOne ?? this.stepOne,
      stepTow: stepTow ?? this.stepTow,
   
    );
  }
}
