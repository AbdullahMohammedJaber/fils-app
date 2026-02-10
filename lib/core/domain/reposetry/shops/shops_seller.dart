import 'dart:io';

import 'package:fils/core/data/data_source/seller/shops_seller/shops_seller.dart';
import 'package:fils/core/data/response/shops/shop_info_seller_response.dart';
import 'package:fils/core/data/response/shops/shops_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class ShopsSellerRepo {
  Future<ApiResult<ShopsResponse>> getShopsSeller();
  Future<ApiResult<ShopInfoResponse>> getShopsSellerInfo();

  Future<ApiResult<Map<String, dynamic>>> createShopsSeller({
    required Map<String, dynamic> data,
    File? file,
  });
}

class ShopsSellerRepoImpl implements ShopsSellerRepo {
  ShopsSellerDataSourceImpl dataSourceImpl;
  ShopsSellerRepoImpl(this.dataSourceImpl);
  @override
  Future<ApiResult<ShopsResponse>> getShopsSeller() async {
    final result = await dataSourceImpl.getShopsSeller();
    if (result.isSuccess) {
      final data = ShopsResponse.fromJson(result.data!);
      return ApiResult.success(data);
    }
    if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createShopsSeller({
    required Map<String, dynamic> data,
    File? file,
  }) async {
    final result = await dataSourceImpl.createShopsSeller(
      data: data,
      file: file,
    );
    if (result.isSuccess) {
      
      return ApiResult.success(result.data! );
    }
    if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
  
  @override
  Future<ApiResult<ShopInfoResponse>> getShopsSellerInfo() async{
    final result = await dataSourceImpl.getShopInfo(
       
    );
    if (result.isSuccess) {
      
      return ApiResult.success(ShopInfoResponse.fromJson(result.data!));
    }
    if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
}
