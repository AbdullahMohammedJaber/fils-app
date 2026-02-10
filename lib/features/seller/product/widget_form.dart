import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

Widget faildFormProduct(
  BuildContext context, {
  required TextEditingController controller,
  required String title,
  String? pathIcon,
  TextInputType? textInputType,
  String? Function(dynamic)? validator,
  int? maxLines,
  bool   isDouble = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DefaultText(
        title.tr(),
        color: blackColor,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
      SizedBox(width: width, height: heigth * 0.01),
      ValidateWidget(
        validator: validator,
        child: TextFormFieldWidget(
          isPreffix: pathIcon != null ? true : false,
          maxLine: maxLines,
          isDouble: isDouble,
          controller: controller,
          textInputType: textInputType ?? TextInputType.name,
          hintText: title.tr(),
          pathIconPrefix: pathIcon,
        ),
      ),
      SizedBox(height: heigth * 0.02),
    ],
  );
}
