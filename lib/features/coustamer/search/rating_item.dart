import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fils/utils/theme/color_manager.dart';

import '../../../utils/storage.dart';
import '../../../utils/widget/defulat_text.dart';

class RatingItem extends StatelessWidget {
  const RatingItem({super.key});

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
              "Rating".tr(),
              fontWeight: FontWeight.w600,
              color: getTheme() ? white : blackColor,
              fontSize: 16,
            ),
            Row(
              children: [
                ...List.generate(controller.rateList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      controller.functionOnClickStar(controller.rateList[index]['id']);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Center(
                        child:
                        controller.rateList[index]['select']
                            ? SvgPicture.asset(
                          "assets/icons/star_select.svg",
                        )
                            : SvgPicture.asset(
                          "assets/icons/star_unselect.svg",
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        );
      },
    );
  }
}
