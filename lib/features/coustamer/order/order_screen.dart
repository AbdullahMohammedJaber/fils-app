import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/order/tapbar_item_order.dart';
import 'package:fils/features/coustamer/order/traking_screen.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/order/order_cubit.dart';
import 'package:fils/utils/setting_ui/no_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

import '../../../utils/const.dart';
import '../../../utils/setting_ui/loading_ui.dart';
import '../../../utils/setting_ui/no_internet_ui.dart';
  
import 'item_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
   
    super.initState();
    context.read<OrderCubit>().getOrder(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
         return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: heigth * 0.05),
                ItemTitleBar(title: "My Order".tr(), canBack: true),
                SizedBox(height: heigth * 0.05),
                TapBarOrderItem(),
                SizedBox(height: heigth * 0.05),
                Expanded(
                  child: BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      if (state.loading) {
                        return LoadingUi();
                      } else if (state.error != null) {
                        return NeonNoInternetView(
                          onRetry: () {
                            context.read<OrderCubit>().getOrder(refresh: true);
                          },
                          error: state.error!,
                        );
                      } else if (state.orderList != null) {
                        final orders = state.orderList;
                        if (orders!.isEmpty) {
                          return EmptyDataScreen(
                             
                          );
                        } else {
                          return NotificationListener<ScrollNotification>(
                            onNotification: (scroll) {
                              if (scroll.metrics.pixels >=
                                      scroll.metrics.maxScrollExtent - 200 &&
                                  state.hasMore) {
                                context.read<OrderCubit>().getOrder();
                              }
                              return false;
                            },
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                if (index == orders.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(child: LoadingUi()),
                                  );
                                }
                                return Column(
                                  children: [
                                    ItemOrder(
                                      orders: orders[index],
                                      status: state.pageTapBar,
                                    ),
                                    orders[index].isShow
                                        ? TrackingScreen(
                                          itineraries: orders[index].products,
                                          date: orders[index].date,
                                        )
                                        : const SizedBox(),
                                  ],
                                );
                              },

                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  state.hasMore
                                      ? orders.length + 1
                                      : orders.length,
                            ),
                          );
                        }
                      } else {
                        return SizedBox();
                      }
                    },
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
