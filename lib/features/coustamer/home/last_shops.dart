
 // ignore_for_file: must_be_immutable
 
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/features/coustamer/store/item_store.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
 
import '../../../route/control_route.dart';

class ItemShopHome extends StatelessWidget {
  HomeResponse data;

  ItemShopHome({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12),
      child:
          data.data!.shops.data.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DefaultText(
                        "Online Store".tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: getTheme() ? white : blackColor,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          ToWithFade(AppRoutes.allStoreScreen);
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
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(data.data!.shops.data.length, (
                          index,
                        ) {
                          ShopsDatum dataInter = data.data!.shops.data[index];
                          if (dataInter.logo == null || dataInter.logo == "") {
                            return const SizedBox();
                          } else {
                           return  ItemStore(dataInter: dataInter,);
                          }
                        }),
                      ),
                    ),
                  ),
                ],
              )
              : const SizedBox(),
    );
  }
}
