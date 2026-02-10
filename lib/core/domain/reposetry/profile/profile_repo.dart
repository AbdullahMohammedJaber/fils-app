import 'package:fils/core/data/data_source/profile/profile_data_source.dart';
import 'package:fils/core/data/response/auth/user_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class ProfileRepo {
  Future<ApiResult<Map<String, dynamic>>> supportTicket({
    required String message,
  });
  Future<ApiResult<UserResponse>> profileUpdate({
    required Map<String, dynamic> data,
  });
}

class ProfileRepoImpl extends ProfileRepo {
  final ProfileDataSourceImpl profileDataSource;

  ProfileRepoImpl( this.profileDataSource);

  @override
  Future<ApiResult<Map<String, dynamic>>> supportTicket({
    required String message,
  }) async {
    final result = await profileDataSource.supportTicket(message: message);
    if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    }
              
    else {
      return ApiResult.failed(message: result.message);
    }
  }
  
  @override
  Future<ApiResult<UserResponse>> profileUpdate({required Map<String, dynamic> data}) async {
    final result = await profileDataSource.profileUpdate(data: data);
    if (result.isSuccess) {
      return ApiResult.success(UserResponse.fromJson(result.data!));
    } else if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
}
