// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
 import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
 import 'package:fils/utils/widget/grid_view_custom.dart';
import 'package:flutter/material.dart';
 import 'package:flutter_svg/svg.dart';

import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class ItemCategoryHome extends StatefulWidget {
  GlobalKey? keyG;

  ItemCategoryHome({super.key, this.keyG});

  @override
  State<ItemCategoryHome> createState() => _ItemCategoryHomeState();
}

class _ItemCategoryHomeState extends State<ItemCategoryHome> {
  @override
  void initState() {
    super.initState();
  }

  List<CustomButton> lista = [
    CustomButton(
      label: 'Online store'.tr(),
      color: orangeH,
      path: "assets/images/market.png",
      dec:
          "In the Market section, when you access it, you will find all the active stores within the application and shop from them easily."
              .tr(),
    ),
    CustomButton(
      label: 'Public auctions'.tr(),
      color: zaherH,
      path: "assets/images/auction.png",
      dec:
          "In the auction section, once you access it, you will find all the auctions and enjoy a distinctive, interactive, and secure bidding service."
              .tr(),
    ),
    CustomButton(
      label: 'Open Market'.tr(),
      color: kohliH,
      path: "assets/images/haraj.png",
      dec:
          "In the used goods section, you will find all used products, and you can purchase them by contacting the seller."
              .tr(),
    ),
 
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: widget.keyG,
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            "Sections".tr(),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: getTheme() ? white : blackColor,
          ),
          SizedBox(height: heigth * 0.02),
          Container(
            alignment: AlignmentDirectional.centerStart,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    height: heigth * 0.2,
                  ),
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    if (index == 0) {
                      ToWithFade(AppRoutes.allStoreScreen);
                    } else if (index == 1) {
                      ToWithFade(AppRoutes.auctionRoot);
                    } else if (index == 2) {
                      ToWithFade(AppRoutes.harajRoot);
                    }  
                  },
                  child: CustomButton(
                    label: lista[index].label,
                    color: lista[index].color,
                    path: lista[index].path,
                    dec: lista[index].dec,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String? label;
  final Color? color;
  final String? path;
  final String? dec;

  const CustomButton({
    super.key,
    required this.label,
    required this.color,
    required this.path,
    required this.dec,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color!, white, white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child:
                path!.endsWith('.png')
                    ? Image.asset(path!, height: 30)
                    : SvgPicture.asset(path!, height: 30),
          ),
        ),
        const SizedBox(height: 10),
        DefaultText(label!),
      ],
    );
  }
}
