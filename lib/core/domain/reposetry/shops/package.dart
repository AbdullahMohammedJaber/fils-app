


import 'package:fils/core/data/data_source/seller/shops_seller/package_seller.dart';
import 'package:fils/core/data/response/package/package_response.dart';
import 'package:fils/core/server/result.dart';
 import 'package:fils/utils/string.dart';

abstract class PackageSellerRepo {
  Future<ApiResult<PackageInfoResponse>> getPackageInfo();
}

class PackageSellerRepoImpl extends PackageSellerRepo{
  PackageSellerDataSourceImpl packageSellerDataSourceImpl;
  PackageSellerRepoImpl(this.packageSellerDataSourceImpl);
  @override
  Future<ApiResult<PackageInfoResponse>> getPackageInfo() async{
     final result = await packageSellerDataSourceImpl.getPackageInfo();
     if(result.isFailed){
      return ApiResult.failed(message: result.message);
     }
     else if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
     }else{
      return ApiResult.success(PackageInfoResponse.fromJson(result.data!));
     }
  }

}