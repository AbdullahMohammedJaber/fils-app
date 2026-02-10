// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fils/utils/const.dart';

import 'package:fils/utils/theme/color_manager.dart';

class donePay extends StatefulWidget {
  const donePay({super.key});

  @override
  State<donePay> createState() => _donePayState();
}

class _donePayState extends State<donePay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/x.svg",
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heigth * 0.02),
            Image.asset("assets/images/done.png"),
            SizedBox(height: heigth * 0.05),
            SizedBox(
              width: width * 0.7,
              child: DefaultText(
                "Payment has been successfully completed - You will receive your order within 24 hours"
                    .tr(),
                color: const Color(0xff5A5555),
                fontSize: 16,
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: heigth * 0.05),
            ButtonWidget(
              title: "back to home Page".tr(),
              colorButton: secondColor,
              sizeTitle: 17,
              fontType: FontType.bold,
              onTap: () {
                ToRemoveAll(AppRoutes.rootGeneral);
              },
            ),
            SizedBox(height: heigth * 0.03),
          ],
        ),
      ),
    );
  }
}

class faieldPay extends StatelessWidget {
  const faieldPay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 45,
                    width: 45,
                    color: Colors.transparent,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/x.svg",
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heigth * 0.02),
            Image.asset("assets/images/false.png"),
            SizedBox(height: heigth * 0.05),
            SizedBox(
              width: width * 0.7,
              child: DefaultText(
                "Payment has been not completed".tr(),
                color: const Color(0xff5A5555),
                fontSize: 16,
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: heigth * 0.05),
            ButtonWidget(
              title: "back to home Page".tr(),
              colorButton: secondColor,
              sizeTitle: 17,
              fontType: FontType.bold,
              onTap: () {
                Navigator.pop(context);
                ToRemoveAll(AppRoutes.rootGeneral);
              },
            ),
            SizedBox(height: heigth * 0.03),
          ],
        ),
      ),
    );
  }
}
