import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class CartTabBar extends StatelessWidget {
  const CartTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: grey3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.06,
              vertical: 5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<CartCubit>().functionChangeTapBar(1);
                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                            state.pageTabBar == 1
                                ? secondColor
                                : getTheme()
                                ? Colors.black
                                : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Online Product".tr(),
                          color:
                          state.pageTabBar == 1
                          ? white
                          : getTheme()
                          ? white
                          :
                              blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                       context.read<CartCubit>().functionChangeTapBar( 2);
                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:
                        state.pageTabBar == 2
                        ? secondColor
                        : getTheme()
                        ? Colors.black
                        :
                            white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Auctions".tr(),
                          color:
                          state.pageTabBar == 2
                          ? white
                          : getTheme()
                          ? white
                          :
                              blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
