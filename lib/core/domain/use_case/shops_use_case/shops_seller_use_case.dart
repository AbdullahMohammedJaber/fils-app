import 'dart:io';
import 'package:fils/core/data/response/package/package_response.dart';
import 'package:fils/core/data/response/shops/shop_info_seller_response.dart';
import 'package:fils/core/data/response/shops/shops_response.dart';
import 'package:fils/core/domain/reposetry/shops/package.dart';
import 'package:fils/core/domain/reposetry/shops/shops_seller.dart';
import 'package:fils/core/server/result.dart';

class ShopsSellerUseCase {
  ShopsSellerRepoImpl shopsSellerRepoImpl;
  PackageSellerRepoImpl packageSellerRepoImpl;
  ShopsSellerUseCase(this.shopsSellerRepoImpl , this.packageSellerRepoImpl);

  Future<ApiResult< ShopsResponse>> callGetAllShops() async {
    return await shopsSellerRepoImpl.getShopsSeller();
  }

  Future<ApiResult< Map<String , dynamic>>> callCreateShopsSeller({
    required Map<String, dynamic> data,
    File? file,
  }) async {
    return await shopsSellerRepoImpl.createShopsSeller(
      data: data,
      file: file,
    );
  }

  Future<ApiResult<PackageInfoResponse>> getPackageInfo()async{
    return await packageSellerRepoImpl.getPackageInfo();

  }

   Future<ApiResult<ShopInfoResponse>> getShopInfo()async{
    return await shopsSellerRepoImpl.getShopsSellerInfo();

  }
}
