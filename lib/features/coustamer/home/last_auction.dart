import 'package:easy_localization/easy_localization.dart';
 import 'package:fils/core/data/response/home/home_response.dart'  ;
import 'package:fils/features/coustamer/auction/item_auction_new.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

class LastAuctionHome extends StatelessWidget {
  final HomeResponse homeResponse;

  const LastAuctionHome({super.key, required this.homeResponse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            children: [
              DefaultText(
                "Last Auction".tr(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: getTheme() ? white : blackColor,
              ),
            ],
          ),
          SizedBox(height: heigth * 0.02),
           homeResponse.data!.latestAuction!=null?
          ItemAuctionNew(
            item: homeResponse.data!.latestAuction!,
          ) : SizedBox(),
        ],
      ),
    );
  }
}
