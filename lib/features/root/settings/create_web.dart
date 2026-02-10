import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/utils/theme/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../route/control_route.dart';
import '../../../utils/const.dart';
 import '../../../utils/storage.dart';

import '../../../utils/widget/defulat_text.dart';
import '../../../utils/widget/dialog_auth.dart';

class CreateWebScreen extends StatelessWidget {
  const CreateWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: heigth * 0.06),
            ItemTitleBar(canBack: true, title: "Create Web".tr()),
            SizedBox(height: heigth * 0.06),
            Container(
              height: 50,
              width: width * 0.5,
              decoration: BoxDecoration(
                color: Color(0xff039DF0).withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: DefaultText("Create Web".tr(), color: Color(0xff039DF0)),
              ),
            ),
            SizedBox(height: heigth * 0.03),

            Image.asset("assets/images/webb.png"),
            SizedBox(height: heigth * 0.02),

            SizedBox(
              width: width * 0.4,
              child: Center(
                child: DefaultText(
                  "Create your website in minutes".tr(),
                  fontSize: 24,
                  color: primaryDarkColor,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
            SizedBox(height: heigth * 0.03),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: width * 0.99,
                child: Center(
                  child: DefaultText(
                    "A comprehensive platform to create professional websites without any programming knowledge. Start now and launch your business online."
                        .tr(),
                    fontSize: 24,
                    color: textColor,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
            SizedBox(height: heigth * 0.05),
            GestureDetector(
              onTap: () {
                if (isLogin()) {
                  toUrl('http://wibex.io');
                } else {
                  showDialogAuth(context);
                }
              },
              child: Container(
                height: 70,
                width: width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      primaryColor,

                      Colors.purple,
                      Colors.purple,

                      Colors.purpleAccent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DefaultText(
                      "Start Free".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: white,
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(getLang() == 'ar' ? 0 : pi),
                      child: Center(
                        child: SvgPicture.asset(
                          height: 15,
                          "assets/icons/mynaui_arrow-up-solid.svg",
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: heigth * 0.05),
          ],
        ),
      ),
    );
  }
}
