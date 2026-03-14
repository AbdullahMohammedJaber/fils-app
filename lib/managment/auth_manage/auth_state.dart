import 'package:country_picker/country_picker.dart';
import 'package:fils/utils/enum_class.dart';

import '../../core/data/request/auth/signup.dart';

class AuthState {
  final bool loadingLogin;
  final bool loadingSignup;
  final bool loadingConfirmCode;
  final bool check;
  final UserType? userType;
  final Country? country;
  final SignupRequest? signupRequest;
   final bool isShowPassword;
  final bool isShowPasswordSignup;
  final bool isShowPasswordSignupConfirm;

  final bool loadingEditProfile;
  final bool loadingForgetPassword;
  final bool loadingVerifyCodeForgetPassword;
  final bool loadingCreateNewPassword;
  const AuthState({
    this.loadingLogin = false,
    this.loadingEditProfile = false,
    this.isShowPasswordSignup = true,
    this.isShowPasswordSignupConfirm = true,
     this.loadingSignup = false,
    this.loadingVerifyCodeForgetPassword = false,
    this.loadingConfirmCode = false,
    this.userType,
    this.signupRequest,
    this.check = false,
    this.country,
    this.isShowPassword = true,
    this.loadingForgetPassword = false,
    this.loadingCreateNewPassword = false,
  });

  AuthState copyWith({
    bool? loadingLogin,
    bool? loadingSignup,
    bool? loadingConfirmCode,
    bool? loadingVerifyCodeForgetPassword,
    bool? loadingEditProfile,
    UserType? userType,
    bool? check,
    Country? country,
    SignupRequest? signupRequest,
     bool? isShowPassword,
    bool? isShowPasswordSignup,
    bool? isShowPasswordSignupConfirm,
    bool? loadingForgetPassword,
    bool? loadingCreateNewPassword,
  }) {
    return AuthState(
      loadingLogin: loadingLogin ?? this.loadingLogin,
      
      userType: userType ?? this.userType,
      check: check ?? this.check,
      loadingEditProfile: loadingEditProfile ?? this.loadingEditProfile,
      country: country ?? this.country,
      signupRequest: signupRequest ?? this.signupRequest,
       loadingSignup: loadingSignup ?? this.loadingSignup,
      loadingConfirmCode: loadingConfirmCode ?? this.loadingConfirmCode,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      isShowPasswordSignupConfirm:
          isShowPasswordSignupConfirm ?? this.isShowPasswordSignupConfirm,
      isShowPasswordSignup: isShowPasswordSignup ?? this.isShowPasswordSignup,
      loadingForgetPassword:
          loadingForgetPassword ?? this.loadingForgetPassword,
      loadingVerifyCodeForgetPassword:
          loadingVerifyCodeForgetPassword ??
          this.loadingVerifyCodeForgetPassword,
      loadingCreateNewPassword:
          loadingCreateNewPassword ?? this.loadingCreateNewPassword,
    );
  }
}
