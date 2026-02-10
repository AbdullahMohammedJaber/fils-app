import 'package:dio/dio.dart';
import 'package:fils/core/data/data_source/customer/home/home_data_source.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/core/data/response/product/all_products_response.dart';

import 'package:fils/core/server/result.dart';

import '../../../../../utils/string.dart';
import '../../../../data/response/home/suggest_product_response.dart';

abstract class HomeRepo {
  Future<ApiResult<HomeResponse>> homeCustomer();

  Future<ApiResult<AllProductsResponse>> getAllProducts({int page});

  Future<ApiResult<SuggestProductResponse>> suggestProduct({
    required int page,
    required CancelToken cancelToken,
  });
}

class HomeRepoImpl extends HomeRepo {
  HomeDataSource homeDataSource;

  HomeRepoImpl(this.homeDataSource);

  @override
  Future<ApiResult<HomeResponse>> homeCustomer() async {
    final result = await homeDataSource.homeCustomer();
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      final home = HomeResponse.fromJson(result.data!);
      return ApiResult.success(
        home,
        message: result.message,
        statusCode: result.statusCode,
      );
    }

    return ApiResult.failed(
      statusCode: result.statusCode,
      message: result.message,
    );
  }

  @override
  Future<ApiResult<SuggestProductResponse>> suggestProduct({
    required int page,
    required CancelToken cancelToken,
  }) async {
    try {
      final result = await homeDataSource.suggestProduct(
        page: page,
        cancelToken: cancelToken,
      );

      if (result.isNoInternet) {
        return ApiResult.failed(
          statusCode: result.statusCode,
          message: StringApp.noInternet,
        );
      } else if (result.isSuccess) {
        final suggest = SuggestProductResponse.fromMap(result.data!);
        return ApiResult.success(
          suggest,
          statusCode: result.statusCode,
          message: result.message,
        );
      } else {
        return ApiResult.failed(
          statusCode: result.statusCode,
          message: result.message,
        );
      }
    } catch (e) {
      print("suggest repo ${e.toString()}");
      return ApiResult.failed(statusCode: 501, message: e.toString());
    }
  }

  @override
  Future<ApiResult<AllProductsResponse>> getAllProducts({int page = 1}) async {
    final result = await homeDataSource.getAllProduct(page: page);
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      final allProduct = AllProductsResponse.fromJson(result.data!);
      return ApiResult.success(
        allProduct,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: result.message,
      );
    }
  }
}
