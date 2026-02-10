import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class HarajDataSource {
  Future<ApiResult<Map<String, dynamic>>> getAllHaraj({required int page});

  Future<ApiResult<Map<String, dynamic>>> getHarajInCategory({
    required int page,
    required int idCategory,
  });

  Future<ApiResult<Map<String, dynamic>>> getDetailsHaraj({
    required String slug,
  });

  Future<ApiResult<Map<String, dynamic>>> addHaraj({
    required Map<String, dynamic> harajData,
  });
}

class HarajDataSourceImpl extends HarajDataSource {
  DioClient dioClient;

  HarajDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getAllHaraj({
    required int page,
  }) async {
    return await dioClient.request(
      path: '${ApiService.haraj}?page=$page',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getDetailsHaraj({
    required String slug,
  }) async {
    return await dioClient.request(
      path: '${ApiService.detailsHaraj}/$slug',
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addHaraj({
    required Map<String, dynamic> harajData,
  }) async {
    return await dioClient.request(
      method: 'POST',
      path: ApiService.addHaraj,
      data: harajData,
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getHarajInCategory({
    required int page,
    required int idCategory,
  }) async {
    return await dioClient.request(
      method: 'GET',
      path: ApiService.haraj,
      data: {"category_id": idCategory , "page" : page},
    );
  }
}
