import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../managment/store/store_cubit.dart';
import '../../../../utils/const.dart';
import '../../../../utils/setting_ui/loading_ui.dart';
import '../../../../utils/setting_ui/no_internet_ui.dart';
 import '../../../../utils/theme/color_manager.dart';
import '../../../../utils/widget/defulat_text.dart';

class TabBarStore extends StatelessWidget {
  final int id;

  const TabBarStore({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCubit, StoreState>(
      builder: (context, state) {
        if (state.loadingTabBar) {
          return LoadingUi();
        } else if (state.errorTabBar != null) {
          return NeonNoInternetView(
            onRetry: () {
              context.read<StoreCubit>().fetchTabBar(id: id);
            },
            error: state.errorTabBar!,
          );
        } else if(state.listTabBar!=null){
          if (state.listTabBar!.isNotEmpty) {
            return SizedBox(
              height: heigth * 0.05,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        context.read<StoreCubit>().functionChangeSelectTabBar(
                          state.listTabBar![index].id,
                          id,
                        );
                      },
                      child: Container(
                        margin: EdgeInsetsDirectional.only(end: 8),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color:
                              state.tabBarSelect!.id ==
                                  state.listTabBar![index].id
                                  ? primaryColor
                                  : grey2,
                            ),
                          ),
                        ),
                        child: DefaultText(
                          state.listTabBar![index].name,
                          color:
                          state.tabBarSelect!.id ==
                              state.listTabBar![index].id
                              ? blackColor
                              : grey,
                        ),
                      ),
                    );
                  },
                  itemCount: state.listTabBar!.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            );
          }
          else {
            return EmptyDataScreen(
              
            );
          }

        }
        return SizedBox();
      },
      listener: (context, state) {},
    );
  }
}
