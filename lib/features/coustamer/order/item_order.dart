// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';

import '../../../core/data/response/order/order_response.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class ItemOrder extends StatelessWidget {
  final Orders orders;
  final bool isCancel;
  final dynamic status;

  const ItemOrder({
    super.key,
    required this.orders,
    this.isCancel = false,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // order.changeShowDetailsOrder(orders);
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
                            "# ${orders.code}",
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
                              "Quantity : ".tr() + "${orders.products.length}",
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
                          orders.date,
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
                                  status == 1
                                      ? Colors.orange
                                      : status == 2
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            SizedBox(width: width * 0.01),
                            DefaultText(
                              status == 1
                                  ? "in Progress".tr()
                                  : status == 2
                                  ? "Completed".tr()
                                  : status == 3
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
                    orders.grandTotal,
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
  }
}
