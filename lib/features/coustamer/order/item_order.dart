// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/order/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';

import '../../../core/data/response/order/order_response.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class ItemOrder extends StatefulWidget {
  final Orders orders;
  final bool isCancel;
  final dynamic status;
  final int index;
  const ItemOrder({
    super.key,
    required this.orders,
    this.isCancel = false,
    required this.status,
   required this.index , 
  });

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit , OrderState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
             context.read<OrderCubit>().changeShowDetailsOrder(widget.index, widget.orders);
             
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xffFAFAFA),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                children: [
                  SizedBox(width: width * 0.015),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DefaultText(
                                "# ${widget.orders.code}",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: heigth * 0.005),
                        Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/quantity.svg"),
                                SizedBox(width: width * 0.015),
                                DefaultText(
                                  "Quantity : ".tr() + "${widget.orders.products.length}",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ],
                            ),
                            SizedBox(width: width * 0.03),
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/man_delivery.svg"),
                                SizedBox(width: width * 0.015),
                                DefaultText(
                                  "Delivery : 3 ",
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: heigth * 0.008),
                        Row(
                          children: [
                            DefaultText(
                              widget.orders.date,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                            SizedBox(width: width * 0.03),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 4,
                                  backgroundColor:
                                      widget.status == 1
                                          ? Colors.orange
                                          : widget.status == 2
                                          ? Colors.green
                                          : Colors.red,
                                ),
                                SizedBox(width: width * 0.01),
                                DefaultText(
                                  widget.status == 1
                                      ? "in Progress".tr()
                                      : widget.status == 2
                                      ? "Completed".tr()
                                      : widget.status == 3
                                      ? "Canceled".tr()
                                      : "Un Paid".tr(),
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DefaultText(
                        widget.orders.grandTotal,
                        color: secondColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        );
      }, listener: (BuildContext context, OrderState state) {  },
    );
  }
}
