import 'dart:async';

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeForgetPassword extends StatefulWidget {
  final String mobile;
  const VerificationCodeForgetPassword({super.key, required this.mobile});

  @override
  State<VerificationCodeForgetPassword> createState() =>
      _VerificationCodeForgetPasswordState();
}

class _VerificationCodeForgetPasswordState
    extends State<VerificationCodeForgetPassword> {
  final focusNode = FocusNode();

  TextEditingController pinController = TextEditingController();

  late Timer timer;

  dynamic remainingTime = 59;

  startTimer() {
    remainingTime = 59;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        setState(() {});
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      textStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: grey6,
      ),
    );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: width, height: heigth * 0.1),
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
                              child: SvgPicture.asset("assets/icons/back.svg"),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      DefaultText(
                        "FORGET PASSWORD".tr(),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(width: width, height: heigth * 0.08),
                  DefaultText(
                    "Enter the code sent to your phone number and email".tr(),
                    textAlign: TextAlign.start,
                    fontSize: 18,
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff433E3F),
                  ),
                  SizedBox(width: width, height: heigth * 0.02),
                  
                  Center(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        controller: pinController,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        validator: (value) {
                          return value!.isEmpty || value.length < 4
                              ? 'Pin is incorrect'.tr()
                              : null;
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        onCompleted: (pin) {
                          pinController.text = pin;
                          setState(() {});
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 15, height: 1, color: white),
                          ],
                        ),
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                            border: Border.all(color: primaryColor),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme.copyWith(
                          decoration: defaultPinTheme.decoration!.copyWith(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                            border: Border.all(color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width, height: heigth * 0.02),
                  Center(
                    child: DefaultText(
                      "00:${remainingTime < 10 ? "0${remainingTime.toString()}" : remainingTime.toString()}",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  remainingTime == 0
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            "Code not received ?".tr(),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                          const SizedBox(width: 2),
                          GestureDetector(
                            onTap: () async {
                              pinController.clear();
                              await context.read<AuthCubit>().reSendCode(
                                widget.mobile,
                              );

                              startTimer();
                            },
                            child: DefaultText(
                              "Resend".tr(),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: secondColor,
                            ),
                          ),
                        ],
                      )
                      : const SizedBox(),
                  SizedBox(width: width, height: heigth * 0.1),
                  pinController.text.isEmpty
                      ? const SizedBox()
                      : ButtonWidget(
                        title:
                            state.loadingVerifyCodeForgetPassword
                                ? true
                                : "SUBMIT".tr(),
                        fontType: FontType.bold,
                        sizeTitle: 16,
                        onTap: () {
                          context.read<AuthCubit>().verifyCodeForgetPassword(
                            pinController.text,
                            pinController.text,
                          );
                        },
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
