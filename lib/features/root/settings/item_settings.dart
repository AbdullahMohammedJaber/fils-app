import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/flip_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

Widget itemSetting({
  String? pathIcon,
  String? title,
  Function()? onClick,
  bool showBackIcon = false,
}) {
  return GestureDetector(
    onTap: onClick,
    child: Container(
      color: Colors.transparent,

      width: width,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xffBA27B7).withOpacity(0.4),
            ),
            child: Center(
              child: SvgPicture.asset(
                pathIcon ?? "assets/icons/notification_home.svg",

                color: getTheme() ? white : null,
              ),
            ),
          ),
          SizedBox(width: width * 0.02),
          DefaultText(
            title ?? "Notifications".tr(),
            fontSize: 14,

            fontWeight: FontWeight.w500,
          ),
          const Spacer(),
          showBackIcon
              ? FlipView(
                child: SvgPicture.asset(
                  "assets/icons/arrow.svg",
                  color: getTheme() ? white : blackColor,
                ),
              )
              : const SizedBox(),
          SizedBox(width: width * 0.02),
        ],
      ),
    ),
  );
}
