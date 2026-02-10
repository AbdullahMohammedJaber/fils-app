// ignore_for_file: use_build_context_synchronously

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/seller/home/app_bar_home.dart';
import 'package:fils/features/seller/home/category_seller.dart';
import 'package:fils/features/seller/home/last_auction.dart';
import 'package:fils/features/seller/home/last_product.dart';
import 'package:fils/features/seller/shops/show_shops_widget.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
 
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSeller extends StatefulWidget {
  const HomeSeller({super.key});

  @override
  State<HomeSeller> createState() => _HomeSellerState();
}

class _HomeSellerState extends State<HomeSeller> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
      context.read<HomeSellerCubit>().getHomeSelerRequest();
      context.read<ShopsCubit>().getAllShops();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, automaticallyImplyLeading: false),
      body: BlocBuilder<HomeSellerCubit, HomeSellerState>(
        builder: (context, state) {
          if (state is HomeLoadingSeller) {
            return LoadingUi();
          } else if (state is HomeNoInternetSeller) {
            return NeonNoInternetView(
              onRetry: () {
                 context.read<HomeSellerCubit>().getHomeSelerRequest();
              },
              error: StringApp.noInternet,
            );
          } else if (state is HomeUnknownErrorSeller) {
            return NeonNoInternetView(onRetry: () {
               context.read<HomeSellerCubit>().getHomeSelerRequest();
            }, error: state.error);
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: heigth * 0.01),
                AppBarHomeSeller(),
                SizedBox(height: heigth * 0.01),
            
                BlocConsumer<ShopsCubit, ShopsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var controller = context.read<ShopsCubit>();
                    if (state.shopsResponse == null && state.isLoading) {
                      return LoadingUi();
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SelectShopDropdown(
                        items:
                            state.shopsResponse != null
                                ? state.shopsResponse!.data.data
                                : [],
                        onChanged: (item) {
                          setMyShopsDetails(item);
                          controller.getInfoPakage();
                        },
                        onAddNewShop: (){
                           ToWithFade(AppRoutes.formShop);
                        },
                        hint:
                            getMyShopsDetails().id == 0
                                ? "Please Select your Shop".tr()
                                : getMyShopsDetails().name,
                      ),
                    );
                  },
                ),
                SizedBox(height: heigth * 0.03),
                CategorySectionSeller(),
                SizedBox(height: heigth * 0.05),
                LastProductSeller(),
                SizedBox(height: heigth * 0.03),
                LastAuctionSeller(),
                SizedBox(height: heigth * 0.05),
              ],
            ),
          );
        },
      ),
    );
  }
}
