// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

import '../../../core/data/response/order/order_response.dart';
import '../../../utils/widget/defulat_text.dart';

class TrackingScreen extends StatelessWidget {
  final List<Product> itineraries;
  final String date;

  const TrackingScreen({
    super.key,
    required this.itineraries,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ListView.builder(
          itemCount: itineraries.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          itemBuilder: (context, index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    if (index != itineraries.length)
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
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xffFAFAFA),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: heigth * 0.07,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.all(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                itineraries[index].thumbnailImage!,
                                placeholder:
                                    (context, url) => LoadingUi(),
                                errorWidget:
                                    (context, url, error) => Image.asset(
                                  "assets/test/abaya.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.015),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultText(
                                  itineraries[index].shopName,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  color: textColor,
                                ),
                                SizedBox(height: heigth * 0.005),
                                DefaultText(
                                  itineraries[index].productName,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: blackColor,
                                ),
                                SizedBox(height: heigth * 0.005),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/quantity.svg",
                                        ),
                                        SizedBox(width: width * 0.015),
                                        DefaultText(
                                          "Quantity : ".tr() +
                                              "${itineraries[index].quantity}",
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                          color: textColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/man_delivery.svg",
                                        ),
                                        SizedBox(width: width * 0.015),
                                        DefaultText(
                                          "Delivery".tr(),
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
                                      date,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: textColor,
                                    ),
                                    SizedBox(width: width * 0.03),

                                  ],
                                ),
                              ],
                            ),
                          ),
                          DefaultText(
                            itineraries[index].price,
                            color: secondColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
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
}
