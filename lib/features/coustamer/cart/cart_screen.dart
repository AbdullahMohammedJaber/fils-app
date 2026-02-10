import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/cart/cart_data.dart';
import 'package:fils/features/coustamer/cart/cart_tab_bar.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/const.dart';
 import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: heigth * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: width * 0.5,
              child: DefaultText(
                "My Cart".tr(),
                color: const Color(0xff042D5C),
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: heigth * 0.03),
          const CartTabBar(),
          Expanded(child: CartData()),
        ],
      ),
    );
  }
}
