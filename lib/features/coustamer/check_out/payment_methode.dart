import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/cart/item_analyze_price_cart.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethode extends StatefulWidget {
  const PaymentMethode({super.key});

  @override
  State<PaymentMethode> createState() => _PaymentMethodeState();
}

class _PaymentMethodeState extends State<PaymentMethode> {
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: heigth * 0.05),
                ItemTitleBar(title: "Payment methods".tr(), canBack: true),
                SizedBox(height: heigth * 0.05),
                ...List.generate(state.paymentMethodResponse!.data.length, (
                  index,
                ) {
                  return GestureDetector(
                    onTap: () {
                      context.read<CartCubit>().selectPaymentMethode(
                        state.paymentMethodResponse!.data[index].paymentTypeKey,
                      );
                    },
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color:
                            getTheme() ? Colors.black : const Color(0xffFAFAFA),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              state.paymentMethodResponse!.data[index].isSelect
                                  ? orange
                                  : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            width: 50,
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    state
                                            .paymentMethodResponse!
                                            .data[index]
                                            .isSelect
                                        ? orange
                                        : Colors.grey.shade300,
                              ),
                            ),
                            child: Image.network(
                              state.paymentMethodResponse!.data[index].image,
                              fit: BoxFit.cover,
                            ),
                          ),
                          DefaultText(
                            state.paymentMethodResponse!.data[index].name,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: const Color(0xff898384),
                              ),
                            ),
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    state.paymentMethodResponse!
                                            .data[index]
                                            .paymentTypeKey ==
                                        state.paymentMethode?.paymentTypeKey
                                        ? primaryDarkColor
                                        : Colors.transparent,
                              ),
                              margin: const EdgeInsets.all(2),
                            ),
                          ),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(height: heigth * 0.05),
                const ItemAnalyzePriceCart(),
                SizedBox(height: heigth * 0.1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      DefaultText(
                        "${state.cartListResponse!.order_amount} KWD",
                        color: secondColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: width * 0.05),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            if (state.paymentMethode == null) {
                              showMessage(

                                "Please Select Payment Methode".tr(),
                                value: false,
                              );
                              return;
                            }

                            context.read<CartCubit>().createOrder();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: secondColor,
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
          ),
        );
      },
    );
  }
}
