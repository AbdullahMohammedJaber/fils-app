// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/features/coustamer/auction/room_auction/normal_auction/bids_section.dart';
import 'package:fils/features/seller/auction/details_auction/header_images_seller.dart';
import 'package:fils/features/seller/auction/details_auction/item_timer_left_seller.dart';
import 'package:fils/features/seller/auction/room/timer_seller.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
 import 'package:fils/utils/widget/defulat_text.dart';
 import 'package:flutter/material.dart';

 

import 'package:fils/utils/const.dart';

import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
 
class RoomAuctionSellerScreen extends StatefulWidget {
  final AuctionSeller detailsAuctionResponse;

  const RoomAuctionSellerScreen(
      {super.key, required this.detailsAuctionResponse});

  @override
  State<RoomAuctionSellerScreen> createState() =>
      _RoomAuctionSellerScreenState();
}

class _RoomAuctionSellerScreenState extends State<RoomAuctionSellerScreen> {
  TextEditingController bidController = TextEditingController();
 @override
  void initState() {
 
    super.initState();
    context.read<AuctionCubit>().fetchBids(
     widget.detailsAuctionResponse.id,
    );
  }
  @override
  Widget build(BuildContext context) {
   
    return BlocConsumer<AuctionCubit , AuctionState>(
      listener: (context, state) {
        
      },
      builder: (context, app) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderImagesSeller(data: widget.detailsAuctionResponse),
              SizedBox(height: heigth * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      "Auction Name".tr(),
                      color: const Color(0xff433E3F),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    DefaultText(
                      widget.detailsAuctionResponse.name,
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      "Initial price".tr(),
                      color: const Color(0xff433E3F),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    DefaultText(
                      widget.detailsAuctionResponse.mainPrice,
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      "Auction time".tr(),
                      color: const Color(0xff433E3F),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    TimerSellerAuction(data: widget.detailsAuctionResponse),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
              app.bids.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          DefaultText(
                            "Highest price".tr(),
                            color: const Color(0xff433E3F),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(width: 5),
                          DefaultText(
                            app.bids.last.bid.user.name,
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          const Spacer(),
                          DefaultText(
                            "${app.bids.last.bid.amount} KWD",
                            color: const Color(0xffFE1515),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              SizedBox(height: heigth * 0.03),
              ItemTimerLeftSeller(data: widget.detailsAuctionResponse),
              SizedBox(height: heigth * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DefaultText(
                      "Participants".tr(),
                      color: primaryDarkColor,
                      fontSize: 18,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w600,
                    ),
                    widget.detailsAuctionResponse.auction_type == "live"
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  
                                },
                                child: DefaultText(
                                  "Live Room".tr(),
                                  color: primaryDarkColor,
                                  fontSize: 18,
                                  textAlign: TextAlign.start,
                                  textDecoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  
                                },
                                icon: const Icon(
                                    Icons.video_camera_front_rounded),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: heigth * 0.03),
              BidsSection(
                id: widget.detailsAuctionResponse.id,
                
              ),
              SizedBox(height: heigth * 0.02),
            ],
          ),
        ),
      );
    });
  }
}
