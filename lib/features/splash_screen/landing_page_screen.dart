import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

class LandingPageScreen extends StatelessWidget {
  const LandingPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            ToWithFade(AppRoutes.selectTypeLoginScreen);
          },
          child: Image.asset("assets/images/wrapper.png"),
        ),
        Container(
          width: width,
          alignment: AlignmentDirectional.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DefaultText(
                "Welcome to fils".tr(),
                color: white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: heigth * 0.01),
              SizedBox(
                width: width*0.7,
                child: DefaultText(
                  "Join thousands of competitors around the Dreamer and start your auction now".tr(),
                  color: white,
                  fontSize: 16,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: heigth * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonWidget(
                  colorButton: white,
                  colorTitle: blackColor,
                  onTap: () {
                    removeUser();
                    ToRemoveAll(AppRoutes.rootGeneral);
                  },
                  title: "Login as guest".tr(),
                  sizeTitle: 16,
                  fontType: FontType.SemiBold,
                ),
              ),

              SizedBox(height: heigth * 0.18),
            ],
          ),
        ),
      ],
    );
  }
}
