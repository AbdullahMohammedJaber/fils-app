import 'dart:io';

import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';
import 'package:fils/utils/storage.dart';

abstract class ShopsSellerDataSource {
  Future<ApiResult<Map<String, dynamic>>> getShopsSeller();
  Future<ApiResult<Map<String, dynamic>>> createShopsSeller({
    required Map<String, dynamic> data,
    File? file,
  });
  Future<ApiResult<Map<String, dynamic>>> getShopInfo();
}

class ShopsSellerDataSourceImpl implements ShopsSellerDataSource {
  DioClient dioClient;
  ShopsSellerDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getShopsSeller() async {
    return await dioClient.request(
      method: 'GET',
      path: ApiServiceSeller.myShops,
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createShopsSeller({
    required Map<String, dynamic> data,
    File? file,
  }) async {
    return await dioClient.request(
      method: 'POST',
      path: ApiServiceSeller.createShop,
      fileFieldName: "tax_papers",
      isMultipart: file != null ? true : false,
      data: data,
      file:file,
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getShopInfo() async {
    return await dioClient.request(
      path: "shop/info/${getMyShopsDetails().id}",
      method: 'GET',
    );
  }
}
