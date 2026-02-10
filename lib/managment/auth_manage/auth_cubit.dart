import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/request/auth/confirm_code.dart';
import 'package:fils/core/data/request/auth/signup.dart';
import 'package:fils/core/data/request/auth/social_auth.dart';
import 'package:fils/core/data/response/auth/swith_account_response.dart';
import 'package:fils/core/data/response/auth/user_response.dart';
import 'package:fils/core/server/google_apple_login.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
 import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/data/request/auth/login.dart';
import '../../route/app_routes.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  UserType userType = UserType.customer;

  Future<void> loginFunction({
    required LoginRequest loginRequest,
    required BuildContext context,
  }) async {
    emit(state.copyWith(loadingLogin: true));

    try {
      final result = await UserCase().authUserCase.callLogin(
        loginRequest: loginRequest,
      );

      emit(state.copyWith(loadingLogin: false));

      result.handle(
        onSuccess: (UserResponse user) {
          setUserStorage(user);

          showMessage(user.message , value: true);

          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.rootGeneral,
            (route) => false,
          );
        },
        onFailed: (message) {
          showMessage(message, value: false);
        },
        onNoInternet: () {
          showMessage(StringApp.noData, value: false);
        },
      );
    } catch (e) {
      emit(state.copyWith(loadingLogin: false));
    }
  }

  functionToggleUserType(UserType userType) {
    this.userType = userType;
    emit(state.copyWith(userType: this.userType));
  }

  Future<void> signupFunction(
    BuildContext context,
    SignupRequest signupRequest,
  ) async {
    emit(state.copyWith(loadingSignup: true, signupRequest: signupRequest));
    final result = await UserCase().authUserCase.callSignup(
      signupRequest: state.signupRequest!,
    );
    emit(state.copyWith(loadingSignup: false));
    result.handle(
      onSuccess: (data) {
        showMessage(
          "A verification code has been sent to your Whatsapp".tr(),
          value: true,
        );
        ToWithFade(AppRoutes.virefyCodeSignup, arguments: signupRequest.mobile);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
      onFailed: (message) {
        showMessage(message.toString(), value: false);
      },
    );
  }

  Future<void> confirmCode(BuildContext context, String code) async {
    emit(state.copyWith(loadingConfirmCode: true));
    final result = await UserCase().authUserCase.callConfirmCode(
      confirmCodeRequirest: ConfirmCodeRequest(code: code),
      signupRequest: state.signupRequest!,
    );
    emit(state.copyWith(loadingConfirmCode: false));

    result.handle(
      onSuccess: (UserResponse data) {
        setUserStorage(data);
        ToRemoveAll(AppRoutes.rootGeneral);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }

  changeCheck(bool check) {
    emit(state.copyWith(check: check));
  }

  changeCountry(Country c) {
    emit(state.copyWith(country: c));
  }

  Future<void> deleteAccountUser() async {
    showBoatToast();
    final result = await UserCase().authUserCase.deleteAccount();
    closeAllLoading();
    result.handle(
      onSuccess: (data) {
        removeUser();
        ToRemoveAll(AppRoutes.splash);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> logoutAccountUser() async {
    showBoatToast();
    final result = await UserCase().authUserCase.logoutAccount();
    closeAllLoading();
    result.handle(
      onSuccess: (data) {
        removeUser();
        ToRemoveAll(AppRoutes.splash);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> switchAccountUser(
    BuildContext context, {
    required String userType,
  }) async {
    showBoatToast();
    removeDataSeller();
    if (getUser()!.user!.can_switch_between_accounts == false) {
      
      await signupFunction(
        context,
        SignupRequest(
          mobile: getUser()!.user!.phone!,
          password: "12345678",
          confirmPassword: "12345678",
          userType: UserType.seller,
          email: getUser()!.user!.email,
          name: getUser()!.user!.name,
        ),
      );
      closeAllLoading();
    } else {
      final result = await UserCase().authUserCase.switchAccount(
        userType: userType,
      );
      closeAllLoading();
      result.handle(
        onSuccess: (SwitchAccountResponse data) {
          setUserStorage(
            UserResponse(
              accessToken: data.token!,
              user: data.user,
              message: data.message,
            ),
          );
          functionWhenSwitchAccount(context);
        },
        onFailed: (message) {
          showMessage(message, value: false);
        },
        onNoInternet: () {
          showMessage(StringApp.noInternet, value: false);
        },
      );
    }
  }

  changeVisibalePassword({bool isLogin = true}) {
    if (isLogin) {
      emit(state.copyWith(isShowPassword: !state.isShowPassword));
      return;
    } else {
      emit(state.copyWith(isShowPasswordSignup: !state.isShowPasswordSignup));
    }
  }

  Future<void> editProfile({
    String? name,
    String? email,
    String? phone,
    String? code,
  }) async {
    emit(state.copyWith(loadingEditProfile: true));
    final result = await UserCase().profileUseCase.profileUpdate(
      data: {"name": name, "email": email, "phone": "$code$phone"},
    );
    emit(state.copyWith(loadingEditProfile: false));
    result.handle(
      onSuccess: (data) {
        setUserStorage(data);
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        showMessage(data.message, value: true);
      },
    );
  }

  Future<void> forgetPassword(String mobile) async {
    emit(state.copyWith(loadingForgetPassword: true));
    final result = await UserCase().authUserCase.forgetPassword(
      "${state.country!.phoneCode}$mobile",
    );
    emit(state.copyWith(loadingForgetPassword: false));

    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        ToWithFade(
          AppRoutes.verificationCodeForgetPassword,
          arguments: "${state.country!.phoneCode}$mobile",
        );
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> verifyCodeForgetPassword(String code, String mobile) async {
    emit(state.copyWith(loadingVerifyCodeForgetPassword: true));
    final result = await UserCase().authUserCase.verifyResetPassword(code);
    emit(state.copyWith(loadingVerifyCodeForgetPassword: false));

    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        ToWithFade(AppRoutes.createNewPassowrd, arguments: code);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> changePassword(
    BuildContext context,
    String code,
    String password,
  ) async {
    emit(state.copyWith(loadingCreateNewPassword: true));
    final result = await UserCase().authUserCase.createNewPassword(
      code: code,
      password: password,
    );
    emit(state.copyWith(loadingCreateNewPassword: false));

    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        ToRemoveAll(AppRoutes.login);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> reSendCode(String mobile) async {
    showBoatToast();
    final result = await UserCase().authUserCase.reSendCode(phone: mobile);
    closeAllLoading();
    result.handle(
      onSuccess: (data) {
        showMessage(result.message!, value: true);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> signInGoogle() async {
    showBoatToast();
    final user = await SochialGoogleAppleLogin.signInWithGoogle();
    closeAllLoading();
    if (user != null) {
      showBoatToast();

      final result = await UserCase().authUserCase.socialLogin(
        socialAuth: SocialAuth(
          providerId: user.credential!.providerId,
          accessSecret: user.credential!.token ?? "",
          accessToken: user.credential!.accessToken ?? "",
          socialProvider: 'google',
          userType: userType.name,
        ),
      );
      closeAllLoading();

      result.handle(
        onSuccess: (data) {
          UserResponse userResponse = UserResponse.fromJson(data);
          setUserStorage(userResponse);
          showMessage(data['message'], value: true);
          ToRemoveAll(AppRoutes.rootGeneral);
        },
        onFailed: (message) {
          showMessage(message, value: false);
        },
        onNoInternet: () {
          showMessage(StringApp.noInternet, value: false);
        },
      );
    } else {
      showMessage("Login failed", value: false);
    }
  }

  void functionWhenSwitchAccount(BuildContext context) {
    context.read<AppCubit>().onClickBottomNavigationBar(
              0,
              context.read<AppCubit>().state.selectPageRoot,
            );
    ToRemoveAll(AppRoutes.rootGeneral);
  }
}
