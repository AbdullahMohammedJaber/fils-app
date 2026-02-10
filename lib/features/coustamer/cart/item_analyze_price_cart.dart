import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/defulat_text.dart';

import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemAnalyzePriceCart extends StatelessWidget {
  const ItemAnalyzePriceCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},

      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.07),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffE8E2F8)),
              color: getTheme() ? Colors.black : const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                SizedBox(height: heigth * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      DefaultText(
                        "Order Amount".tr(),
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      DefaultText(
                        "${state.cartListResponse!.grandTotal} ${StringApp.currency.tr()}"
                            .tr(),
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      DefaultText(
                        "Delivery Quote".tr(),
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      DefaultText(
                        "${state.cartListResponse!.shipping_cost} ${StringApp.currency.tr()}"
                            .tr(),
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
               /* Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      DefaultText(
                        "Application rate".tr(),
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      *//* DefaultText(
                            "${cart.tax} ${StringApp.currency.tr()}".tr(),
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),*//*
                    ],
                  ),
                ),*/
                const Divider(thickness: 1),
                SizedBox(height: heigth * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      DefaultText(
                        "Total".tr(),
                        color: blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      DefaultText(
                        "${state.cartListResponse!.order_amount}${StringApp.currency.tr()}"
                            .tr(),
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heigth * 0.02),
              ],
            ),
          ),
        );
      },
    );
  }
}
