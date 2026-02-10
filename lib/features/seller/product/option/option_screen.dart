import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/product/option/color_list.dart';
import 'package:fils/features/seller/product/option/size_list.dart';
import 'package:fils/features/seller/product/option/switch_color_size.dart';
import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';

import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductSellerCubit, ProductSellerState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: heigth * 0.086),
                  ItemTitleBar(title: "Option".tr(), canBack: true),
                  SizedBox(height: heigth * 0.05),
                  DefaultText(
                    "Options".tr(),
                    color: blackColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: heigth * 0.02),
                  switchColorSizeWidget(context),
                  state.selectColor ? const ColorList() : const SizedBox(),
                  state.selectSize ? const SizeList() : const SizedBox(),
                  SizedBox(height: heigth * 0.12),
                ],
              ),
            ),
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              onTap: () {
                Navigator.pop(context);
              },
              title: "Done".tr(),
            ),
          ),
        );
      },
    );
  }
}
