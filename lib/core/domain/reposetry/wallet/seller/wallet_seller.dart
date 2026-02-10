


 import 'package:fils/core/data/data_source/seller/wallet/wallet_seller.dart';
import 'package:fils/core/data/response/wallet/wallet_seller.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class WalletSellerRepo {
  Future<ApiResult<WalletSellerResponse>> getWallet();

}

class WalletSellerRepoImpl extends WalletSellerRepo{
  WalletSellerDataSourceImpl walletSellerDataSourceImpl;
  WalletSellerRepoImpl(this.walletSellerDataSourceImpl);
  @override
  Future<ApiResult<WalletSellerResponse>> getWallet() async{
    final result = await walletSellerDataSourceImpl.getWallet();
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }else if (result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
    }
    else{
      return ApiResult.success(WalletSellerResponse.fromJson(result.data!));
    }
  }

}