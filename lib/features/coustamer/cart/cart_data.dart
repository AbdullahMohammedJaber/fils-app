import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/cart/cart_empty.dart';
import 'package:fils/features/coustamer/cart/cart_full.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartData extends StatelessWidget {
  const CartData({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        if (state.loadingCart) {
          return LoadingUi();
        } else if (state.cartListResponse != null) {
          return checkCart(state);
        } else if (state.cartListResponse == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                DefaultText(StringApp.noInternet.tr()),
                IconButton(
                  onPressed: () {
                    context.read<CartCubit>().getCart();
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget checkCart(CartState state) {
    if (state.cartListResponse!.data.isEmpty) {
      return CartEmptyScreen();
    } else {
      if (state.cartListResponse!.data[0].cartItems.isEmpty) {
        return CartEmptyScreen();
      } else {
        return CartFull();
      }
    }
  }
}
