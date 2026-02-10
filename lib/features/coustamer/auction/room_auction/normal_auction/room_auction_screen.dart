import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/auction/room_auction/normal_auction/item_timer_left_room.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/dialog_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/const.dart';
import '../../../../../utils/theme/color_manager.dart';
import '../../../../../utils/widget/defulat_text.dart';
import '../../item_banner_details.dart';
 import '../gift_auction/gift_box_show.dart';
import '../gift_auction/gift_section.dart';
import 'auction_timer.dart';
import 'bids_section.dart';

class RoomAuctionScreen extends StatefulWidget {
  const RoomAuctionScreen({super.key});

  @override
  State<RoomAuctionScreen> createState() => _RoomAuctionScreenState();
}

class _RoomAuctionScreenState extends State<RoomAuctionScreen> {
  TextEditingController bidController = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  void initState() {
 
    super.initState();
    context.read<AuctionCubit>().fetchBids(
      context.read<AuctionCubit>().state.detailsAuctionResponse!.data.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocConsumer<AuctionCubit, AuctionState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<AuctionCubit>();

        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: Form(
            key: key,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ItemBannerDetailsAuction(
                        data: state.detailsAuctionResponse!.data,
                      ),
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
                              state.detailsAuctionResponse!.data.name,
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
                            TimerAuction(
                              data: state.detailsAuctionResponse!.data,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: heigth * 0.03),
                      state.bids.isNotEmpty
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
                                const Spacer(),
                                DefaultText(
                                  "KWD ${state.totalPriceBid}",
                                  color: const Color(0xffFE1515),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          )
                          : const SizedBox(),
                      SizedBox(height: heigth * 0.03),
                      GiftSection(id: state.detailsAuctionResponse!.data.id),
                      SizedBox(height: heigth * 0.03),
                      ItemTimerLeftRoom(data: state.detailsAuctionResponse!.data),
                      SizedBox(height: heigth * 0.03),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DefaultText(
                          "Participants".tr(),
                          color: purpleColor,
                          fontSize: 18,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: heigth * 0.05),
                      BidsSection(id: state.detailsAuctionResponse!.data.id),
                      const SizedBox(height: 2),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: textColor)),
                        ),
                        child: TextFormField(
                          controller: bidController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (bidController.text.isEmpty || value!.isEmpty) {
                              return StringApp.requiredField;
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Add bid ...".tr(),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.send, color: primaryColor),
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  if (isLogin()) {
                                    controller.validateBid(
                                      bid: double.parse(bidController.text),
                                    );
                                    bidController.clear();
                                  } else {
                                    showDialogAuth(context);
                                  }
                                }
                              },
                            ),
                          ),
                          textInputAction: TextInputAction.send,
                          onFieldSubmitted: (value) async {
                            if (key.currentState!.validate()) {
                              if (isLogin()) {
                                controller.validateBid(
                                  bid: double.parse(bidController.text),
                                );
                                bidController.clear();
                              } else {
                                showDialogAuth(context);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const GiftBoxOverlay(),
              ],
            ),
          ),
        );
      },
    );
  }
}
