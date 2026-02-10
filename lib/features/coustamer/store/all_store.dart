import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/category/category_widget.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/store/store_cubit.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/const.dart';
import '../../../utils/theme/color_manager.dart';
import 'item_store.dart';

class AllStoreScreen extends StatefulWidget {
  const AllStoreScreen({super.key});

  @override
  State<AllStoreScreen> createState() => _AllStoreScreenState();
}

class _AllStoreScreenState extends State<AllStoreScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<StoreCubit>().fetchAllStore(refresh: true);
    });
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: heigth * 0.040),
            ItemTitleBar(title: "Store".tr(), canBack: true),
            SizedBox(height: heigth * 0.040),
            CategoryWidget(classType: ClassType.store),
            SizedBox(height: heigth * 0.040),
            BlocBuilder<StoreCubit, StoreState>(
              builder: (context, state) {
                if (state.loading) {
                  return LoadingUi();
                } else if (state.error != null) {
                  return NeonNoInternetView(
                    onRetry: () {
                      context.read<StoreCubit>().fetchAllStore(refresh: true);
                    },
                    error: state.error!,
                  );
                } else {
                  final store = state.items;

                  if (store!.isEmpty) {
                    return EmptyDataScreen(
                      
                    );
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && state.hasMore && state.loading == false) {
                        context.read<StoreCubit>().fetchAllStore();
                      }
                    });
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.pixels >=
                                scroll.metrics.maxScrollExtent - 200 &&
                            state.hasMore) {
                          context.read<StoreCubit>().fetchAllStore();
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
                            state.hasMore ? store.length + 1 : store.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
