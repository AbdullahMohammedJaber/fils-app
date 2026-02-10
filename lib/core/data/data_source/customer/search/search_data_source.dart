import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class SearchDataSource {
  Future<ApiResult<Map<String, dynamic>>> getSearch({
    int page,
    required Map<String, dynamic> data,
  });
}

class SearchDataSourceImpl extends SearchDataSource {
  DioClient dioClient;

  SearchDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getSearch({
    int page = 1,
    required Map<String, dynamic> data,
  }) async {
    return await dioClient.request(
      path: '${ApiService.search}?page=$page',
      method: 'GET',
      data: data,
    );
  }
}
