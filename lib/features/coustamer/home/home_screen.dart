import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/features/coustamer/home/app_bar_home.dart';
import 'package:fils/features/coustamer/home/banner_ads.dart';
import 'package:fils/features/coustamer/home/category_section.dart';
import 'package:fils/features/coustamer/home/last_auction.dart';
import 'package:fils/features/coustamer/home/new_product.dart';
import 'package:fils/features/coustamer/home/suggest_product.dart';
import 'package:fils/features/coustamer/search/item_search.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../managment/home/home_cubit.dart';
import '../../../utils/const.dart';
 import 'last_shops.dart';

class HomeScreen extends StatelessWidget {
  final HomeResponse homeResponse;

  const HomeScreen({super.key, required this.homeResponse});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().getHomeRequest(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: heigth * 0.01),
                if(isLogin())
                AppBarHome(),
                SizedBox(height: heigth * 0.03),
                ItemSearch(),
                SizedBox(height: heigth * 0.03),
                BannerAdsScreen(),
                SizedBox(height: heigth * 0.03),
                ItemCategoryHome(),
                SizedBox(height: heigth * 0.01),
                if (homeResponse.data!.latestAuction != null)
                  LastAuctionHome(homeResponse: homeResponse),
                SizedBox(height: heigth * 0.02),
                ItemProductHome(homeResponse: homeResponse),
                SizedBox(height: heigth * 0.02),
                ItemShopHome(data: homeResponse),
               // SizedBox(height: heigth * 0.02),
               // ItemRelatedProductHome(data: homeResponse),
                SizedBox(height: heigth * 0.02),
                 SuggestProduct(),
                SizedBox(height: heigth * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
