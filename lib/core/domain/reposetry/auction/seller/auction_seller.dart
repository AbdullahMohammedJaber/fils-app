



import 'package:fils/core/data/data_source/seller/auction/auction_seller.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class  AuctionSellerRepo {
  Future<ApiResult<AllAuctionSellerResponse>> getAllAuctionSeller({
    required int page,
  });
    Future<ApiResult<Map<String, dynamic>>> addAuctionSeller({
    required Map<String, dynamic> data,
  });
}


class AuctionSellerRepoImpl extends AuctionSellerRepo{
  AuctionSellerDataSourceImpl auctionSellerDataSourceImpl;
  AuctionSellerRepoImpl(this.auctionSellerDataSourceImpl);
  @override
  Future<ApiResult<AllAuctionSellerResponse>> getAllAuctionSeller({required int page}) async{
     final result = await auctionSellerDataSourceImpl.getAllAuctionSeller(page: page);
     if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
     }
     else if(result.isFailed){
            return ApiResult.failed(message: result.message);

     }
     else{
      return ApiResult.success(AllAuctionSellerResponse.fromJson(result.data!));

     }
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> addAuctionSeller({required Map<String, dynamic> data})async {
      final result = await auctionSellerDataSourceImpl.addAuctionSeller(data: data);
     if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
     }
     else if(result.isFailed){
            return ApiResult.failed(message: result.message);

     }
     else{
      return ApiResult.success( result.data! );

     }
  }

}