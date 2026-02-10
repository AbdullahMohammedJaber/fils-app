import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/const.dart';
import '../../../utils/widget/grid_view_custom.dart';
import '../product/general_product.dart';

class AllProductFilter extends StatefulWidget {
  final String search;

  const AllProductFilter({super.key, required this.search});

  @override
  State<AllProductFilter> createState() => _AllProductFilterState();
}

class _AllProductFilterState extends State<AllProductFilter> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchCubit>().getDataSearch(
      search: widget.search,
      refresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: heigth * 0.06),
            ItemTitleBar(title: "Filter".tr(), canBack: true),
            SizedBox(height: heigth * 0.01),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state.loading) {
                    return LoadingUi();
                  } else if (state.error != null) {
                    return NeonNoInternetView(
                      onRetry: () {
                        context.read<SearchCubit>().getDataSearch(
                          search: widget.search,
                          refresh: true,
                        );
                      },
                      error: state.error!,
                    );
                  } else {
                    if (state.listSearch!.isEmpty) {
                      return EmptyDataScreen(
                        onReload: () {
                          context.read<SearchCubit>().getDataSearch(
                            search: widget.search,
                            refresh: true,
                          );
                        },
                      );
                    } else {
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scroll) {
                          if (scroll.metrics.pixels >=
                                  scroll.metrics.maxScrollExtent - 200 &&
                              state.hasMore) {
                            context.read<SearchCubit>().getDataSearch(
                              search: widget.search,
                            );
                          }
                          return false;
                        },
                        child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount:
                              state.hasMore
                                  ? state.listSearch!.length + 1
                                  : state.listSearch!.length,
                          itemBuilder: (_, index) {
                            if (index == state.listSearch!.length) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(child: LoadingUi()),
                              );
                            }

                            return ProductItemWidget(
                              isAuction: false,

                              false,
                              productListModel: state.listSearch![index],
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
