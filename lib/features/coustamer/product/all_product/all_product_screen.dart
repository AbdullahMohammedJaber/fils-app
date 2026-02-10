import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/product/product_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/const.dart';
import '../../../../utils/widget/grid_view_custom.dart';
import '../general_product.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    context.read<ProductCubit>().fetch(refresh: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: heigth * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ItemTitleBar(title: "All Product".tr(), canBack: true),
          ),
          SizedBox(height: heigth * 0.001),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return context.read<ProductCubit>().fetch(refresh: true);
              },
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductAllLoading) {
                    return LoadingUi();
                  } else if (state is ProductAllError) {
                    return NeonNoInternetView(
                      onRetry: () {
                        context.read<ProductCubit>().fetch(refresh: true);
                      },
                      error: state.error.tr(),
                    );
                  } else if (state is ProductAllLoaded) {
                    final products = state.items;
                    if (state.items.isEmpty) {
                      return EmptyDataScreen(
                        
                      );
                    } else {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scroll) {
                          if (scroll.metrics.pixels >=
                                  scroll.metrics.maxScrollExtent - 200 &&
                              state.hasMore) {
                            context.read<ProductCubit>().fetch();
                          }
                          return false;
                        },
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount:
                              state.hasMore
                                  ? products.length + 1
                                  : products.length,
                          itemBuilder: (_, index) {
                            if (index == products.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: LoadingUi()),
                              );
                            }

                            return ProductItemWidget(
                              false,
                              productListModel: products[index],
                              isAuction: false,
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1,
                                height: heigth * 0.42,
                                mainAxisSpacing: 2,
                              ),
                        ),
                      );
                    }
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
