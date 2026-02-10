import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class ProfileDataSource {
  Future<ApiResult<Map<String, dynamic>>> supportTicket({
    required String message,
  });

  Future<ApiResult<Map<String, dynamic>>> profileUpdate({
    required Map<String, dynamic> data,
  });
}

class ProfileDataSourceImpl extends ProfileDataSource {
  DioClient dioClient;
  ProfileDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> supportTicket({
    required String message,
  }) async {
    return await dioClient.request(
      method: 'POST',
      path: ApiService.supportTicket,
      data: {'message': message},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> profileUpdate({
    required Map<String, dynamic> data,
  }) async {
    return await dioClient.request(
      method: 'POST',
      path: ApiService.profileUpdate,
      data: data,
    );
  }
}
