import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/order/order_seller_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
 import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OrderSeller extends StatefulWidget {
  const OrderSeller({super.key});

  @override
  State<OrderSeller> createState() => _OrderSellerState();
}

class _OrderSellerState extends State<OrderSeller> {
  @override
  void initState() {
    context.read<OrderSellerCubit>().getOrders(refresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: width, height: heigth * 0.02),

            ItemTitleBar(title: "My Order".tr()),
            SizedBox(height: heigth * 0.04),
            Expanded(
              child: BlocBuilder<OrderSellerCubit, OrderSellerState>(
                builder: (context, state) {
                  if (state.loading) {
                    return LoadingUi();
                  } else if (state.error != null) {
                    return NeonNoInternetView(
                      onRetry: () {
                        context.read<OrderSellerCubit>().getOrders(
                          refresh: true,
                        );
                      },
                      error: state.error!,
                    );
                  } else if (state.listOrder != null) {
                    if (state.listOrder!.isEmpty) {
                      return EmptyDataScreen();
                    } else {
                      final order = state.listOrder;
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scroll) {
                          if (scroll.metrics.pixels >=
                                  scroll.metrics.maxScrollExtent - 200 &&
                              state.hasMore) {
                            context.read<OrderSellerCubit>().getOrders();
                          }
                          return false;
                        },
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (index == order.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: LoadingUi()),
                              );
                            } else {
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        order[index].isShow = !order[index].isShow;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        bottom: 10,
                                        top: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: const Color(0xffFAFAFA),
                                        border: Border.all(color: textColor),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(width: width * 0.015),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: DefaultText(
                                                              "# ${order[index].code}",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: blackColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: heigth * 0.005,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/icons/quantity.svg",
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width *
                                                                    0.015,
                                                              ),
                                                              DefaultText(
                                                                "${"Quantity : ".tr()}${order[index].products!.length}",
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    textColor,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.03,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                "assets/icons/man_delivery.svg",
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width *
                                                                    0.015,
                                                              ),
                                                              DefaultText(
                                                                "Delivery : 3 ",
                                                                fontSize: 8,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    textColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: heigth * 0.008,
                                                      ),
                                                      Row(
                                                        children: [
                                                          DefaultText(
                                                            order[index].date,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: textColor,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.03,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(),
                                                    const SizedBox(height: 5),
                                                    DefaultText(
                                                      order[index].grandTotal,
                                                      color: secondColor,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),

                                            SizedBox(
                                              width: 100,
                                              child: ButtonWidget(
                                                colorButton: primaryColor,
                                                colorTitle: white,
                                                heightButton: 30,
                                                onTap: () {
                                                  ToWithFade(AppRoutes.shippingAdress , arguments: order[index].id);
                                                },
                                                title: "Sipping".tr(),
                                                radius: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (order[index].isShow)
                                    ListView.builder(
                                      itemCount: order[index].products!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 8,
                                                  height: 8,
                                                  decoration: BoxDecoration(
                                                    color: secondColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                if (index !=
                                                    order[index]
                                                        .products!
                                                        .length)
                                                  Container(
                                                    width: 1.3,
                                                    height: 80,
                                                    color: primaryColor,
                                                  ),
                                              ],
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Container(
                                                height: heigth * 0.14,
                                                margin: const EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: const Color(
                                                    0xffFAFAFA,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 0,
                                                      ),
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        child: Container(
                                                          height: heigth * 0.07,
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  12,
                                                                ),
                                                          ),
                                                          margin:
                                                              const EdgeInsets.all(
                                                                10,
                                                              ),
                                                          child: CachedNetworkImage(
                                                            imageUrl:
                                                                order[index]
                                                                    .products![index]
                                                                    .thumbnailImage!,
                                                            placeholder:
                                                                (
                                                                  context,
                                                                  url,
                                                                ) =>
                                                                    LoadingUi(),
                                                            errorWidget:
                                                                (
                                                                  context,
                                                                  url,
                                                                  error,
                                                                ) => Image.asset(
                                                                  "assets/test/abaya.png",
                                                                  fit:
                                                                      BoxFit
                                                                          .cover,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: width * 0.015,
                                                      ),
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            DefaultText(
                                                              order[index]
                                                                  .products![index]
                                                                  .shopName,
                                                              fontSize: 8,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: textColor,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  heigth *
                                                                  0.005,
                                                            ),
                                                            DefaultText(
                                                              order[index]
                                                                  .products![index]
                                                                  .productName,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: blackColor,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  heigth *
                                                                  0.005,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    SvgPicture.asset(
                                                                      "assets/icons/quantity.svg",
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                          0.015,
                                                                    ),
                                                                    DefaultText(
                                                                      "${"Quantity : ".tr()}${order[index].products![index].quantity}",
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          textColor,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width *
                                                                      0.03,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SvgPicture.asset(
                                                                      "assets/icons/man_delivery.svg",
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                          0.015,
                                                                    ),
                                                                    DefaultText(
                                                                      "Delivery"
                                                                          .tr(),
                                                                      fontSize:
                                                                          8,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color:
                                                                          textColor,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  heigth *
                                                                  0.008,
                                                            ),
                                                            Row(
                                                              children: [
                                                                DefaultText(
                                                                  order[index]
                                                                      .date,
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      textColor,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      width *
                                                                      0.03,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      DefaultText(
                                                        order[index]
                                                            .products![index]
                                                            .price,
                                                        color: secondColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      const SizedBox(width: 10),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                ],
                              );
                            }
                          },
                          itemCount:
                              state.hasMore ? order!.length + 1 : order!.length,
                        ),
                      );
                    }
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
