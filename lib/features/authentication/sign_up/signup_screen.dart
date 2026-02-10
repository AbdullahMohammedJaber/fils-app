// ignore_for_file: deprecated_member_use, must_be_immutable

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/utils/string.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import '../../../../utils/global_function/validation.dart';
import '../../../core/data/request/auth/signup.dart';
import '../../../route/app_routes.dart';
import '../../../utils/widget/button_widget.dart';
import '../../../utils/widget/custom_validation.dart';
import '../../../utils/widget/defualt_text_form_faild.dart';
import '../../../utils/widget/defulat_text.dart';
import '../widget.dart';

class SignupScreen extends StatefulWidget {
  bool isSwitch;

  SignupScreen({super.key, this.isSwitch = false});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<AuthCubit>();
        return SafeArea(
          child: Form(
            key: _key,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(width: width, height: heigth * 0.05),
                    DefaultText(
                      "SIGN UP".tr(),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),

                    SizedBox(width: width, height: heigth * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Full Name".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (name.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: name,
                            isPreffix: true,
                            textInputType: TextInputType.name,
                            hintText: "Full Name".tr(),
                            pathIconPrefix: "assets/icons/user.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "E - mail".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (email.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else if (!isEmailValid(email.text)) {
                              return StringApp.emailFalse.tr();
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: email,
                            isPreffix: true,
                            textInputType: TextInputType.emailAddress,
                            hintText: "E - mail".tr(),
                            pathIconPrefix: "assets/icons/sms.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Mobile Number".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (phone.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else if (controller.state.country == null) {
                              return "Please select a country".tr();
                            } else if (!RegExp(
                              r'^[0-9]+$',
                            ).hasMatch(phone.text)) {
                              return "The number must contain only numbers."
                                  .tr();
                            } else if (phone.text.length < 6 ||
                                phone.text.length > 12) {
                              return "Please enter a valid number".tr();
                            } else {
                              return null;
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormFieldWidget(
                                  controller: phone,
                                  isPreffix: true,
                                  textInputType: TextInputType.phone,
                                  hintText: "Mobile Number".tr(),
                                  pathIconPrefix: "assets/icons/mobile.svg",
                                ),
                              ),
                              picker(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
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
                            if (password.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else if (password.text.length < 8) {
                              return StringApp.passwordLessDigit.tr();
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: password,
                            isPreffix: true,
                            hintText: "Password".tr(),
                            isShow: state.isShowPasswordSignup,
                            pathIconPrefix: "assets/icons/lock.svg",
                            isIcon: true,
                            ontapIcon: () {
                              controller.changeVisibalePassword(isLogin: false);
                            },
                            textInputType: TextInputType.visiblePassword,
                            pathIcon: "assets/icons/eye-slash.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultText(
                          "Confirm Password".tr(),
                          color: blackColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        SizedBox(width: width, height: heigth * 0.01),
                        ValidateWidget(
                          validator: (value) {
                            if (confirmPassword.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else if (confirmPassword.text.length < 8) {
                              return StringApp.passwordLessDigit;
                            } else if (confirmPassword.text != password.text) {
                              return "Please confirm password".tr();
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: confirmPassword,
                            isPreffix: true,
                            hintText: "Confirm Password".tr(),
                             isShow: state.isShowPasswordSignup,
                            pathIconPrefix: "assets/icons/lock.svg",
                            isIcon: true,
                            ontapIcon: () {
                               controller.changeVisibalePassword(isLogin: false);
                            },
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
                    SizedBox(height: heigth * 0.03),
                     Row(
                      children: [
                        Checkbox(
                          value: controller.state.check,
                          onChanged: (value) {
                            controller.changeCheck(value!);
                          },
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontFamily: 'Almarai',
                              ),
                              children: [
                                TextSpan(
                                  text: "I agree to".tr(),

                                  style: TextStyle(
                                    color: blackColor,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                                TextSpan(
                                  text: ' '.tr(),
                                  style: TextStyle(
                                    color: secondColor,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                                TextSpan(
                                  text: 'privacy policy'.tr(),
                                  style: TextStyle(
                                    color: secondColor,
                                    fontFamily: 'Almarai',
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRoutes.privacyPolicy,
                                          );
                                        },
                                ),
                                TextSpan(
                                  text: ' '.tr(),
                                  style: TextStyle(
                                    color: secondColor,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                                TextSpan(
                                  text: 'and terms of use'.tr(),
                                  style: TextStyle(
                                    color: blackColor,
                                    fontFamily: 'Almarai',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.03),

                    ButtonWidget(
                      colorButton: secondColor,
                      title:
                          controller.state.loadingSignup
                              ? controller.state.loadingSignup
                              : "SIGN UP".tr(),
                      fontType: FontType.bold,
                      sizeTitle: 16,
                      radius: 14,
                      onTap: () async {
                        if (!_key.currentState!.validate()) {
                        } else {
                          if (controller.state.check) {
                            SignupRequest signup = SignupRequest(
                              mobile:
                                  "${controller.state.country!.phoneCode}${phone.text}",
                              password: password.text,
                              name: name.text,
                              confirmPassword: confirmPassword.text,
                              email: email.text,
                              userType: controller.userType,
                            );

                            controller.signupFunction(context, signup);
                          } else {
                            showMessage(
                              StringApp.messageCheckPrivacy.tr(),
                              value: false,
                            );
                          }
                        }
                      },
                    ),
                    SizedBox(height: heigth * 0.02),

                   
                    if (Platform.isAndroid) ...[
                      SizedBox(height: heigth * 0.03),
                      Row(
                        children: [
                          Expanded(child: Container(height: 1, color: grey2)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DefaultText(
                              "OR".tr(),
                              color: grey2,
                              type: FontType.medium,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(child: Container(height: 1, color: grey2)),
                        ],
                      ),
                      SizedBox(height: heigth * 0.023),
                      Column(
                        children: [
                          buildSocialMediaAuth(
                            path: "assets/icons/google.svg",
                            onTap: () async {
                              context.read<AuthCubit>().signInGoogle();
                            },
                          ),
                        ],
                      ),
                    ],
                    if (Platform.isIOS) ...[
                      SizedBox(height: heigth * 0.03),
                      Row(
                        children: [
                          Expanded(child: Container(height: 1, color: grey2)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DefaultText(
                              "OR".tr(),
                              color: grey2,
                              type: FontType.medium,
                              fontSize: 14,
                            ),
                          ),
                          Expanded(child: Container(height: 1, color: grey2)),
                        ],
                      ),
                      SizedBox(height: heigth * 0.023),
                      Column(
                        children: [
                          buildSocialMediaAuth(
                            path: "assets/icons/apple.svg",
                            onTap: () async {},
                          ),
                        ],
                      ),
                    ],
                    SizedBox(height: heigth * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: DefaultText(
                            "Already have an account ?".tr(),
                            type: FontType.medium,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            height: 50,
                            child: DefaultText(
                              "SIGN IN".tr(),
                              type: FontType.medium,
                              fontSize: 14,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.08),
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
