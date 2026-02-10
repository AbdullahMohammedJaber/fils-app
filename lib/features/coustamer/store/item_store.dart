// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/const.dart';
import '../../../utils/storage.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class ItemStore extends StatelessWidget {
  dynamic dataInter;

  ItemStore({super.key, this.dataInter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: width * 0.01),
      child: GestureDetector(
        onTap: () {
          ToWithFade(
            AppRoutes.allProductStore,
            arguments: [dataInter.id, dataInter.name],
          );
         
        },
        child: Card(
          elevation: 1,
          color: getTheme() ? Colors.black : white,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: white),
            ),
            child: Row(
              children: [
                SizedBox(height: heigth * 0.02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      dataInter.logo!,
                      height: heigth * 0.12,
                      width: width * 0.21,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset("assets/icons/fils.png"),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        dataInter.name,
                        color: getTheme() ? white : Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: heigth * 0.01),
                      DefaultText(
                        dataInter.description,
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        color: textColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: heigth * 0.01),

                      Row(
                        children: [
                          
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/products_icons.svg",
                              ),
                              SizedBox(width: width * 0.01),
                              DefaultText(
                                "${dataInter.productsCount}  ${"Products".tr()}",
                                color: textColor,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.01),

                          Spacer(),
                          Expanded(
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(
                                getLang() == 'ar' ? 0 : pi,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  height: 15,
                                  "assets/icons/mynaui_arrow-up-solid.svg",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
