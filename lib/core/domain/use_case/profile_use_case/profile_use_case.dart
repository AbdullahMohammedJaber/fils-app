


import 'package:fils/core/data/response/auth/user_response.dart';
import 'package:fils/core/domain/reposetry/profile/profile_repo.dart';
import 'package:fils/core/server/result.dart';

class ProfileUseCase {
  final ProfileRepoImpl profileRepoImpl;
  ProfileUseCase( this.profileRepoImpl );

  Future<ApiResult<Map<String, dynamic>>> supportTicket({
    required String message,
  }) async {
    return await profileRepoImpl.supportTicket(message: message);
  }

  Future<ApiResult<UserResponse>> profileUpdate({
    required Map<String, dynamic> data,
  }) async {
    return await profileRepoImpl.profileUpdate(data: data);
  } 
}