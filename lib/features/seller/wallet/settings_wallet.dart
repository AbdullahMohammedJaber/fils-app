


import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsWallet extends StatelessWidget {
  const SettingsWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             SizedBox(height: heigth * 0.06, width: width),
            ItemTitleBar(  title: "Wallet Settings".tr() , canBack: true,),
            SizedBox(height: heigth * 0.04, width: width),
            DefaultText(
              "Payment methods".tr(),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: blackColor,
            ),
               GestureDetector(
              onTap: () {
                ToRemove(AppRoutes.bankSetting);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: const Color(0xffFAFAFA),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/bank.svg"),
                      const SizedBox(width: 10),
                      DefaultText(
                        "Bank".tr(),
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      SvgPicture.asset("assets/icons/edit.svg"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}