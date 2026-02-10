import '../../../../utils/enum_class.dart';

class SignupRequest {
  final String mobile;
  final String password;
  final String confirmPassword;
  final UserType userType;
  final String email;
  final String name;

  SignupRequest({
    required this.mobile,
    required this.password,
    required this.confirmPassword,
    required this.userType,
    required this.email,
    required this.name,
  });
}
