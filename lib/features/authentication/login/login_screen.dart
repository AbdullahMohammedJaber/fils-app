import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/request/auth/login.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/route/app_routes.dart';

import 'package:fils/utils/string.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../route/control_route.dart';
import '../../../utils/const.dart';

import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/button_widget.dart';
import '../../../utils/widget/custom_validation.dart';
import '../../../utils/widget/defualt_text_form_faild.dart';
import '../../../utils/widget/defulat_text.dart';
import '../widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    SizedBox(width: width, height: heigth * 0.05),
                    DefaultText(
                      "SIGN IN".tr(),
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                    SizedBox(width: width, height: heigth * 0.07),

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
                            if (phoneController.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else if (controller.state.country == null) {
                              return "Please select a country".tr();
                            } else if (!RegExp(
                              r'^[0-9]+$',
                            ).hasMatch(phoneController.text)) {
                              return "The number must contain only numbers."
                                  .tr();
                            } else if (phoneController.text.length < 6 ||
                                phoneController.text.length > 12) {
                              return "Please enter a valid number".tr();
                            } else {
                              return null;
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormFieldWidget(
                                  controller: phoneController,
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
                    SizedBox(width: width, height: heigth * 0.03),
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
                            if (passwordController.text.isEmpty) {
                              return StringApp.requiredField.tr();
                            } else if (passwordController.text.length < 8) {
                              return StringApp.passwordLessDigit.tr();
                            } else {
                              return null;
                            }
                          },
                          child: TextFormFieldWidget(
                            controller: passwordController,
                            isPreffix: true,
                            hintText: "Password".tr(),
                            isShow: state.isShowPassword,
                            pathIconPrefix: "assets/icons/lock.svg",
                            isIcon: true,
                            ontapIcon: () {
                              controller.changeVisibalePassword();
                            },
                            textInputType: TextInputType.visiblePassword,
                            pathIcon: "assets/icons/eye-slash.svg",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ToWithFade(AppRoutes.forgetPassword);
                          },
                          child: DefaultText(
                            "Forget Password ?".tr(),
                            color: textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: heigth * 0.02),

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
                    SizedBox(height: heigth * 0.05),
                    ButtonWidget(
                      colorButton: secondColor,
                      title:
                          controller.state.loadingLogin
                              ? controller.state.loadingLogin
                              : "SIGN IN".tr(),
                      fontType: FontType.bold,
                      sizeTitle: 16,
                      radius: 14,
                      onTap: () async {
                        if (!formKey.currentState!.validate()) {
                        } else {
                          if (controller.state.check) {
                            LoginRequest login = LoginRequest(
                              mobile:
                                  "${controller.state.country!.phoneCode}${phoneController.text}",
                              password: passwordController.text,
                              userType: controller.userType,
                            );

                            controller.loginFunction(
                              loginRequest: login,
                              context: context,
                            );
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
                            SizedBox(height: 5),
                           buildSocialMediaAuth(
                            
                            onTap: () async {
                              ToRemoveAll(AppRoutes.rootGeneral);
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
                           SizedBox(height: 5),
                           buildSocialMediaAuth(
                            
                            onTap: () async {
                              ToRemoveAll(AppRoutes.rootGeneral);
                            },
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
                            "Don't have an account ?".tr(),
                            type: FontType.medium,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            ToWithFade(AppRoutes.signupScreen);
                          },
                          child: SizedBox(
                            height: 50,
                            child: DefaultText(
                              "SIGN UP".tr(),
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
