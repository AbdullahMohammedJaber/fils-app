import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/search/rating_item.dart';
import 'package:fils/features/coustamer/search/slider_range_item.dart';
import 'package:fils/features/coustamer/search/store/category_section.dart';
import 'package:fils/features/coustamer/search/tap_bar_item.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

import '../../../utils/storage.dart';
import '../../../utils/widget/button_widget.dart';
import '../../../utils/widget/defulat_text.dart';
import 'auction/live_normal_bar.dart';
import 'auction/tap_bar_validaty.dart';
import 'auction/time_date_bar.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            color: getTheme() ? Colors.black : white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width, height: heigth * 0.04),
                    // Title BottomSheet
                    Row(
                      children: [
                        DefaultText(
                          "Filter".tr(),
                          color: primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset("assets/icons/close.svg"),
                        ),
                      ],
                    ),
                    SizedBox(width: width, height: heigth * 0.04),
                    DefaultText(
                      "General Section".tr(),
                      color: getTheme() ? white : const Color(0xff433E3F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: width, height: heigth * 0.02),
                    const TabBarItemFilter(),
                    SizedBox(width: width, height: heigth * 0.05),
                  ],
                ),
                state.typeSection == 1
                    ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const CategorySection(),
                            SizedBox(width: width, height: heigth * 0.03),
                            const PriceRangeSlider(),
                            SizedBox(width: width, height: heigth * 0.05),
                            const RatingItem(),
                            SizedBox(width: width, height: heigth * 0.05),
                          ],
                        ),
                      ),
                    )
                    : Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const TabBarAuctionTypeFilter(),
                            SizedBox(width: width, height: heigth * 0.05),
                            const TabBarAuctionValidateFilter(),
                            SizedBox(width: width, height: heigth * 0.05),
                            const TabBarAuctionTimeDateFilter(),
                            SizedBox(width: width, height: heigth * 0.05),
                            const PriceRangeSlider(),
                            SizedBox(width: width, height: heigth * 0.05),
                            const RatingItem(),
                            SizedBox(width: width, height: heigth * 0.05),
                          ],
                        ),
                      ),
                    ),
                ButtonWidget(
                  title: "Apply".tr(),
                  fontType: FontType.bold,
                  colorButton: secondColor,
                  onTap: () {
                    ToRemove(AppRoutes.allProductFilter, arguments: '');
                  },
                ),
                SizedBox(width: width, height: heigth * 0.05),
              ],
            ),
          ),
        );
      },
    );
  }
}
