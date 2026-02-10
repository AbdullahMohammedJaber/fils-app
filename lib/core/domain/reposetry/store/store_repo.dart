import 'package:fils/core/data/data_source/customer/store/store_data_source.dart';
import 'package:fils/core/data/response/store/store_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

import '../../../data/response/store/store_in_category.dart';

abstract class StoreRepo {
  Future<ApiResult<StoreResponse>> getAllStore({int page = 1});

  Future<ApiResult<Map<String, dynamic>>> getTabBar({required int id});

  Future<ApiResult<Map<String, dynamic>>> getProductInStore({
    required int idStore,
    required int categoryId,
    required int page,
  });

  Future<ApiResult<StoreInCategoryResponse>> getProductInStoreCategory({
    required int categoryId,
  });
}

class StoreRepoImpl extends StoreRepo {
  StoreDataSourceImpl storeDataSourceImpl;

  StoreRepoImpl(this.storeDataSourceImpl);

  @override
  Future<ApiResult<StoreResponse>> getAllStore({int page = 1}) async {
    final result = await storeDataSourceImpl.getAllStore(page: page);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      StoreResponse storeResponse = StoreResponse.fromJson(result.data!);
      return ApiResult.success(storeResponse);
    } else {
      return ApiResult.failed(message: result.data!['message']);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getTabBar({required int id}) async {
    final result = await storeDataSourceImpl.getTabBar(id: id);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getProductInStore({
    required int idStore,
    required int categoryId,
    required int page,
  }) async {
    final result = await storeDataSourceImpl.getProductInStore(
      categoryId: categoryId,
      idStore: idStore,
      page: page,
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else {
      return ApiResult.failed(message: result.data!['message']);
    }
  }

  @override
  Future<ApiResult<StoreInCategoryResponse>> getProductInStoreCategory({
    required int categoryId,
  }) async {
    final result = await storeDataSourceImpl.getProductInStoreCategory(
      categoryId: categoryId,
    );
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(StoreInCategoryResponse.fromJson(result.data!));
    } else {
      return ApiResult.failed(message: result.data!['message']);
    }
  }
}
