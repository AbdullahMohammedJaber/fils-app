import 'package:fils/core/data/request/auth/confirm_code.dart';
import 'package:fils/core/data/request/auth/login.dart';
import 'package:fils/core/data/request/auth/signup.dart';
import 'package:fils/core/data/request/auth/social_auth.dart';
import 'package:fils/core/data/response/auth/swith_account_response.dart';
import 'package:fils/core/data/response/auth/user_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

import '../../../data/data_source/auth/auth_data_source.dart';

abstract class AuthRepo {
  Future<ApiResult<UserResponse>> login({required LoginRequest loginRequest});

  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequest signupRequest,
  });

  Future<ApiResult<UserResponse>> confirmCode({
    required ConfirmCodeRequest confirmCodeRequest,
    required SignupRequest sign,
  });

  Future<ApiResult<Map<String, dynamic>>> deleteAccount();
  Future<ApiResult<Map<String, dynamic>>> logoutAccount();
  Future<ApiResult<SwitchAccountResponse>> switchAccount({
    required String userType,
  });
  Future<ApiResult<Map<String, dynamic>>> forgetPassword(String phone);
  Future<ApiResult<Map<String, dynamic>>> verifyResetPassword(String code);
  Future<ApiResult<Map<String, dynamic>>> createNewPassword({
    required String code,
    required String password,
  });
  Future<ApiResult<Map<String, dynamic>>> reSendCode({required String phone});
  Future<ApiResult<Map<String, dynamic>>> socialLogin({required SocialAuth socialAuth});
}

class AuthRepoImpl extends AuthRepo {
  final AuthDataSource authDataSource;

  AuthRepoImpl(this.authDataSource);

  @override
  Future<ApiResult<UserResponse>> login({
    required LoginRequest loginRequest,
  }) async {
    final result = await authDataSource.login(loginRequest: loginRequest);

    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      final user = UserResponse.fromJson(result.data!);
      return ApiResult.success(
        user,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> signup({
    required SignupRequest signupRequest,
  }) async {
    final result = await authDataSource.signup(signupRequest: signupRequest);
    if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message.toString());
    }
  }

  @override
  Future<ApiResult<UserResponse>> confirmCode({
    required ConfirmCodeRequest confirmCodeRequest,
    required SignupRequest sign,
  }) async {
    final result = await authDataSource.confirmCode(
      confirmCodeRequest: confirmCodeRequest,
      signUp: sign,
    );

    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      final user = UserResponse.fromJson(result.data!);
      return ApiResult.success(
        user,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: StringApp.error,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> deleteAccount() async {
    final result = await authDataSource.deleteAccount();
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> logoutAccount() async {
    final result = await authDataSource.logoutAccount();
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<SwitchAccountResponse>> switchAccount({
    required String userType,
  }) async {
    final result = await authDataSource.switchAccount(userType: userType);
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      final switchAccountResponse = SwitchAccountResponse.fromJson(
        result.data!,
      );
      return ApiResult.success(
        switchAccountResponse,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> forgetPassword(String phone) async {
    final result = await authDataSource.forgetPassword(phone);
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> verifyResetPassword(
    String code,
  ) async {
    final result = await authDataSource.verifyResetPassword(code);
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createNewPassword({
    required String code,
    required String password,
  }) async {
    final result = await authDataSource.createNewPassword(
      code: code,
      password: password,
    );
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> reSendCode({
    required String phone,
  }) async {
    final result = await authDataSource.reSendCode(phone: phone);
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> socialLogin({required SocialAuth socialAuth}) async{
    final result = await authDataSource.socialLogin(socialAuth: socialAuth);
    if (result.isNoInternet) {
      return ApiResult.failed(
        message: StringApp.noInternet,
        statusCode: result.statusCode,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        statusCode: result.statusCode,
        message: result.message,
      );
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }
}
