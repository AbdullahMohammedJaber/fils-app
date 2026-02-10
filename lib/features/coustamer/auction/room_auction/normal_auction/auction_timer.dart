// ignore_for_file: unused_element

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/details_auction_response.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../utils/const.dart';
import '../../../../../utils/theme/color_manager.dart';
import '../../../../../utils/widget/defulat_text.dart';


class TimerAuction extends StatefulWidget {
  final Auction data;

  const TimerAuction({super.key, required this.data});

  @override
  State<TimerAuction> createState() => _TimerAuctionState();
}

class _TimerAuctionState extends State<TimerAuction> {
  late AuctionEndDate remainingTime;
  late Timer timer;

  bool _hasTimeLeft() {
    return remainingTime.days > 0 ||
        remainingTime.hours > 0 ||
        remainingTime.minutes > 0 ||
        remainingTime.seconds > 0;
  }

  void _decrementTime() {
    if (remainingTime.seconds > 0) {
      remainingTime.seconds--;
    } else {
      remainingTime.seconds = 59;
      if (remainingTime.minutes > 0) {
        remainingTime.minutes--;
      } else {
        remainingTime.minutes = 59;
        if (remainingTime.hours > 0) {
          remainingTime.hours--;
        } else {
          remainingTime.hours = 23;
          if (remainingTime.days > 0) {
            remainingTime.days--;
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    remainingTime = widget.data.auction_period;

    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {
    //     if (_hasTimeLeft()) {
    //       _decrementTime();
    //     } else {
    //       timer.cancel();
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          remainingTime.days == 0
              ? const SizedBox()
              : _buildTimeUnit(remainingTime.days, "Days".tr()),
          remainingTime.hours == 0
              ? const SizedBox()
              : _buildTimeUnit(remainingTime.hours, "Hours".tr()),
          remainingTime.minutes == 0
              ? const SizedBox()
              : _buildTimeUnit(remainingTime.minutes, "Minute".tr()),
          remainingTime.seconds == 0
              ? const SizedBox()
              : _buildTimeUnit(remainingTime.seconds, "Second".tr()),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(dynamic value, String label) {
    return Row(
      children: [
        itemCounter(title: value),
        SizedBox(width: width * 0.01),
        DefaultText(
          label.tr(),
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: textColor,
          type: FontType.medium,
        ),
        SizedBox(width: width * 0.01),
      ],
    );
  }

  Widget itemCounter({dynamic title}) {
    return Center(
      child: DefaultText(
        title.toString(),
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
    );
  }
}
