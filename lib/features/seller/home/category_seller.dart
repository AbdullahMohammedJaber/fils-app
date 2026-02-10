// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/seller/report/repordt_screen.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';

class CategorySectionSeller extends StatefulWidget {
  const CategorySectionSeller({super.key});

  @override
  State<CategorySectionSeller> createState() => _CategorySectionSellerState();
}

class _CategorySectionSellerState extends State<CategorySectionSeller> {
  final List<CustomButton> lista = [
    CustomButton(
      label: 'Wallet'.tr(),
      color: secondColor.withOpacity(0.2),
      path: "assets/icons/wallet_seller.svg",
      dec:
          "You can easily deposit and withdraw your profits and sales from the wallet section."
              .tr(),
    ),
    CustomButton(
      label: 'Subscriptions'.tr(),
      color: purpleColor.withOpacity(0.2),
      path: "assets/icons/subscription.svg",
      dec:
          "As a seller, you must subscribe to a package to enjoy the app's features, such as adding products and auctions. Choose the package according to your specific needs."
              .tr(),
    ),
    CustomButton(
      label: 'Reports'.tr(),
      color: Colors.orange.withOpacity(0.2),
      path: "assets/icons/subscription.svg",
      dec:
          "You can download your sales and purchase reports from here to easily see your incoming and outgoing transactions in your account."
              .tr(),
    ),
    CustomButton(
      label: 'Add Product'.tr(),
      color: kohliH.withOpacity(0.2),
      path: "assets/icons/product.svg",
      dec:
          "You can download your sales and purchase reports from here to easily see your incoming and outgoing transactions in your account."
              .tr(),
    ),
    CustomButton(
      label: 'Add Auction'.tr(),
      color: zaherH.withOpacity(0.2),
      path: "assets/icons/auction_nav.svg",
      dec:
          "You can download your sales and purchase reports from here to easily see your incoming and outgoing transactions in your account."
              .tr(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: heigth * 0.01),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.start,
          children: List.generate(lista.length, (index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  ToWithFade(AppRoutes.walletSeller);
                }
                if (index == 1) {
                  ToWithFade(AppRoutes.subscriptionsScreen);
                }
                if (index == 2) {
                  if (context.read<HomeSellerCubit>().reportList.isEmpty) {
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CustomBarChart(
                            data: context.read<HomeSellerCubit>().reportList,
                          );
                        },
                      ),
                    );
                  }
                }
                if (index == 3) {
                  if (getPackageInfo() == null) {
                    context.read<ShopsCubit>().whenCreateStore();
                  } else if (getMyShopsDetails().id == 0) {
                    showMessage("Please Select your Shop".tr(), value: false);
                  } else {
                    ToWithFade(AppRoutes.formAddProduct);
                  }
                }

                if (index == 4) {
                  if (getPackageInfo() == null) {
                    context.read<ShopsCubit>().whenCreateStore();
                  } else if (getMyShopsDetails().id == 0) {
                    showMessage("Please Select your Shop".tr(), value: false);
                  } else {
                    ToWithFade(AppRoutes.formAddAuctionSeller);
                  }
                }
              },
              child: lista[index],
            );
          }),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final Color color;
  final String path;
  final String dec;

  const CustomButton({
    super.key,
    required this.label,
    required this.color,
    required this.path,
    required this.dec,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Center(child: SvgPicture.asset(path, width: 20, height: 20)),
        ),
        const SizedBox(width: 8),
        DefaultText(label.tr(), color: getTheme() ? white : Colors.black),
      ],
    );
  }
}
