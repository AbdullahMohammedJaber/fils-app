import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:flutter/material.dart';
 import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/storage.dart';
import '../../../../utils/widget/defulat_text.dart';


class TabBarAuctionTypeFilter extends StatelessWidget {
  const TabBarAuctionTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var app = context.read<SearchCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultText(
          "Type Auction".tr(),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  app.changeTypeAuction(1);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: state.typeAuction == 1 ? primaryDarkColor :getTheme() ? Colors.black : white,
                    border: Border.all(
                      color:
                      state.typeAuction == 1 ? primaryDarkColor :getTheme() ? Colors.white : textColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultText(
                      "Live".tr(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: state.typeAuction == 1 ? white :getTheme() ? Colors.white : textColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  app.changeTypeAuction(2);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: state.typeAuction == 2 ? primaryDarkColor :getTheme() ? Colors.black : white,
                    border: Border.all(
                      color:
                      state.typeAuction == 2 ? primaryDarkColor :getTheme() ? Colors.white : textColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultText(
                      "Normal".tr(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: state.typeAuction == 2 ? white :getTheme() ? Colors.white : textColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  },
);
  }
}
