import 'dart:ui';

 

import 'package:flutter/material.dart';




bool isPasswordValid(String password) {
  return RegExp(r'^(?=.*[a-zA-Z])(?=.*[!@#$&*~]).{8,}$').hasMatch(password);
}

bool isEmailValid(String email) {
  return RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
}

String checkPasswordStrength(String password) {
  dynamic score = 0;

  if (RegExp(r'[a-z]').hasMatch(password)) score++;

  if (RegExp(r'[A-Z]').hasMatch(password)) score++;

  if (RegExp(r'[0-9]').hasMatch(password)) score++;

  if (RegExp(r'[!@#$&*~]').hasMatch(password)) score++;

  if (password.length >= 8 && password.length < 12) {
    score++;
  } else if (password.length >= 12) {
    score += 2;
  }

  if (score <= 2) {
    return "Weak";
  } else if (score == 3 || score == 4) {
    return "Medium";
  } else if (score == 5 || score == 6) {
    return "Good";
  } else if (score >= 7) {
    return "Strong";
  }

  return "Weak";
}

double extractNumber(String input) {
  String numericString = input.substring(1, input.length);

  return double.parse(numericString);
}

String getTextByDash(String input, bool beforeDash) {
  int dashIndex = input.indexOf('–');
  if (dashIndex == -1) return input.trim();

  if (beforeDash) {
    return input.substring(0, dashIndex).trim();
  } else {
    return input.substring(dashIndex + 1).trim();
  }
}

String cleanMobileNumber(String number) {
  number = number.trim();
  if (number.startsWith('+')) {
    number = number.substring(1);
  }
  return number;
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'ff$hex'; // إضافة الشفافية الافتراضية
  }
  return Color(int.parse('0x$hex'));
}

bool containsPlatinum(String text) {
  final pattern = RegExp(r'(بلاتينية|Platinum)', caseSensitive: false);
  return pattern.hasMatch(text);
}
bool containsSelver(String text) {
  final pattern = RegExp(r'(الفضية|Silver)', caseSensitive: false);
  return pattern.hasMatch(text);
}
/*checkStatusStore(bool isProduct, BuildContext context) async {
  if (getAllShop().id == null) {
    showCustomFlash(
      message: "Please Select your Shop".tr(),
      messageType: MessageType.Faild,
    );
  } else {
    showBoatToast(title: "Loading");
    var json = await NetworkHelper.sendRequest(
      requestType: RequestType.get,
      endpoint: "get-current-package/${getUser()!.user!.id}",
    );
    closeAllLoading();

    PackageInfoResponse packageInfoResponse = PackageInfoResponse.fromJson(
      json,
    );
    printBlue("get-current-package");
    printBlue(packageInfoResponse.toJson().toString());
    setPackageInfo(packageInfoResponse);
    if (packageInfoResponse.data == null) {
      showCustomFlash(
        message:
            "You must subscribe to a package to be able to add products and enjoy the services."
                .tr(),
        messageType: MessageType.Faild,
      );
      ToWithFade(context, SubscriptionsScreen(typeStore: 0,));
    }
    else {
      await context.read<StoreNotifire>().functionGetDataStore(
          isGetComplete: true);
      if (getShopInfo().data!.description == "null" ||
          getShopInfo().data!.description == null ||
          getShopInfo().data!
              .description
              .toString()
              .isEmpty) {
        // TODO translate
        showCustomFlash(message: "Please complete data store".tr(),
            messageType: MessageType.Faild);

        ToWithFade(NavigationService.navigatorKey.currentContext!,
            EditStoreInformation());
      } else{
        if (isProduct == false) {
        if (getPackageInfo().data!.normalAuction! > 0) {
          TowithTrans(
            context,
            FormAddAuction(),
            PageTransitionType.bottomToTop,
          );
        } else {
          showCustomFlash(
            message:
            "You must subscribe to a package to be able to add products and enjoy the services."
                .tr(),
            messageType: MessageType.Faild,
          );
        }
      }
      else {
        if (getPackageInfo().data!.productUploadLimit! > 0) {
          TowithTrans(
            context,
            FormAddProduct(),
            PageTransitionType.bottomToTop,
          );
        } else {
          showCustomFlash(
            message:
            "You must subscribe to a package to be able to add products and enjoy the services."
                .tr(),
            messageType: MessageType.Faild,
          );
        }
      }
    }
    }
  }
}*/

/*
String removeEmojis(String text) {
  final emojiRegex = RegExp(
    r'[\u{1F600}-\u{1F64F}' // الوجوه التعبيرية
    r'\u{1F300}-\u{1F5FF}' // الرموز والعناصر
    r'\u{1F680}-\u{1F6FF}' // وسائل النقل
    r'\u{2600}-\u{26FF}' // الرموز المتنوعة
    r'\u{2700}-\u{27BF}' // الرموز الأخرى
    r'\u{1F900}-\u{1F9FF}' // رموز إضافية
    r'\u{1FA70}-\u{1FAFF}' // رموز إضافية حديثة
    r'\u{1F1E6}-\u{1F1FF}]', // أعلام الدول
    unicode: true,
  );

  return text.replaceAll(emojiRegex, '');
}
*/
