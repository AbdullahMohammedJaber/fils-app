import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/storage.dart';
import '../../../utils/widget/defulat_text.dart';

class TabBarItemFilter extends StatelessWidget {
  const TabBarItemFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        final controller = context.read<SearchCubit>();
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.changeTypeSection(2);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color:
                        state.typeSection == 2
                            ? primaryDarkColor
                            : getTheme()
                            ? Colors.black
                            : white,
                    border: Border.all(
                      color:
                          state.typeSection == 2
                              ? primaryDarkColor
                              : getTheme()
                              ? Colors.white
                              : textColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultText(
                      "Auctions".tr(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          state.typeSection == 2
                              ? white
                              : getTheme()
                              ? Colors.white
                              : textColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: width * 0.02),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.changeTypeSection(1);
                },
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color:
                        state.typeSection == 1
                            ? primaryDarkColor
                            : getTheme()
                            ? Colors.black
                            : white,
                    border: Border.all(
                      color:
                          state.typeSection == 1
                              ? primaryDarkColor
                              : getTheme()
                              ? Colors.white
                              : textColor,
                    ),
                  ),
                  child: Center(
                    child: DefaultText(
                      "Online Store".tr(),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          state.typeSection == 1
                              ? white
                              : getTheme()
                              ? Colors.white
                              : textColor,
                    ),
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
