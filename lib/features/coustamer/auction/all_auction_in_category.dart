import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../managment/auction/auction_cubit.dart';
import '../../../utils/const.dart';
import '../../../utils/setting_ui/loading_ui.dart';
import '../../../utils/setting_ui/no_internet_ui.dart';
 import '../../../utils/theme/color_manager.dart';
import '../../root/item_title_bar.dart';
import 'item_auction_new.dart';

class AllAuctionInCategory extends StatefulWidget {
  final int categoryId;

  const AllAuctionInCategory({super.key, required this.categoryId});

  @override
  State<AllAuctionInCategory> createState() => _AllAuctionInCategoryState();
}

class _AllAuctionInCategoryState extends State<AllAuctionInCategory> {
  @override
  void initState() {
    super.initState();
    context.read<AuctionCubit>().getAllAuctionCategory(
      categoryId: widget.categoryId,
      refresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: -1,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: zaherH,
      ),
      body: Column(
        children: [
          SizedBox(height: heigth * 0.040),
          ItemTitleBar(title: "Public Auctions".tr(), canBack: true),
          SizedBox(height: heigth * 0.040),
          Expanded(
            child: BlocConsumer<AuctionCubit, AuctionState>(
              builder: (context, state) {
                if (state.loadingAuctionCategory) {
                  return LoadingUi();
                } else if (state.errorAuctionCategory != null) {
                  return NeonNoInternetView(
                    onRetry: () {
                      context.read<AuctionCubit>().getAllAuctionCategory(
                        refresh: true,
                        categoryId: widget.categoryId,
                      );
                    },
                    error: state.error!,
                  );
                } else if (state.auctionListAuctionCategory != null) {
                  if (state.auctionListAuctionCategory!.isEmpty) {
                    return EmptyDataScreen(
                      onReload: () {
                        context.read<AuctionCubit>().getAllAuctionCategory(
                          refresh: true,
                          categoryId: widget.categoryId,
                        );
                      },
                     
                    );
                  } else {
                    final data = state.auctionListAuctionCategory;

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.pixels >=
                                scroll.metrics.maxScrollExtent - 200 &&
                            state.hasMoreAuctionCategory) {
                          context.read<AuctionCubit>().getAllAuctionCategory(
                            categoryId: widget.categoryId,
                          );
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: LoadingUi()),
                            );
                          } else {
                            return ItemAuctionNew(item: data[index]);
                          }
                        },
                        itemCount:
                            state.hasMoreAuctionCategory
                                ? data!.length + 1
                                : data!.length,
                      ),
                    );
                  }
                }
                return SizedBox();
              },
              listener: (context, state) {},
            ),
          ),
        ],
      ),
    );
  }
}
