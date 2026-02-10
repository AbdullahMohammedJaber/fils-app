// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/global_function/timer_format.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';

import 'package:fils/utils/theme/color_manager.dart';

class ItemAuctionSeller extends StatefulWidget {
  final AuctionSeller datum;

  const ItemAuctionSeller({super.key, required this.datum});

  @override
  State<ItemAuctionSeller> createState() => _ItemAuctionSellerState();
}

class _ItemAuctionSellerState extends State<ItemAuctionSeller> {
  late Auction remainingTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    remainingTime = widget.datum.auctionTimeLeft;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      if (_hasTimeLeft()) {
        setState(() => _decrementTime());
      } else {
        timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        timer?.cancel();

        ToWithFade(AppRoutes.detailsAuctionSeller , arguments:  widget.datum);
      },
      child: Container(
        width: width,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffE8E2F8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: heigth * 0.01),
            widget.datum.status == "started"
                ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        "Time left for auction".tr(),
                        fontSize: 12,
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
                )
                : const SizedBox(),
            Row(
              children: [
                Container(
                  height: 55,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(color: grey2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsetsDirectional.only(
                    top: heigth * 0.02,
                    start: width * 0.03,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.datum.thumbnailImage,
                        placeholder: (context, url) => LoadingUi(),
                        errorWidget: (context, url, error) {
                          return Image.asset("assets/test/abaya.png");
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        widget.datum.name,
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      DefaultText(
                        widget.datum.shopName,
                        color: textColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                statusAuction(widget.datum),
              ],
            ),
            SizedBox(height: heigth * 0.01),
            const Divider(color: Color(0xffE8E2F8), thickness: 1.3),
            SizedBox(height: heigth * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/seller.svg"),
                  const SizedBox(width: 5),
                  DefaultText(
                    "Seller :".tr(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                  DefaultText(
                    widget.datum.shopName,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: heigth * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  SvgPicture.asset("assets/icons/calendar.svg"),
                  const SizedBox(width: 5),
                  DefaultText(
                    "Auction Date :".tr(),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                  DefaultText(
                    "  ${formatDate(widget.datum.auctionEndDateString)} ",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ],
              ),
            ),

            SizedBox(height: heigth * 0.02),
          ],
        ),
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

  Widget statusAuction(AuctionSeller data) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
        color: statusContainerColor(data.status),
        borderRadius: const BorderRadiusDirectional.only(
          topStart: Radius.circular(5),
          bottomStart: Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: DefaultText(
            statusTitle(data.status),
            color: statusColor(data.status),
            fontSize: 10,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }

  String statusTitle(String status) {
    switch (status) {
      case "started":
        return "Current Auction".tr();
      case "coming":
        return "Coming Auction".tr();
      case "completed":
        return "Completed".tr();
      case "cancelled":
        return "Canceled".tr();
      default:
        return "";
    }
  }

  Color statusColor(String status) {
    switch (status) {
      case "started":
        return primaryColor;
      case "coming":
        return purpleColor;
      case "completed":
        return const Color(0xff32D732);
      case "cancelled":
        return const Color(0xffE4626F);
      default:
        return primaryColor;
    }
  }

  Color statusContainerColor(String status) {
    switch (status) {
      case "started":
        return primaryColor.withOpacity(0.3);
      case "coming":
        return purpleColor.withOpacity(0.3);
      case "completed":
        return const Color(0xff32D732).withOpacity(0.3);
      case "cancelled":
        return const Color(0xffE4626F).withOpacity(0.3);
      default:
        return primaryColor;
    }
  }
}
