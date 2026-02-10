import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/auction/item_banner_details.dart';
import 'package:fils/features/coustamer/auction/item_timer_left.dart';
import 'package:fils/features/coustamer/auction/status_auction.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/timer_format.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:fils/utils/widget/dialog_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DetailsAuction extends StatefulWidget {
  final dynamic id;

  const DetailsAuction({super.key, required this.id});

  @override
  State<DetailsAuction> createState() => _DetailsAuctionState();
}

class _DetailsAuctionState extends State<DetailsAuction> {
  @override
  void initState() {
    super.initState();
    context.read<AuctionCubit>().fetchAuctionDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
      body: BlocBuilder<AuctionCubit, AuctionState>(
        builder: (context, state) {
          if (state.loadingDetails) {
            return LoadingUi();
          } else if (state.errorDetails != null) {
            return NeonNoInternetView(
              onRetry: () {
                context.read<AuctionCubit>().fetchAuctionDetails(widget.id);
              },
              error: state.errorDetails!,
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ItemBannerDetailsAuction(
                    data: state.detailsAuctionResponse!.data,
                  ),
                  SizedBox(height: heigth * 0.02),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12),
                    child: Row(
                      children: [
                        DefaultText(
                          state.detailsAuctionResponse!.data.name,
                          color: const Color(0xff5A5555),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.visible,
                        ),
                        const Spacer(),
                        Container(
                          height: 25,
                          decoration: BoxDecoration(
                            color: statusContainerColor(
                              state.detailsAuctionResponse!.data.status,
                            ),
                            borderRadius: const BorderRadiusDirectional.only(
                              topStart: Radius.circular(5),
                              bottomStart: Radius.circular(5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                              child: DefaultText(
                                statusTitle(
                                  state.detailsAuctionResponse!.data.status,
                                ),
                                color: statusColor(
                                  state.detailsAuctionResponse!.data.status,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heigth * 0.05),

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
                          width: width * 0.85,
                          child: DefaultText(
                            state.detailsAuctionResponse!.data.description,
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
                                  state.detailsAuctionResponse!.data.shopName,
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
                                  formatDate(
                                    state
                                        .detailsAuctionResponse!
                                        .data
                                        .auctionStartAt,
                                  ),
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
                  ItemTimerLeft(data: state.detailsAuctionResponse!.data),
                  SizedBox(height: heigth * 0.03),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/icons/notesBig.svg"),
                            const SizedBox(width: 10),
                            DefaultText(
                              "Note".tr(),
                              fontSize: 14,
                              color: const Color(0xff5A5555),
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        SizedBox(height: heigth * 0.01),
                        SizedBox(
                          width: width * 0.8,
                          child: DefaultText(
                            "The auction room will be opened when the time comes and you will be notified in the notifications."
                                .tr(),
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
                    child: GestureDetector(
                      onTap: () {
                        if (isLogin()) {
                          if (isLive(state)) {
                            print("Live");
                          } else {
                            ToRemove(
                              AppRoutes.roomAuctionScreen,
                              arguments: state.detailsAuctionResponse,
                            );
                          }
                        } else {
                          showDialogAuth(context);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: width,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color:
                              isStarted(state)
                                  ? secondColor
                                  : const Color(0xff898384),
                        ),
                        child: Center(
                          child:
                              isLive(state)
                                  ? SvgPicture.asset("assets/icons/live.svg")
                                  : DefaultText(
                                    "Enter the auction room".tr(),
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: heigth * 0.03),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

/*
 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      state.detailsAuctionResponse!.data.auction_type == "live"
                          ? GestureDetector(
                            onTap: () async {
                              if (isLogin()) {
                                if (state.detailsAuctionResponse!.data.isLive == 1 ||
                                    state.detailsAuctionResponse!.data.isPaused == 1) {
                                  if (state.detailsAuctionResponse!.data.channel == null) {
                                    /*showCustomFlash(
                                      message: "Live Not Available".tr(),
                                      messageType: MessageType.Faild,
                                    );*/
                                  } else {
                                   /* ToWithFade(
                                      context,
                                      LiveWatchPage(
                                        playbackUrl:
                                            data.data.channel!.playbackUrl,
                                        detailsAuctionResponse: data,
                                      ),
                                    );*/
                                  }
                                } else {
                                 /* showCustomFlash(
                                    message: "Live Not Available".tr(),
                                    messageType: MessageType.Faild,
                                  );*/
                                }
                              } else {
                                showDialogAuth(context);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              width: width * 0.25,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(23),
                                color:
                                    state.detailsAuctionResponse!.data.status == "started"
                                        ? secondColor
                                        : const Color(0xff898384),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/live.svg",
                                ),
                              ),
                            ),
                          )
                          : const SizedBox(),
                      Expanded(
                        child: ButtonWidget(
                          onTap: () {
                           /* if (isLogin()) {
                              if (data.data.status == "started" && isLogin()) {
                                ToRemove(
                                  context,
                                  RoomAuctionScreen(
                                    detailsAuctionResponse: data,
                                  ),
                                );
                              }
                            } else {
                              showDialogAuth(context);
                            }*/
                          },
                          colorButton:
                              state.detailsAuctionResponse!.data.status == "started"
                                  ? secondColor
                                  : const Color(0xff898384),
                          heightButton: 50,
                          radius: 23,
                          title: "Enter the auction room".tr(),
                        ),
                      ),
                    ],
                  ),
                ),
*/
