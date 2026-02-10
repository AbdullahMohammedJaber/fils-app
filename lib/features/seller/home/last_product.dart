// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';

import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product/item_product_seller.dart';

class LastProductSeller extends StatelessWidget {
  const LastProductSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeSellerCubit, HomeSellerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Row(
                children: [
                  DefaultText(
                    "Last My Product".tr(),
                    color: getTheme() ? white : blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.05),
              if (state is HomeSuccessSeller)
                state.homeResponse.data.bestProducts.isEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText(
                          "There are no products yet,".tr(),
                          color: getTheme() ? white : textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(width: 2),
                        GestureDetector(
                          onTap: () async {
                            if (getPackageInfo() == null) {
                              context.read<ShopsCubit>().getAllShops();
                            } else if (getMyShopsDetails().id == 0) {
                              showMessage(
                                "Please Select your Shop".tr(),
                                value: false,
                              );
                            } else {
                              ToWithFade(AppRoutes.formAddProduct);
                            }
                          },
                          child: DefaultText(
                            "add products".tr(),
                            color: primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                    : Container(
                      alignment: AlignmentDirectional.centerStart,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: List.generate(
                            state.homeResponse.data.bestProducts.length,
                            (index) => ProductItemWidget2(
                              productListModel:
                                  state.homeResponse.data.bestProducts[index],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
