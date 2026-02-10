import 'package:flutter/material.dart';
 import 'package:fils/utils/theme/color_manager.dart';

import '../storage.dart';
import 'font_manager.dart';

TextStyle _getTextStyle(double? fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: getLang() == 'ar'
          ? FontConstants.fontFamilyAr
          : FontConstants.fontFamily,
      color: color,
      fontWeight: fontWeight);
}

// regular style

TextStyle getRegularStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle({required double fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// medium style

TextStyle getLightStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.light, color);
}

TextStyle getLightVeryStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.veryLight, color);
}
// bold style

TextStyle getBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// semibold style

TextStyle getSemiBoldStyle({double? fontSize, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
}

ButtonStyle elevatedButtonStyle({Color? color, double? radius}) =>
    ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: color,
      elevation: 0,
      minimumSize: const Size(55, 30),
      textStyle: const TextStyle(
        color: Colors.white, /*fontFamily: FontConstants.currentFont*/
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 15)),
      ),
    );
ButtonStyle elevatedOutLinButtonStyle({Color? color, double? radius}) =>
    OutlinedButton.styleFrom(
      //onPrimary: Colors.white,
      foregroundColor: color, backgroundColor: primaryColor,
      elevation: 0,
      side: BorderSide(color: primaryColor, width: 1.5),
      minimumSize: const Size(38, 38),
      textStyle: const TextStyle(
        color: Colors.white, /* fontFamily:FontConstants.currentFont*/
      ),
      // padding: EdgeInsets.symmetric(horizontal: 16,vertical: 5.h ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
      ),
    );
