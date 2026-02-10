import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/order/order_cubit.dart';
import 'package:flutter/material.dart';

import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/widget/defulat_text.dart';

class TapBarOrderItem extends StatelessWidget {
  const TapBarOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        var controller = context.read<OrderCubit>();
        return Container(
          height: 55,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            border: Border.all(color: grey3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.02,
              vertical: 5,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.changePageTapBar(1);

                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: state.pageTapBar == 1 ? primaryColor : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Current".tr(),
                          color: state.pageTapBar == 1 ? white : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.changePageTapBar(2);

                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: state.pageTapBar == 2 ? primaryColor : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Completed".tr(),
                          color: state.pageTapBar == 2 ? white : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.changePageTapBar(4);

                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: state.pageTapBar == 4 ? primaryColor : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Un Paid".tr(),
                          color: state.pageTapBar == 4 ? white : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * 0.01),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.changePageTapBar(3);

                    },
                    child: AnimatedContainer(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: state.pageTapBar == 3 ? primaryColor : white,
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Center(
                        child: DefaultText(
                          "Cancelled".tr(),
                          color: state.pageTapBar == 3 ? white : blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
