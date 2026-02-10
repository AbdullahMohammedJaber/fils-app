// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';

import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';
import '../product/general_product.dart';

class ItemRelatedProductHome extends StatelessWidget {
  HomeResponse data;

   ItemRelatedProductHome({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.data!.relatedProducts.data!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsetsDirectional.only(start: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DefaultText(
                  "Related Product".tr(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: getTheme() ? white : blackColor,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    ToWithFade(AppRoutes.allProductScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DefaultText(
                      "See All".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: heigth * 0.02),
            SizedBox(
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    data.data!.relatedProducts.data!.length,
                    (index) => Padding(
                      padding: EdgeInsetsDirectional.only(end: width * 0.01),
                      child: ProductItemWidget(
                              isAuction: false,

                        false,
                        productListModel:
                            data.data!.relatedProducts.data![index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
