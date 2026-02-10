import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/haraj/widget_haraj.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/auction/item_auction_seller.dart';
import 'package:fils/managment/auction/auction_seller_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuctionSeller extends StatefulWidget {
  const AuctionSeller({super.key});

  @override
  State<AuctionSeller> createState() => _AuctionSellerState();
}

class _AuctionSellerState extends State<AuctionSeller> {
  @override
  void initState() {
    super.initState();
    context.read<AuctionSellerCubit>().fetchAllAuction(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<AuctionSellerCubit>().fetchAllAuction(
              refresh: true,
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: width, height: heigth * 0.02),
              Row(
                children: [
                  Expanded(child: ItemTitleBar(title: "My Auction".tr())),
                  FloatingAddProductWidget(
                    onTap: () {
                      if (getPackageInfo() == null) {
                        context.read<ShopsCubit>().getAllShops();
                      } else if (getMyShopsDetails().id == 0) {
                        showMessage(
                          "Please Select your Shop".tr(),
                          value: false,
                        );
                      } else {
                        ToWithFade(AppRoutes.formAddAuctionSeller);
                      }
                    },
                  ),
                  SizedBox(width: width * 0.02),
                ],
              ),
              SizedBox(width: width, height: heigth * 0.02),
              Expanded(
                child: BlocBuilder<AuctionSellerCubit, AuctionSellerState>(
                  builder: (context, state) {
                    if (state.loading) {
                      return LoadingUi();
                    } else if (state.error != null) {
                      return NeonNoInternetView(
                        onRetry: () {
                          context.read<AuctionSellerCubit>().fetchAllAuction(
                            refresh: true,
                          );
                        },
                        error: state.error!,
                      );
                    } else {
                      if (state.auctions != null) {
                        if (state.auctions!.isEmpty) {
                          return EmptyDataScreen();
                        } else {
                          final auction = state.auctions;
                          return NotificationListener<ScrollNotification>(
                            onNotification: (scroll) {
                              if (scroll.metrics.pixels >=
                                      scroll.metrics.maxScrollExtent - 200 &&
                                  state.hasMore) {
                                context
                                    .read<AuctionSellerCubit>()
                                    .fetchAllAuction();
                              }
                              return false;
                            },
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                if (index == auction.length) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Center(child: LoadingUi()),
                                  );
                                } else {
                                  return ItemAuctionSeller(
                                    datum: auction[index],
                                  );
                                }
                              },
                              itemCount:
                                  state.hasMore
                                      ? auction!.length + 1
                                      : auction!.length,
                            ),
                          );
                        }
                      }
                      return SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
