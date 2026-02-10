import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/data/response/auction/auction_response.dart';
 import '../../../managment/favorites/favorites_cubit.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class ItemAuctionNew extends StatefulWidget {
  final AuctionResponse item;

  const ItemAuctionNew({super.key, required this.item});

  @override
  State<ItemAuctionNew> createState() => _ItemAuctionNewState();
}

class _ItemAuctionNewState extends State<ItemAuctionNew> {
  late AuctionEndDate remainingTime;
  late AuctionEndDate startTime;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    startTime = widget.item.auction_start_date;
    remainingTime = widget.item.auctionEndDate;

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
  void dispose() {
    timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  bool _hasTimeLeft(AuctionEndDate time) {
    return time.days > 0 ||
        time.hours > 0 ||
        time.minutes > 0 ||
        time.seconds > 0;
  }

  void _decrementTime(AuctionEndDate time) {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
        if (startTime.seconds.toString() != '0' ||
            startTime.minutes.toString() != '0') {
          showMessage(  "Cannot enter the auction".tr(), value: false);
        } else if (startTime.seconds.toString() == '0' &&
            startTime.minutes.toString() == '0') {
          timer.cancel();
          ToWithFade(AppRoutes.detailsAuction, arguments: int.parse(widget.item.id.toString()));
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        child: Stack(
          children: [
            SizedBox(
              height: heigth * 0.4,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),

                child: CachedNetworkImage(
                  placeholder: (context, url) => const LoadingUi(),
                  errorWidget: (context, url, error) {
                    return Image.asset("assets/test/abaya.png");
                  },
                  imageUrl: widget.item.thumbnailImage,
                  height: heigth,
                  width: width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            PositionedDirectional(
              top: 10,
              start: 10,
              end: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DefaultText(
                    widget.item.shopName,
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool fav = await context
                          .read<FavoritesCubit>()
                          .addRemoveFavorites(
                        idProduct: widget.item.id!,
                        is_favorite:
                        widget.item.is_favorite,
                        type: 1,
                      );
                      setState(() {
                        widget.item.is_favorite = fav;
                      });

                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Center(
                          child: SvgPicture.asset(
                            widget.item.is_favorite
                                ? "assets/icons/fav_fill.svg"
                                : "assets/icons/fav_white.svg",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              bottom: 0.95,
              end: 0.95,
              start: 0.95,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DefaultText(
                                widget.item.name,
                                color: white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DefaultText(
                                    "Initial price".tr(),
                                    color: white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  SizedBox(height: 5),
                                  DefaultText(
                                    widget.item.mainPrice,
                                    color: white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            PositionedDirectional(
              bottom: heigth * 0.12,
              end: 7,

              child: Column(
                children: [
                  widget.item.status == "coming"
                      ? DefaultText(
                        "It begins after".tr(),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: white,
                      )
                      : DefaultText(
                        "Auction time".tr(),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: white,
                      ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        width: width * 0.3,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),

                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            height: 50,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DefaultText(
                                          (_hasTimeLeft(startTime)
                                                  ? startTime.hours
                                                  : remainingTime.hours)
                                              .toString(),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                        DefaultText(
                                          "hh",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: white,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DefaultText(
                                          (_hasTimeLeft(startTime)
                                                  ? startTime.minutes
                                                  : remainingTime.minutes)
                                              .toString(),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                        DefaultText(
                                          "mm",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: white,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        DefaultText(
                                          (_hasTimeLeft(startTime)
                                                  ? startTime.seconds
                                                  : remainingTime.seconds)
                                              .toString(),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: white,
                                        ),
                                        DefaultText(
                                          "ss",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
