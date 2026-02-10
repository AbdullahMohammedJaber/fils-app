import 'package:cached_network_image/cached_network_image.dart';
import 'package:fils/managment/category/category_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/const.dart';
import '../../../utils/enum_class.dart';
import '../../../utils/setting_ui/loading_ui.dart';
import '../../../utils/setting_ui/no_internet_ui.dart';
import '../../../utils/theme/color_manager.dart';
import '../../../utils/widget/defulat_text.dart';

class CategoryWidget extends StatefulWidget {
  final ClassType? classType;

  const CategoryWidget({super.key, this.classType});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    context.read<CategoryCubit>().functionFetchCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: heigth * 0.2,
      padding: EdgeInsetsDirectional.only(start: 12),
      color: Colors.transparent,
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
          if (state.loading) {
            return LoadingUi();
          } else if (state.error != null) {
            return NeonNoInternetView(
              onRetry: () {
                context.read<CategoryCubit>().functionFetchCategory();
              },
              error: state.error!,
            );
          } else {
            return SizedBox(
              height: 3 * 58,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1 / 3,
                ),
                itemCount: state.categoryResponse!.data.length,
                itemBuilder: (context, index) {
                  final e = state.categoryResponse!.data[index];
                  return GestureDetector(
                    onTap: () {
                      if (widget.classType == ClassType.haraj) {
                        ToWithFade(AppRoutes.harajInCategory, arguments: e.id);
                      }
                      if (widget.classType == ClassType.auction) {
                        ToWithFade(
                          AppRoutes.allAuctionInCategory,
                          arguments: e.id,
                        );
                      }
                      if (widget.classType == ClassType.store) {
                        ToWithFade(
                          AppRoutes.allStoreInCategory,
                          arguments: e.id,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: e.banner,
                            errorWidget:
                                (context, url, error) => Icon(Icons.info),
                            width: 24,
                            height: 24,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => LoadingUi(),
                          ),

                          const SizedBox(width: 5),
                          Expanded(
                            child: DefaultText(
                              e.name,
                              maxLines: 1,
                              fontSize: 11,
                              color: blackColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        
        },
      ),
    );
  }
}
