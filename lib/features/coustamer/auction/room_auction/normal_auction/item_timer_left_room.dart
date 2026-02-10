import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/details_auction_response.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/cupertino.dart';
 
 
class ItemTimerLeftRoom extends StatefulWidget {
  final Auction data;

  const ItemTimerLeftRoom({super.key, required this.data});

  @override
  State<ItemTimerLeftRoom> createState() => _ItemTimerLeftRoomState();
}

class _ItemTimerLeftRoomState extends State<ItemTimerLeftRoom> {
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
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    remainingTime = widget.data.auctionEndDate;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_hasTimeLeft()) {
          _decrementTime();
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            "Time left".tr(),
            fontSize: 16,
            color: const Color(0xff5A5555),
            fontWeight: FontWeight.w500,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTimeUnit(remainingTime.days, "Days".tr()),
              _buildColon(),
              _buildTimeUnit(remainingTime.hours, "Hours".tr()),
              _buildColon(),
              _buildTimeUnit(remainingTime.minutes, "Minute".tr()),
              _buildColon(),
              _buildTimeUnit(remainingTime.seconds, "Second".tr()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(dynamic value, String label) {
    return Column(
      children: [
        itemCounter(title: value),
        SizedBox(height: heigth * 0.005),
        DefaultText(
          label.tr(),
          fontSize: 6,
          color: textColor,
          type: FontType.medium,
        ),
      ],
    );
  }

  Widget _buildColon() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: DefaultText(
        ":",
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: blackColor,
      ),
    );
  }

  Widget itemCounter({dynamic title}) {
    return Container(
      height: heigth * 0.06,
      width: width * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffA9A9A9),
      ),
      child: Center(
        child: DefaultText(
          title.toString(),
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: white,
        ),
      ),
    );
  }
}
