import 'package:dio/dio.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

import '../../../../server/dio_helper.dart';

abstract class HomeDataSource {
  Future<ApiResult<Map<String, dynamic>>> homeCustomer();

  Future<ApiResult<Map<String, dynamic>>> getAllProduct({int page});

  Future<ApiResult<Map<String, dynamic>>> suggestProduct({
    required int page,
    required CancelToken cancelToken,
  });
}

class HomeDataSourceImp extends HomeDataSource {
  final DioClient dioClient;

  HomeDataSourceImp(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> homeCustomer() async {
    return dioClient.request<Map<String, dynamic>>(
      path: ApiService.home,
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> suggestProduct({
    required int page,
    required CancelToken cancelToken,
  }) async {
    
      return await dioClient.request(
        path: ApiService.suggestProduct,
        method: 'GET',
        cancelToken: cancelToken,
        queryParameters: {'page': page},
      );
    
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getAllProduct({int page = 1}) async {
    return dioClient.request(
      path: '${ApiService.products}?is_auction=0&page=$page',
      method: 'GET',
    );
  }
}
