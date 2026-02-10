import 'package:fils/features/coustamer/product/all_product/item_tab_bar_store.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/store/store_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/const.dart';
import '../../../../utils/widget/grid_view_custom.dart';
import '../general_product.dart';

class AllProductStore extends StatefulWidget {
  final dynamic idStore;
  final dynamic nameStore;

  const AllProductStore({
    super.key,
    required this.idStore,
    required this.nameStore,
  });

  @override
  State<AllProductStore> createState() => _AllProductStoreState();
}

class _AllProductStoreState extends State<AllProductStore> {
  @override
  void initState() {
    super.initState();
    fetchFunction();
  }

  Future<void> fetchFunction() async {
    await context.read<StoreCubit>().fetchTabBar(
      id: int.parse(widget.idStore.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: heigth * 0.06),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ItemTitleBar(title: widget.nameStore, canBack: true),
          ),
          SizedBox(height: heigth * 0.03),

          TabBarStore(id: widget.idStore),
          SizedBox(height: heigth * 0.03),
          Expanded(
            child: BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                if (state.getProductLoading) {
                  return LoadingUi();
                } else if (state.errorListAllProductStore != null) {
                  return NeonNoInternetView(
                    onRetry: () {
                      context.read<StoreCubit>().getAllProductIntoStore(
                        int.parse(widget.idStore.toString()),
                        refresh: true,
                      );
                    },
                    error: state.errorListAllProductStore!,
                  );
                } else {
                  if (state.listProductInStore == null) {
                     return SizedBox();
                  } else {
                    final products = state.listProductInStore;
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.pixels >=
                                scroll.metrics.maxScrollExtent - 200 &&
                            state.hasMoreListAllProductStore) {
                          context.read<StoreCubit>().getAllProductIntoStore(
                            widget.idStore,
                          );
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
                            ? products!.length + 1
                            : products!.length,
                        itemBuilder: (_, index) {
                          if (index == products.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: LoadingUi()),
                            );
                          }

                          return ProductItemWidget(
                            true,
                              isAuction: false,

                            productListModel: products[index],
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
