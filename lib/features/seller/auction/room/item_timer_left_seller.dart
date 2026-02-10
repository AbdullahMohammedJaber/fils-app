import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/cupertino.dart';
 

class ItemTimerLeftSeller extends StatefulWidget {
  final AuctionSeller data;

  const ItemTimerLeftSeller({super.key, required this.data});

  @override
  State<ItemTimerLeftSeller> createState() => _ItemTimerLeftSellerState();
}

class _ItemTimerLeftSellerState extends State<ItemTimerLeftSeller> {
  late Auction remainingTime;
  late Auction startTime;
  late Timer timer;

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  bool _hasTimeLeft(Auction time) {
    return time.days > 0 ||
        time.hours > 0 ||
        time.minutes > 0 ||
        time.seconds > 0;
  }

  void _decrementTime(Auction time) {
    if (time.seconds > 0) {
      time.seconds--;
    } else {
      time.seconds = 59;
      if (time.minutes > 0) {
        time.minutes--;
      } else {
        time.minutes = 59;
        if (time.hours > 0) {
          time.hours--;
        } else {
          time.hours = 23;
          if (time.days > 0) {
            time.days--;
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    startTime = widget.data.auction_start_date;
    remainingTime = widget.data.auctionTimeLeft;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_hasTimeLeft(startTime)) {
          _decrementTime(startTime);
        } else if (_hasTimeLeft(remainingTime)) {
          _decrementTime(remainingTime);
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
          widget.data.status == "coming"
              ? DefaultText(
                "It begins after".tr(),
                fontSize: 16,
                color: const Color(0xff5A5555),
                fontWeight: FontWeight.w500,
              )
              : DefaultText(
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
              _buildTimeUnit(
                (_hasTimeLeft(startTime)
                        ? startTime.hours
                        : remainingTime.hours)
                    .toString(),
                "Hours".tr(),
              ),
              _buildColon(),
              _buildTimeUnit(
                (_hasTimeLeft(startTime)
                        ? startTime.minutes
                        : remainingTime.minutes)
                    .toString(),
                "Minute".tr(),
              ),
              _buildColon(),
              _buildTimeUnit(
                (_hasTimeLeft(startTime)
                        ? startTime.seconds
                        : remainingTime.seconds)
                    .toString(),
                "Second".tr(),
              ),
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
