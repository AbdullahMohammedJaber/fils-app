import 'package:cached_network_image/cached_network_image.dart';
import 'package:fils/core/data/response/cart/cart_list_response.dart';
import 'package:fils/features/coustamer/cart/slidable_widget.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/widget/defulat_text.dart';

import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';

import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemProductCart extends StatelessWidget {
  final dynamic index;
  final CartItem cartItem;
  final bool isAuction;

  const ItemProductCart(this.index, this.cartItem, this.isAuction, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<CartCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: heigth * 0.15,
            width: width,
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: getTheme() ? Colors.black : const Color(0xffFAFAFA),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Slidable(
              direction: Axis.horizontal,
              enabled: true,
              closeOnScroll: true,
              key: ValueKey(index),
              startActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  Expanded(
                    child: CustomSlideAction(
                      color: const Color(0xffF1673C),
                      imagePath: "assets/icons/delete.svg",
                      loading: state.loadingDeleteCart,
                      onTap: () async {
                        context.read<CartCubit>().deleteItemCart(cartItem.id);
                      },
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 0.17,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: cartItem.productThumbnailImage,
                          placeholder: (context, url) => const LoadingUi(),
                          errorWidget:
                              (context, url, error) =>
                                  Image.asset("assets/images/fils_logo_f.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            cartItem.shopName,
                            color: getTheme() ? white : textColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: heigth * 0.01),
                          DefaultText(
                            cartItem.productName,
                            color: getTheme() ? white : blackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: heigth * 0.01),
                          isAuction
                              ? const SizedBox()
                              : Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.minusCountItem(
                                        oldQuantity: cartItem.quantity,
                                        newQuantity: cartItem.quantity - 1,
                                        id: cartItem.id,
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: DefaultText(
                                          "-",
                                          fontSize: 12,
                                          color: textColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: const Color(0xff898384),
                                      ),
                                    ),
                                    child: Center(
                                      child: DefaultText(
                                        cartItem.quantity.toString(),
                                        fontSize: 12,
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  GestureDetector(
                                    onTap: () {
                                      controller.plusCountItem(
                                        oldQuantity: cartItem.quantity,
                                        newQuantity: cartItem.quantity + 1,
                                        id: cartItem.id,
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.transparent,
                                      ),
                                      child: Center(
                                        child: DefaultText(
                                          "+",
                                          fontSize: 12,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(), 
                                  DefaultText(
                                    "${cartItem.price} ${StringApp.currency} ",
                                    color: primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
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
      },
    );
  }
}
