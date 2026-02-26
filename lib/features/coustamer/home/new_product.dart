// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

import '../../../route/control_route.dart';
import '../product/general_product.dart';

class ItemProductHome extends StatefulWidget {
  final HomeResponse homeResponse;

  const ItemProductHome({super.key, required this.homeResponse});

  @override
  State<ItemProductHome> createState() => _ItemProductHomeState();
}

class _ItemProductHomeState extends State<ItemProductHome> {
  final ScrollController _controller = ScrollController();
  late final Timer _timer;

  bool _isUserScrolling = false;
  final double _scrollStep = 150;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!_controller.hasClients) return;
      if (_isUserScrolling) return;

      final maxScroll = _controller.position.maxScrollExtent;
      final current = _controller.offset;

      if (current + _scrollStep <= maxScroll) {
        _controller.animateTo(
          current + _scrollStep,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
  
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12),
      child:
          widget.homeResponse.data!.newProducts.data!.isNotEmpty
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DefaultText(
                        "New Product".tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: getTheme() ? white : blackColor,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          ToWithFade(AppRoutes.allProductScreen);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DefaultText(
                            "See All".tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: heigth * 0.02),
                  SizedBox(
                    width: width,
                    child: SingleChildScrollView(
                      controller: _controller,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(

                          widget.homeResponse.data!.newProducts.data!.length,
                          (index) => Padding(
                            padding: EdgeInsetsDirectional.only(
                              end: width * 0.01,
                            ),
                            child: ProductItemWidget(
                              false,
                              isAuction: false,

                              productListModel:
                                  widget.homeResponse.data!.newProducts.data![index],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
              : const SizedBox(),
    );
  }
}
