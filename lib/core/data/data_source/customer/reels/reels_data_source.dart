


import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class ReelsDataSource {
  Future<ApiResult<Map<String, dynamic>>> fetchReels({required int page});
}

class ReelsDataSourceImpl implements ReelsDataSource {
  DioClient dioClient;
  ReelsDataSourceImpl( this.dioClient );
  @override
  Future<ApiResult<Map<String, dynamic>>> fetchReels({required int page})async {
    
   return await dioClient.request(
      path: ApiService.reel,
      method: 'GET',
      queryParameters: {'page': page}
    );
   }}