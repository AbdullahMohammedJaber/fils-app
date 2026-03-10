import 'package:cherry_toast/cherry_toast.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:share_plus/share_plus.dart';

double width = 0.0;
double heigth = 0.0;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
showMessage(String message, {required bool value}) {
  if (value) {
    CherryToast.success(
      title: Text(message, style: TextStyle(color: blackColor)),
    ).show(NavigationService.navigatorKey.currentContext!);
  } else {
    CherryToast.error(
      title: Text(message, style: TextStyle(color: blackColor)),
    ).show(NavigationService.navigatorKey.currentContext!);
  }
}

void shareStoreLink(dynamic storeId) {
  final link = "https://dashboard.fils.app/store/$storeId";
  Share.share(
    "قم بزيارة متجري :  $link",
    subject: "مشاركة رابط المتجر الخاص بك",
  );
}

void shareProductLink(dynamic productId) {
  final link = "https://dashboard.fils.app/product/$productId";
  Share.share(
    "قم بزيارة منتجي :  $link",
    subject: "مشاركة رابط المنتج الخاص بك",
  );
}

void shareAuctionLink(dynamic productId) {
  final link = "https://dashboard.fils.app/auction/$productId";
  Share.share(
    "قم بزيارة مزادي :  $link",
    subject: "مشاركة رابط المزاد الخاص بك",
  );
}
