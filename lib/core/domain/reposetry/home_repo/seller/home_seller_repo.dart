


import 'package:fils/core/data/data_source/seller/home_seller/home_seller.dart';
import 'package:fils/core/data/response/home/home_seller_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class HomeSellerRepo {
  Future<ApiResult<HomeSellerResponse>> getHomeSeller();
}

class HomeSellerRepoImpl extends HomeSellerRepo {
  final HomeSellerDataSource homeSellerDataSource;
   
  HomeSellerRepoImpl(this.homeSellerDataSource);

  @override
  Future<ApiResult<HomeSellerResponse>> getHomeSeller() async {
    final result = await homeSellerDataSource.getHomeSeller();
    if(result.isSuccess){
      return ApiResult.success(HomeSellerResponse.fromJson(result.data!));
    } 
    else if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
    }
    else {
      return ApiResult.failed(message: result.message ?? StringApp.noInternet);
    }
  }
} 