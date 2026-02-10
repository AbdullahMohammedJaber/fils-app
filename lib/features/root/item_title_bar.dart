// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/widget/flip_view.dart';

class ItemTitleBar extends StatelessWidget {
  String title;
  Function()? onTap;
  bool canBack;
  bool canAdd;
  Color? colorTitle;
  Color? colorIconBack;

  ItemTitleBar({
    super.key,
    required this.title,
    this.onTap,
    this.canBack = false,
    this.canAdd = false,
    this.colorTitle,
    this.colorIconBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (canBack) ...[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              height: getLang() == 'ar' ? 30 : 28,
              width: 40,
              child: FlipView(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/back.svg",
                    color: colorIconBack ?? (getTheme() ? white : Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
        SizedBox(width: width * 0.01),
        DefaultText(
          title.tr(),
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: colorTitle ?? primaryDarkColor,
        ),
        if (canAdd) ...[
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: primaryDarkColor,
              ),
              child: Center(child: SvgPicture.asset("assets/icons/plus.svg")),
            ),
          ),
          SizedBox(width: width * 0.07),
        ],
      ],
    );
  }
}
