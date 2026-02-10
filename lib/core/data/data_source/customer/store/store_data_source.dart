import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class StoreDataSource {
  Future<ApiResult<Map<String, dynamic>>> getAllStore({int page = 1});

  Future<ApiResult<Map<String, dynamic>>> getTabBar({required int id});

  Future<ApiResult<Map<String, dynamic>>> getProductInStore({
    required int idStore,
    required int categoryId,
    required int page,
  });

  Future<ApiResult<Map<String, dynamic>>> getProductInStoreCategory({
    required int categoryId,

  });
}

class StoreDataSourceImpl extends StoreDataSource {
  DioClient dioClient;

  StoreDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getAllStore({int page = 1}) async {
    return dioClient.request(
      path: '${ApiService.shops}?page=$page',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getTabBar({required int id}) async {
    return await dioClient.request(
      path: '${ApiService.productSellerCategories}/$id',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getProductInStore({
    required int idStore,
    required int categoryId,
    int page = 1,
  }) async {
    return await dioClient.request(
      path:
          '${ApiService.productShops}/$idStore?category_id=$categoryId&page=$page',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getProductInStoreCategory({
    required int categoryId,

  }) async {
    return await dioClient.request(
      path: '${ApiService.storeInCategory}/$categoryId',
      method: 'GET',
    );
  }
}
