import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/haraj/widget_haraj.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/features/seller/product/item_product_seller.dart';

import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/widget/grid_view_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSellerScreen extends StatefulWidget {
  const ProductSellerScreen({super.key});

  @override
  State<ProductSellerScreen> createState() => _ProductSellerScreenState();
}

class _ProductSellerScreenState extends State<ProductSellerScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductSellerCubit>().getAllProduct(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<ProductSellerCubit>().getAllProduct(
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
                  Expanded(child: ItemTitleBar(title: "My Product".tr())),
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
                        ToWithFade(AppRoutes.formAddProduct);
                      }
                    },
                  ),
                  SizedBox(width: width * 0.02),
                ],
              ),
              SizedBox(width: width, height: heigth * 0.02),
              Expanded(
                child: BlocBuilder<ProductSellerCubit, ProductSellerState>(
                  builder: (context, state) {
                    if (state.loadingGetAllProduct) {
                      return LoadingUi();
                    } else if (state.error != null) {
                      return NeonNoInternetView(
                        onRetry: () {
                          context.read<ProductSellerCubit>().getAllProduct(
                            refresh: true,
                          );
                        },
                        error: state.error!,
                      );
                    } else {
                      final product = state.products;

                      if (product.isEmpty) {
                        return EmptyDataScreen();
                      } else {
                        return NotificationListener<ScrollNotification>(
                          onNotification: (scroll) {
                            if (scroll.metrics.pixels >=
                                    scroll.metrics.maxScrollExtent - 200 &&
                                state.hasMore) {
                              context
                                  .read<ProductSellerCubit>()
                                  .getAllProduct();
                            }
                            return false;
                          },
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                  crossAxisCount: 2,
                                  height: heigth * 0.35,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                            itemBuilder: (context, index) {
                              if (index == product.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(child: LoadingUi()),
                                );
                              } else {
                                return ProductItemWidget(
                                  productListModel: product[index],
                                );
                              }
                            },
                            itemCount:
                                state.hasMore
                                    ? product.length + 1
                                    : product.length,
                          ),
                        );
                      }
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
