import 'package:fils/utils/enum_class.dart';

class LoginRequest {
  final String mobile;
  final String password;

  final UserType userType;

  LoginRequest({
    required this.mobile,
    required this.password,
    required this.userType,
  });
}
