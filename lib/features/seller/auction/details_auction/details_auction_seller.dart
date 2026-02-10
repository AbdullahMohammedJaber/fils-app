

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/features/coustamer/auction/status_auction.dart';
import 'package:fils/features/seller/auction/details_auction/header_images_seller.dart';
import 'package:fils/features/seller/auction/details_auction/item_timer_left_seller.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/timer_format.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

class DetailsAuctionSeller extends StatefulWidget {
final  AuctionSeller data;
  const DetailsAuctionSeller({super.key , required this.data});

  @override
  State<DetailsAuctionSeller> createState() => _DetailsAuctionSellerState();
}

class _DetailsAuctionSellerState extends State<DetailsAuctionSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 0,
        ), 

        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderImagesSeller(data: widget.data),
               SizedBox(height: heigth * 0.02),
              Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: Row(
                  children: [
                    DefaultText(
                      widget.data.name,
                      color: const Color(0xff5A5555),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.visible,
                    ),
                    const Spacer(),
                   
                    Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: statusContainerColor(widget.data.status),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(5),
                          bottomStart: Radius.circular(5),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: DefaultText(
                            statusTitle(widget.data.status),
                            color: statusColor(widget.data.status),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(height: heigth * 0.02),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    DefaultText(
                      "Price".tr(),
                      color: const Color(0xff5A5555),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    const Spacer(),
                    DefaultText(
                      widget.data.mainPrice,
                      color: secondColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      "Product Details".tr(),
                      fontSize: 14,
                      color: const Color(0xff5A5555),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: heigth * 0.01),
                    SizedBox(
                      width: width,
                      child: DefaultText(
                       widget. data.description,
                        fontSize: 10,
                        color: textColor,
                        overflow: TextOverflow.visible,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: heigth * 0.09,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(
                              "Seller".tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                            const SizedBox(height: 8),
                            DefaultText(
                              getUser()!.user!.name,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: secondColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: heigth * 0.09,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(
                              "Auction date".tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                            const SizedBox(height: 8),
                            DefaultText(
                              formatDate(widget.data.auctionEndDateString),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: secondColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
               ItemTimerLeftSeller(data: widget.data),
              SizedBox(height: heigth * 0.03),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ButtonWidget(
                  title:widget.data.auction_type== "live" ? "Enter in Live".tr() : "Enter the auction room".tr(),
                  colorButton:
                      widget.data.status == "started" ? secondColor : textColor,
                  onTap: () async {
                    if (widget.data.status == "started") {
                      ToRemove(AppRoutes.roomAuctionSeller , arguments: widget.data);
                    }
                  },
                ),
              ),
              SizedBox(height: heigth * 0.1),
            ],
          ),
        ),
    );
  }
}