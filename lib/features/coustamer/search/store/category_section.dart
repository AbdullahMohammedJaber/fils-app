import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/coustamer/search/store/dialog_show_category.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/storage.dart';
import '../../../../utils/widget/defulat_text.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var controller = context.read<SearchCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              "Categories".tr(),
              fontWeight: FontWeight.w500,
              color: getTheme() ? white : blackColor,
              fontSize: 14,
            ),
            SizedBox(height: heigth * 0.02),
            GestureDetector(
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder:
                      (context) => DialogShowCategory(
                        callback: (item) {
                          controller.changeCategory(
                            name: item!.name,
                            id: item.id,
                          );
                        },
                      ),
                );
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: getTheme() ? Colors.black : white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xffE9E9E9)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/category.svg"),
                      SizedBox(width: width * 0.03),
                      DefaultText(
                        state.categoryName ?? "Select category".tr(),
                        color: const Color(0xff898384),
                      ),
                      const Spacer(),
                      Center(child: SvgPicture.asset("assets/icons/drob.svg")),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
