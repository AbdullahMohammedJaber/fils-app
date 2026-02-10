import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/auction/auction_cubit.dart';
import 'package:fils/utils/theme/color_manager.dart';

String statusTitle(String status) {
  switch (status) {
    case "started":
      return "Current Auction".tr();
    case "completed":
      return "Completed".tr();
    case "cancelled":
      return "Canceled".tr();
    case "coming":
    return "Coming Auction".tr()  ;
    default:
      return "";
  }
}

Color statusColor(String status) {
  switch (status) {
    case "started":
      return primaryColor;
    case "completed":
      return const Color(0xff32D732);
    case "cancelled":
      return const Color(0xffE4626F);
       case "coming":
      return const Color(0xffE4626F);

    default:
      return primaryColor;
  }
}

Color statusContainerColor(String status) {
  switch (status) {
    case "started":
      return primaryColor.withOpacity(0.3);
    case "completed":
      return const Color(0xff32D732).withOpacity(0.3);
    case "cancelled":
      return const Color(0xffE4626F).withOpacity(0.3);
      case "coming":
      return const Color(0xffE4626F).withOpacity(0.3);
    default:
      return primaryColor;
  }
}

bool isLive(AuctionState state) {
  if (state.detailsAuctionResponse!.data.auction_type == "live") {
    return true;
  } else {
    return false;
  }
}

bool isStarted(AuctionState state) {
  if (state.detailsAuctionResponse!.data.status == "started") {
    return true;
  } else {
    return false;
  }
}
