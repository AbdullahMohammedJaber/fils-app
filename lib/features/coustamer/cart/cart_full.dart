import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/request/order/order_request.dart';
import 'package:fils/features/coustamer/cart/cart_item.dart';
import 'package:fils/features/coustamer/cart/item_analyze_price_cart.dart';
import 'package:fils/features/coustamer/cart/item_delivery_methode.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/widget/defulat_text.dart';

class CartFull extends StatelessWidget {
  const CartFull({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<CartCubit>().getCart();
      },
      child: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heigth * 0.02),
           
                for (
                  dynamic i = 0;
                  i < state.cartListResponse!.data.length;
                  i++
                )
                  ...List.generate(
                    state.cartListResponse!.data[i].cartItems.length,
                    (index) {
                        return ItemProductCart(
                          index,
                          state.cartListResponse!.data[i].cartItems[index],
                          state.pageTabBar == 1 ? false : true,
                        );
                    },
                  ),
                SizedBox(height: heigth * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DefaultText(
                    "Add delivery methodes".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff5A5555),
                  ),
                ),
                SizedBox(height: heigth * 0.01),
                ItemDeliveryMethod(),
                SizedBox(height: heigth * 0.04),
                const ItemAnalyzePriceCart(),
                SizedBox(height: heigth * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      DefaultText(
                        "${state.cartListResponse!.order_amount} ${StringApp.currency.tr()} ",
                        color: secondColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: width * 0.05),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (!context
                                .read<CartCubit>()
                                .key
                                .currentState!
                                .validate()) {
                            } else {
                              context.read<CartCubit>().validateCart(
                                OrderRequest(
                                  name: "name",
                                  email: "email",
                                  phone: "phone",
                                  address: "address",
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: orange,
                            ),
                            child:
                                state.loadingValidateCart
                                    ? LoadingUi()
                                    : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        DefaultText(
                                          "Check out".tr(),
                                          fontSize: 14,
                                          color: white,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: heigth * 0.08),
              ],
            ),
          );
        },
      ),
    );
  }
}
