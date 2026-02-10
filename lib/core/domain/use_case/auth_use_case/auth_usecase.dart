import 'package:fils/core/data/request/auth/social_auth.dart';
import 'package:fils/core/data/response/auth/swith_account_response.dart';
import 'package:fils/core/data/response/auth/user_response.dart';
import 'package:fils/core/domain/reposetry/auth_repo/auth_repo.dart';
import 'package:fils/core/server/result.dart';

import '../../../data/request/auth/confirm_code.dart';
import '../../../data/request/auth/login.dart';
import '../../../data/request/auth/signup.dart';

class AuthUseCase {
  AuthRepoImpl authRepo;

  AuthUseCase(this.authRepo);

  Future<ApiResult<UserResponse>> callLogin({
    required LoginRequest loginRequest,
  }) async {
    return await authRepo.login(loginRequest: loginRequest);
  }

  Future<ApiResult<Map<String, dynamic>>> callSignup({
    required SignupRequest signupRequest,
  }) async {
    return await authRepo.signup(signupRequest: signupRequest);
  }

  Future<ApiResult<UserResponse>> callConfirmCode({
    required ConfirmCodeRequest confirmCodeRequirest,
    required SignupRequest signupRequest,
  }) async {
   return await authRepo.confirmCode(
      confirmCodeRequest: confirmCodeRequirest,
      sign: signupRequest,
    );
  }

  Future<ApiResult<Map<String, dynamic>>> deleteAccount() async {
    return await authRepo.deleteAccount();
  }
   Future<ApiResult<Map<String, dynamic>>> logoutAccount() async {
    return await authRepo.logoutAccount();
  }
    Future<ApiResult<SwitchAccountResponse>> switchAccount({
      required String userType,
    }) async {
      return await authRepo.switchAccount(userType: userType);
    } 

     Future<ApiResult<Map<String, dynamic>>> forgetPassword(String phone) async {
    return await authRepo.forgetPassword(phone);
  }
      Future<ApiResult<Map<String, dynamic>>> verifyResetPassword(String code) async {
      return await authRepo.verifyResetPassword(code);
    } 

    Future<ApiResult<Map<String, dynamic>>> createNewPassword({required String code , required String password}) async {
      return await authRepo.createNewPassword(code: code , password: password);
    }
     Future<ApiResult<Map<String, dynamic>>> reSendCode({required String phone}) async {
      return await authRepo.reSendCode(phone: phone);
    }
      Future<ApiResult<Map<String, dynamic>>> socialLogin({required SocialAuth socialAuth}) async {
        return await authRepo.socialLogin(socialAuth: socialAuth);
      }
}
