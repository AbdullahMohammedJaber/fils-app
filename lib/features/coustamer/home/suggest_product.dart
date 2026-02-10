import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/haraj/haraj_cubit.dart';
import 'package:fils/managment/home/suggest_product_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_data.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/setting_ui/no_internet_ui.dart';
  
class SuggestProduct extends StatefulWidget {
  const SuggestProduct({super.key});

  @override
  State<SuggestProduct> createState() => _SuggestProductState();
}

class _SuggestProductState extends State<SuggestProduct> {
  @override
  void initState() {
   context.read<HarajCubit>().getAllHaraj(refresh: true);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Row(
            children: [
              DefaultText(
                "Open Market".tr(),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: getTheme() ? white : blackColor,
              ),
              const Spacer(),
              GestureDetector(
                onTap: (){
                  ToWithFade(AppRoutes.harajRoot);
                },
                child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: DefaultText(
                            "See All".tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: primaryColor,
                          ),
                        ),
              ),
             
            ],
          ),

          SizedBox(height: heigth * 0.02),

          BlocBuilder<HarajCubit, HarajState>(
            builder: (context, state) {
              if (state.loading) {
                return SizedBox(
                  height: heigth * 0.45,
                  child: const Center(child: LoadingUi()),
                );
              }
          
             
              if (state.error!=null) {
                return NeonNoInternetView(
                  onRetry: () {
                    context.read<HarajCubit>().getAllHaraj(refresh: true);
                  },
                  error: state.error!,
                );
              }
          
                final haraj = state.products;
                if (haraj.isEmpty) {
                  return Expanded(
                    child: EmptyDataScreen(
                       
                    ),
                  );
                }
                return SizedBox(
                  height: heigth * 0.35,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scroll) {
                      if (scroll.metrics.pixels >=
                              scroll.metrics.maxScrollExtent - 200 &&
                          state.hasMore) {
                        context.read<SuggestProductCubit>().fetch();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          state.hasMore
                              ? haraj.length + 1
                              : haraj.length,
                      itemBuilder: (_, index) {
                        if (index == haraj.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: LoadingUi()),
                          );
                        }
          
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
                      },
                    ),
                  ),
                );
          
           
            },
          ),
        ],
      ),
    );
  }
}
