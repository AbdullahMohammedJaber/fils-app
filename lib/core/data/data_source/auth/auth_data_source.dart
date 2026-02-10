import 'package:fils/core/data/request/auth/social_auth.dart';

import '../../../server/dio_helper.dart';
import '../../../server/result.dart';
import '../../../server/servise.dart';
import '../../request/auth/confirm_code.dart';
import '../../request/auth/login.dart';
import '../../request/auth/signup.dart';

abstract class AuthDataSource {
  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequest loginRequest,
  });

  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequest signupRequest,
  });

  Future<ApiResult<Map<String, dynamic>>> confirmCode({
    required ConfirmCodeRequest confirmCodeRequest,
    required SignupRequest signUp,
  });

  Future<ApiResult<Map<String, dynamic>>> deleteAccount();
  Future<ApiResult<Map<String, dynamic>>> logoutAccount();
  Future<ApiResult<Map<String, dynamic>>> switchAccount({
    required String userType,
  });
  Future<ApiResult<Map<String, dynamic>>> forgetPassword(String phone);
  Future<ApiResult<Map<String, dynamic>>> verifyResetPassword(String code);
  Future<ApiResult<Map<String, dynamic>>> createNewPassword({
    required String code,
    required String password,
  });
  Future<ApiResult<Map<String, dynamic>>> reSendCode({required String phone});
  Future<ApiResult<Map<String, dynamic>>> socialLogin({
    required SocialAuth socialAuth,
  });
}

class AuthDataSourceImpl implements AuthDataSource {
  final DioClient dio;

  AuthDataSourceImpl(this.dio);

  @override
  Future<ApiResult<Map<String, dynamic>>> login({
    required LoginRequest loginRequest,
  }) {
    return dio.request<Map<String, dynamic>>(
      path: ApiService.login,
      method: 'POST',

      data: {
        'phone': loginRequest.mobile,
        'password': loginRequest.password,
        'user_type': loginRequest.userType.name,
      },
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequest signupRequest,
  }) async {
    return await dio.request(
      path: ApiService.register,
      method: 'POST',
      data: {
        "email": signupRequest.email,
        "phone": signupRequest.mobile,
        "user_type": signupRequest.userType.name,
      },
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> confirmCode({
    required ConfirmCodeRequest confirmCodeRequest,
    required SignupRequest signUp,
  }) {
    return dio.request(
      path: ApiService.confirmCode,
      method: 'POST',
      data: {
        "verification_code": confirmCodeRequest.code.toString(),
        "email": signUp.email,
        "password": signUp.password,
        "password_confirmation": signUp.confirmPassword,
        "phone": signUp.mobile,
        "name": signUp.name,
        "user_type": signUp.userType.name,
      },
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> deleteAccount() async {
    return await dio.request(path: ApiService.deleteAccount, method: 'DELETE');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> logoutAccount() async {
    return await dio.request(path: ApiService.logout, method: 'POST');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> switchAccount({
    required String userType,
  }) {
    return dio.request(
      path: ApiService.profileSwitchAccount,
      method: 'POST',
      data: {"user_type": userType},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> forgetPassword(String phone) async {
    return dio.request(
      path: ApiService.forgetPassword,
      method: 'POST',
      data: {"email_or_phone": phone, "send_code_by": "phone"},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyResetPassword(String code) {
    return dio.request(
      path: ApiService.verifyResetPassword,
      method: 'POST',
      data: {"verification_code": code},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createNewPassword({
    required String code,
    required String password,
  }) {
    return dio.request(
      path: ApiService.createNewPassword,
      method: 'POST',
      data: {"verification_code": code, "password": password},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> reSendCode({
    required String phone,
  }) async {
    return dio.request(
      path: ApiService.resendCode,
      method: 'POST',
      data: {"email_or_phone": phone, "send_code_by": "phone"},
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> socialLogin({required SocialAuth socialAuth}) async{
    return dio.request(
      path: ApiService.socialLogin,
      method: 'POST',
      data: socialAuth.toJson(),
    );
  }
}
