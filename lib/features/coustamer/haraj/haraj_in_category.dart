import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/haraj/haraj_cubit.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../route/app_routes.dart';
import '../../../route/control_route.dart';
import '../../../utils/const.dart';
import '../../../utils/storage.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';
import '../../../utils/widget/grid_view_custom.dart';

class HarajInCategory extends StatefulWidget {
  final int categoryId;

  const HarajInCategory({super.key, required this.categoryId});

  @override
  State<HarajInCategory> createState() => _HarajInCategoryState();
}

class _HarajInCategoryState extends State<HarajInCategory> {
  @override
  void initState() {
    super.initState();
    context.read<HarajCubit>().getHarajInCategory(
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
        backgroundColor: kohliH,
      ),
      body: Column(
        children: [
          SizedBox(height: heigth * 0.05),
          ItemTitleBar(title: "Open Market".tr(), canBack: true),
          SizedBox(height: heigth * 0.03),

          Expanded(
            child: BlocBuilder<HarajCubit, HarajState>(
              builder: (context, state) {
                if (state.loadingHarajInCategory) {
                  return LoadingUi();
                } else if (state.errorHarajInCategory != null) {
                  return NeonNoInternetView(
                    onRetry: () {
                      context.read<HarajCubit>().getHarajInCategory(
                        categoryId: widget.categoryId,
                        refresh: true,
                      );
                    },
                    error: state.errorHarajInCategory!,
                  );
                } else {
                  if (state.productInCategory == null) {
                    return SizedBox();
                  } else {
                    if (state.productInCategory!.isEmpty) {
                      return EmptyDataScreen(
                        
                      );
                    }
                    final haraj = state.productInCategory;
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.pixels >=
                                scroll.metrics.maxScrollExtent - 200 &&
                            state.hasMoreHarajInCategory) {
                          context.read<HarajCubit>().getHarajInCategory(
                            categoryId: widget.categoryId,
                          
                          );
                        }
                        return false;
                      },
                      child: GridView.builder(
                        itemBuilder: (context, index) {
                          if (index == haraj.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: LoadingUi()),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                ToWithFade(
                                  AppRoutes.detailsHaraj,
                                  arguments: haraj[index].slug!,
                                );
                              },
                              child: Stack(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      side: BorderSide(color: white),
                                    ),
                                    color: getTheme() ? Colors.black : white,
                                    elevation: 4,
                                    child: Container(
                                      width: width * 0.46,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: heigth * 0.011),
                                          Stack(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),

                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        haraj[index]
                                                            .thumbnailImage!,
                                                    placeholder:
                                                        (context, url) =>
                                                            const LoadingUi(),
                                                    errorWidget:
                                                        (
                                                          context,
                                                          url,
                                                          error,
                                                        ) => Image.asset(
                                                          "assets/images/fils_logo_f.png",
                                                        ),
                                                    height: heigth * 0.2,
                                                    width: width,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: heigth * 0.01),
                                          DefaultText(
                                            haraj[index].name,
                                            color:
                                                getTheme() ? white : blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: heigth * 0.005),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                "assets/icons/store_nav.svg",
                                              ),
                                              SizedBox(width: width * 0.01),
                                              Expanded(
                                                child: DefaultText(
                                                  haraj[index].category,
                                                  color: textColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: heigth * 0.005),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DefaultText(
                                                haraj[index].unitPrice,
                                                color: secondColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        itemCount:
                            state.hasMore ? haraj!.length + 1 : haraj!.length,

                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              height: heigth * 0.32,
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
    );
  }
}
