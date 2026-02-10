import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/detail_product/details_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/response/product/details_product_response.dart';
import '../../../../utils/const.dart';
import '../../../../utils/theme/color_manager.dart';
import '../../../../utils/widget/defulat_text.dart';

class SectionCountAddCart extends StatelessWidget {
  final ProductData details;

  const SectionCountAddCart({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsProductCubit, DetailsProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<DetailsProductCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DefaultText(
                    "Number of quantity".tr(),
                    fontSize: 14,
                    color: const Color(0xff5A5555),
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: width * 0.02),
                  DefaultText(
                    "How many do you want?".tr(),
                    fontSize: 8,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
              SizedBox(height: heigth * 0.02),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (details.variantProduct == 1) {
                        if (state.nameVariant != null) {
                          controller.functionMinusCountProduct();
                        } else {
                          showMessage(
                            "Please Select option".tr(),
                            value: false,
                          );
                        }
                      } else {
                        controller.functionMinusCountProduct();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xff898384)),
                      ),
                      child: Center(
                        child: DefaultText(
                          "-",
                          fontSize: 28,
                          color: textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xff898384)),
                    ),
                    child: Center(
                      child: DefaultText(
                        controller.countProduct.toString(),
                        fontSize: 20,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  GestureDetector(
                    onTap: () {
                      if (details.variantProduct == 1) {
                        if (state.nameVariant != null) {
                          controller.functionPlusCountProduct();
                        } else {
                          showMessage(
                            "Please Select option".tr(),
                            value: false,
                          );
                        }
                      } else {
                        controller.functionPlusCountProduct();
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor,
                      ),
                      child: Center(
                        child: DefaultText(
                          "+",
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
