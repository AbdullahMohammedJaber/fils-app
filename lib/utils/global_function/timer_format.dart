// ignore_for_file: missing_return, void_checks

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../storage.dart';


String getTimeAgo(DateTime targetTime) {
  final now = DateTime.now();
  final difference = now.difference(targetTime);

  if (difference.inDays >= 365) {
    final years = difference.inDays ~/ 365;
    return "$years ${"Years".tr()}";
  } else if (difference.inDays >= 30) {
    final months = difference.inDays ~/ 30;
    return "$months ${"Months".tr()}";
  } else if (difference.inDays >= 1) {
    return "${difference.inDays} ${"Day".tr()}";
  } else if (difference.inHours >= 1) {
    return "${difference.inHours} ${"Hour".tr()}";
  } else if (difference.inMinutes >= 1) {
    return "${difference.inMinutes} ${"Minutes".tr()}";
  } else {
    return "Just now".tr();
  }
}

String getTimeRemaining(DateTime targetDateTime) {
  String timeRemaining = "";

  Timer.periodic(const Duration(seconds: 1), (Timer timer) {
    DateTime currentDateTime = DateTime.now();

    Duration difference = targetDateTime.difference(currentDateTime);

    if (difference.isNegative) {
      timeRemaining = "الوقت انتهى!";
      timer.cancel();
    } else {
      dynamic days = difference.inDays;
      dynamic hours = difference.inHours.remainder(24);
      dynamic minutes = difference.inMinutes.remainder(60);
      dynamic seconds = difference.inSeconds.remainder(60);

      timeRemaining = "متبقي $secondsث : $minutesد : $hoursس : $daysي";
    }

    if (kDebugMode) {
      print(timeRemaining);
    }
  });

  return timeRemaining;
}

String formatTime(DateTime dateTime) {
  String formattedTime = DateFormat('h:mm a', getLang()).format(dateTime);
  if (getLang() == 'ar') {
    formattedTime =
        formattedTime.replaceAll('AM', 'صباحا').replaceAll('PM', 'مساءً');
  }

  return formattedTime;
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd/MM/yyyy', getLang()).format(dateTime);
}

String formatDate2(DateTime dateTime) {
  return DateFormat('dd-MM-yyyy', 'en').format(dateTime);
}

String formatDateFilter(DateTime dateTime) {
  final DateFormat formatter = DateFormat("d MMM /yyyy", getLang());
  return formatter.format(dateTime);
}

/*bool isAuctionEnded(AuctionEndDate auctionEndDate) {
  // حساب إجمالي الوقت المتبقي بالثواني
  dynamic totalSeconds = (auctionEndDate.days * 24 * 60 * 60) +
      (auctionEndDate.hours * 60 * 60) +
      (auctionEndDate.minutes * 60) +
      auctionEndDate.seconds;

  // إذا كانت القيمة أقل أو تساوي الصفر، فإن الوقت قد انتهى
  return totalSeconds <= 0;
}*/

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
  return DateFormat('hh:mm a', getLang()).format(dateTime);
}

String formatTimeOfDay2(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
}

String mergeDateTime(DateTime? date, TimeOfDay? time) {
  final dynamic hour = time!.hour;
  final dynamic minute = time.minute;

  final DateTime combinedDateTime = DateTime(
    date!.year,
    date.month,
    date.day,
    hour,
    minute,
  );

  return "${combinedDateTime.year.toString().padLeft(4, '0')}-"
      "${combinedDateTime.month.toString().padLeft(2, '0')}-"
      "${combinedDateTime.day.toString().padLeft(2, '0')} "
      "${combinedDateTime.hour.toString().padLeft(2, '0')}:"
      "${combinedDateTime.minute.toString().padLeft(2, '0')}:00";
}
