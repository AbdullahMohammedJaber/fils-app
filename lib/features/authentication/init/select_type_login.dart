import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/authentication/widget.dart';
import 'package:fils/managment/auth_manage/auth_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/item_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectTypeLoginScreen extends StatelessWidget {
  const SelectTypeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: heigth * 0.02),
            ItemBack(title: "SIGN UP".tr()),
            SizedBox(height: heigth * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ButtonWidget(
                onTap: () {
                  ToRemove(AppRoutes.login);
                },
                title: "Follow-up using phone number".tr(),
              ),
            ),
            SizedBox(height: heigth * 0.05),
            DefaultText("OR".tr()),
            SizedBox(height: heigth * 0.05),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: buildSocialMediaAuth(
                path: "assets/icons/google.svg",
                onTap: () async {
                  context.read<AuthCubit>().signInGoogle();
                },
              ),
            ),
            if (!Platform.isIOS)
              Column(
                children: [
                  SizedBox(height: heigth * 0.015),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: buildSocialMediaAuth(
                      path: "assets/icons/apple.svg",
                      onTap: () async {
                        context.read<AuthCubit>().signInApple();
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
