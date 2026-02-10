import 'package:flutter/material.dart';
 import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/theme/constants_manager.dart';
import 'package:fils/utils/theme/font_manager.dart';
import 'package:fils/utils/theme/styles_manager.dart';
import 'package:fils/utils/theme/values_manager.dart';
import 'package:flutter/services.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors
    primaryColor: primaryColor,
    primaryColorLight: grey3,
    colorScheme: ColorScheme.light(
      primary: primaryColor, 
      secondary: primaryColor,
    ),
    primaryColorDark: primaryColor,
    scaffoldBackgroundColor: Color(0xfffafafa),
    disabledColor: grey2,
    splashColor: primaryColor,
    fontFamily:
        ConstantGlobalVar.locale == ConstantGlobalVar.en
            ? FontConstants.fontFamily
            : FontConstants.fontFamilyAr,

    //  scaffoldBackgroundColor: fWhite,

    // ripple effect color
    iconTheme: IconThemeData(color: primaryColor),

    cardTheme: CardThemeData(
      color: white,
      shadowColor: grey2,
      elevation: AppSize.s4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xfffafafa),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      // color: primary,
      backgroundColor: white,
      toolbarHeight: 10,
      elevation: AppSize.s0,
      iconTheme: IconThemeData(color: blackColor),
      // shadowColor: lightPrimary,
      titleTextStyle: getLightStyle(fontSize: FontSize.s12, color: blackColor),
    ),

    // button theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      //disabledColor: borderTextFailed,
      buttonColor: primaryColor,
      splashColor: Colors.red,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primaryColor,
      inactiveTrackColor: primaryColor,
      trackShape: const RectangularSliderTrackShape(),
      trackHeight: 0.1,
      thumbColor: primaryColor,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12.0),
      overlayColor: Colors.red,
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 28.0),
    ),
    // elevated button them
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: white, fontSize: FontSize.s17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(color: white, fontSize: FontSize.s14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s0),
        ),
      ),
    ),
    tabBarTheme: TabBarThemeData(
      unselectedLabelColor: blackColor,
      labelColor: white,
      unselectedLabelStyle: getLightStyle(
        fontSize: AppSize.s14,
        color: primaryColor.withOpacity(0.3),
      ),
      labelStyle: getBoldStyle(fontSize: AppSize.s16, color: white),

      // indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(color: primaryColor),
    ),
    textTheme: TextTheme(
      displaySmall: getRegularStyle(
        color: blackColor,
        fontSize: FontSize.s14,
      ).copyWith(decoration: TextDecoration.lineThrough),
      displayLarge: getBoldStyle(color: blackColor, fontSize: FontSize.s14),
      displayMedium: getMediumStyle(color: blackColor, fontSize: FontSize.s14),
      headlineLarge: getSemiBoldStyle(
        color: blackColor,
        fontSize: FontSize.s14,
      ),
      headlineMedium: getRegularStyle(
        color: blackColor,
        fontSize: FontSize.s14,
      ),
      titleMedium: getMediumStyle(color: blackColor, fontSize: FontSize.s14),
      titleSmall: getLightVeryStyle(color: blackColor, fontSize: FontSize.s14),
      bodyLarge: getRegularStyle(color: blackColor, fontSize: FontSize.s14),
      bodySmall: getLightStyle(color: blackColor, fontSize: FontSize.s14),
      bodyMedium: getMediumStyle(color: blackColor, fontSize: FontSize.s14),
      labelSmall: getSemiBoldStyle(color: blackColor, fontSize: FontSize.s14),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      // content padding
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppPadding.p10,
        horizontal: AppPadding.p16,
      ),
      // hint style
      hintStyle: getRegularStyle(color: grey2, fontSize: FontSize.s14),
      labelStyle: getMediumStyle(color: grey2, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: Colors.red),
    ),

    // label style
  );
}
