import 'package:fils/core/data/data_source/customer/haraj/haraj_data_source.dart';
import 'package:fils/core/data/response/haraj/haraj_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

import '../../../data/response/haraj/details_haraj.dart';

abstract class HarajRepo {
  Future<ApiResult<AllProductMarketOpenResponse>> getAllHaraj({
    required int page,
  });

  Future<ApiResult<AllProductMarketOpenResponse>> getHarajInCategory({
    required int page,
    required int idCategory,
  });

  Future<ApiResult<DetailsOpenMarketResponse>> getDetailsHaraj({
    required String slug,
  });

  Future<ApiResult<Map<String, dynamic>>> addHaraj({
    required Map<String, dynamic> harajData,
  });
}

class HarajRepoImpl extends HarajRepo {
  HarajDataSourceImpl harajDataSourceImpl;

  HarajRepoImpl(this.harajDataSourceImpl);

  @override
  Future<ApiResult<AllProductMarketOpenResponse>> getAllHaraj({
    required int page,
  }) async {
    final result = await harajDataSourceImpl.getAllHaraj(page: page);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      AllProductMarketOpenResponse allProductMarketOpenResponse =
          AllProductMarketOpenResponse.fromJson(result.data!);
      return ApiResult.success(allProductMarketOpenResponse);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }

  @override
  Future<ApiResult<DetailsOpenMarketResponse>> getDetailsHaraj({
    required String slug,
  }) async {
    final result = await harajDataSourceImpl.getDetailsHaraj(slug: slug);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      DetailsOpenMarketResponse detailsOpenMarketResponse =
          DetailsOpenMarketResponse.fromJson(result.data!);
      return ApiResult.success(detailsOpenMarketResponse);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addHaraj({
    required Map<String, dynamic> harajData,
  }) async {
    final result = await harajDataSourceImpl.addHaraj(harajData: harajData);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }

  @override
  Future<ApiResult<AllProductMarketOpenResponse>> getHarajInCategory({
    required int page,
    required int idCategory,
  }) async {
    final result = await harajDataSourceImpl.getHarajInCategory(
      page: page,
      idCategory: idCategory,
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      AllProductMarketOpenResponse allProductMarketOpenResponse =
          AllProductMarketOpenResponse.fromJson(result.data!);
      return ApiResult.success(allProductMarketOpenResponse);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
}
