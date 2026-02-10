import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../managment/store/store_cubit.dart';
import '../../../utils/const.dart';
import '../../../utils/setting_ui/loading_ui.dart';
import '../../../utils/setting_ui/no_internet_ui.dart';
 import '../../../utils/theme/color_manager.dart';
import '../../root/item_title_bar.dart';
import 'item_store.dart';

class AllStoreInCategory extends StatefulWidget {
  final int categoryId;

  const AllStoreInCategory({super.key, required this.categoryId});

  @override
  State<AllStoreInCategory> createState() => _AllStoreInCategoryState();
}

class _AllStoreInCategoryState extends State<AllStoreInCategory> {
  @override
  void initState() {
    super.initState();
    context.read<StoreCubit>().fetchAllStoreStoreCategory(
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
        backgroundColor: orangeH,
      ),
      body: Column(
        children: [
          SizedBox(height: heigth * 0.040),
          ItemTitleBar(title: "Store".tr(), canBack: true),
          SizedBox(height: heigth * 0.040),
          Expanded(
            child: BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                if (state.loadingStoreCategory) {
                  return LoadingUi();
                } else if (state.errorStoreCategory != null) {
                  return NeonNoInternetView(
                    onRetry: () {
                      context.read<StoreCubit>().fetchAllStoreStoreCategory(
                        refresh: true,
                        categoryId: widget.categoryId,
                      );
                    },
                    error: state.error!,
                  );
                } else {
                  final store = state.itemsStoreCategory;

                  if (store!.isEmpty) {
                    return EmptyDataScreen(
                      
                    );
                  } else {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.pixels >=
                                scroll.metrics.maxScrollExtent - 200 &&
                            state.hasMoreStoreCategory) {
                          context.read<StoreCubit>().fetchAllStoreStoreCategory(
                            categoryId: widget.categoryId,
                          );
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          if (index == store.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: LoadingUi()),
                            );
                          } else {
                            if (store[index].logo == null) {
                              return SizedBox();
                            } else {
                              return ItemStore(dataInter: store[index]);
                            }
                          }
                        },
                        itemCount:
                            state.hasMoreStoreCategory
                                ? store.length + 1
                                : store.length,
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
