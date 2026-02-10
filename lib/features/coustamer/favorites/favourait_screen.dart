import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/favorites/tap_bar_item.dart';
import 'package:fils/features/coustamer/product/general_product.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/favorites/favorites_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/widget/grid_view_custom.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      context.read<FavoritesCubit>().getListFavorites(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: heigth * 0.03),
            ItemTitleBar(title: "Favourite".tr(), canBack: true),

            SizedBox(height: heigth * 0.03),
            const TapBarItemFav(),
            SizedBox(height: heigth * 0.03),
            BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                var controller = context.read<FavoritesCubit>();
                if (state is FavoritesProductsLoading) {
                  return Expanded(child: LoadingUi());
                } else if (state is FavoritesProductsError) {
                  return Expanded(
                    child: NeonNoInternetView(
                      onRetry: () {
                        context.read<FavoritesCubit>().getListFavorites(
                          refresh: true,
                        );
                      },
                      error: state.message,
                    ),
                  );
                }
                if (state is FavoritesProductsLoaded) {
                  final products = state.items;
                  if (products.isEmpty) {
                    return Expanded(child: EmptyDataScreen());
                  } else {
                    return Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scroll) {
                          if (scroll.metrics.pixels >=
                                  scroll.metrics.maxScrollExtent - 200 &&
                              state.hasMore) {
                              
                            controller.getListFavorites();
                          }
                          return false;
                        },
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                height: heigth * 0.42,
                                mainAxisSpacing: 2,
                              ),
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
                              true,
                              productListModel: products[index],
                              isAuction:
                                  context
                                              .read<FavoritesCubit>()
                                              .pageTapBarFav ==
                                          1
                                      ? true
                                      : false,
                            );
                          },
                        ),
                      ),
                    );
                  }
                }

                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
