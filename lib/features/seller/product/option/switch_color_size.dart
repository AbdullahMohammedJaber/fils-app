import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget switchColorSizeWidget(BuildContext context) {
  return BlocConsumer<ProductSellerCubit, ProductSellerState>(
    listener: (context, state) {
  
    },
    builder: (context, state) {
      return Container(
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffE9E9E9)),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  DefaultText(
                    "Color".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                  const Spacer(),
                  Switch(value: state.selectColor, onChanged: (value) {
                      context.read<ProductSellerCubit>().changeTyoeSelectColor(value);
                  }),
                ],
              ),
              SizedBox(height: heigth * 0.02),
              Row(
                children: [
                  DefaultText(
                    "Size".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                  const Spacer(),
                   Switch(value: state.selectSize, onChanged: (value) {
                      context.read<ProductSellerCubit>().changeTyoeSelectSize(value);
                  }),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
