import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/authentication/widget.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/managment/auth_manage/auth_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final _key = GlobalKey<FormState>();
  final mobileController = TextEditingController();
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
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: width, height: heigth * 0.10),
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
                          "FORGET PASSWORD".tr(),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.08),
                    DefaultText(
                      "Enter your mobile number".tr(),
                      textAlign: TextAlign.start,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff433E3F),
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    DefaultText(
                      "to send the code and follow the steps to change your password"
                          .tr(),
                      textAlign: TextAlign.start,
                      fontSize: 14,
                      overflow: TextOverflow.visible,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),

                    SizedBox(width: width, height: heigth * 0.05),
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
                            if (mobileController.text.isEmpty) {
                              return StringApp.requiredField;
                            } else if (!RegExp(
                              r'^[0-9]+$',
                            ).hasMatch(mobileController.text)) {
                              return "The number must contain only numbers."
                                  .tr();
                            } else if (mobileController.text.length < 6 ||
                                mobileController.text.length > 12) {
                              return "Please enter a valid number".tr();
                            } else if (state.country == null) {
                              return "Please select a country".tr();
                            } else {
                              return null;
                            }
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormFieldWidget(
                                  controller: mobileController,
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
                    SizedBox(width: width, height: heigth * 0.1),
                    ButtonWidget(
                      title:
                          state.loadingForgetPassword ? true : "CONTINUO".tr(),
                      colorButton: secondColor,
                      colorTitle: white,
                      fontType: FontType.bold,
                      sizeTitle: 18,
                      onTap: () {
                        context.read<AuthCubit>().forgetPassword(mobileController.text);
                      },
                    ),
                    SizedBox(width: width, height: heigth * 0.1),
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
