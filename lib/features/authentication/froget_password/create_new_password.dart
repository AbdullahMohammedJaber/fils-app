import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

class CreateNewPassword extends StatefulWidget {
  final String code;

  const CreateNewPassword({super.key, required this.code});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  double _passwordStrength = 0.0;
  String _strengthLabel = "Weak".tr();
  Color _strengthColor = textColor;

  void _checkPasswordStrength(String password) {
    setState(() {
      if (password.isEmpty) {
        _passwordStrength = 0;
        _strengthLabel = "Weak".tr();
        _strengthColor = Colors.grey;
      } else if (password.length < 4) {
        _passwordStrength = 0.25;
        _strengthLabel = "Weak".tr();
        _strengthColor = Colors.red;
      } else if (password.length < 8) {
        _passwordStrength = 0.5;
        _strengthLabel = "Medium".tr();
        _strengthColor = Colors.orange;
      } else if (password.length < 12) {
        _passwordStrength = 0.75;
        _strengthLabel = "Good".tr();
        _strengthColor = Colors.yellow;
      } else {
        _passwordStrength = 1.0;
        _strengthLabel = "Strong".tr();
        _strengthColor = Colors.green;
      }
    });
  }

  TextEditingController newPasswordControllerForChangePassword =
      TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: width, height: heigth * 0.14),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: FlipView(
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/back.svg",
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        DefaultText(
                          "RESET PASSWORD".tr(),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.08),
                    DefaultText(
                      "You can reset your password.".tr(),
                      textAlign: TextAlign.start,
                      fontSize: 18,
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff433E3F),
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    DefaultText(
                      "You can set up a strong password to keep yourself safe."
                          .tr(),
                      textAlign: TextAlign.start,
                      fontSize: 14,
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    SizedBox(width: width, height: heigth * 0.06),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Password".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (newPasswordControllerForChangePassword
                                .text
                                .isEmpty) {
                              return StringApp.requiredField;
                            }
                            return null;
                          },
                          child: TextFormFieldWidget(
                            controller: newPasswordControllerForChangePassword,
                            isPreffix: true,
                            hintText: "Password".tr(),

                            pathIconPrefix: "assets/icons/lock.svg",
                            isIcon: true,
                            onChange: (c) {
                              _checkPasswordStrength(c);
                            },
                            ontapIcon: () {},
                            textInputType: TextInputType.visiblePassword,
                            pathIcon: "assets/icons/eye-slash.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.01),
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/note.svg"),
                        Container(
                          width: width * 0.8,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          child: DefaultText(
                            "The password must contain numbers, letters and symbols and must not be less than 8 characters."
                                .tr(),
                            fontSize: 12,
                            overflow: TextOverflow.visible,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.01),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          constraints: BoxConstraints(maxWidth: width * 0.6),
                          width:
                              _passwordStrength == 0
                                  ? width * 0.1
                                  : _passwordStrength * width,
                          height: 10,
                          decoration: BoxDecoration(
                            color: _strengthColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Expanded(
                          child: DefaultText(
                            'Password strength ($_strengthLabel)',
                            fontSize: 8,
                            type: FontType.medium,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.15),
                    ButtonWidget(
                      colorButton: secondColor,
                      title:
                          state.loadingCreateNewPassword
                              ? true
                              : "SIGN IN".tr(),
                      fontType: FontType.bold,
                      sizeTitle: 16,
                      radius: 14,
                      onTap: () async {
                        if (!_key.currentState!.validate()) {
                        } else {
                          context.read<AuthCubit>().changePassword(
                            context,
                            widget.code,
                            newPasswordControllerForChangePassword.text,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
