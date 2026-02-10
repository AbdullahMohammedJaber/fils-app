import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

import '../../../route/control_route.dart';
import '../product/general_product.dart';

class ItemProductHome extends StatelessWidget {
  final HomeResponse homeResponse;

  const ItemProductHome({super.key, required this.homeResponse});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12),
      child:
          homeResponse.data!.newProducts.data!.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DefaultText(
                        "New Product".tr(),
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
                          homeResponse.data!.newProducts.data!.length,
                          (index) => Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: width * 0.01,
                            ),
                            child: ProductItemWidget(
                              false,
                              isAuction: false,

                              productListModel:
                                  homeResponse.data!.newProducts.data![index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : const SizedBox(),
    );
  }
}
