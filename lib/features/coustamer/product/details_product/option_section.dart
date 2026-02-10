import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/detail_product/details_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/response/product/details_product_response.dart';
import '../../../../utils/widget/defulat_text.dart';

class OptionSection extends StatelessWidget {
  final ProductData details;

  const OptionSection({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    if (details.stocks!.data.isEmpty) {
      return const SizedBox();
    } else {
      return BlocConsumer<DetailsProductCubit, DetailsProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          var controller = context.read<DetailsProductCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: heigth * 0.02),
                if (details.colors!.isNotEmpty)
                  Row(
                    children: [
                      for (dynamic i = 0; i < details.colors!.length; i++)
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: grey4),
                            color: Color(
                              int.parse(
                                details.colors![i].replaceAll('#', '0xff'),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: heigth * 0.02),
                if (details.choiceOptions!.isNotEmpty)
                Column(
                  children: [
                     Row(
                    children: [
                      DefaultText(
                        "Select option".tr(),
                        fontSize: 14,
                        color: const Color(0xff5A5555),
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(width: width * 0.02),
                    ],
                  ),
                SizedBox(height: heigth * 0.03),

                Container(
                  height: heigth * 0.05,
                  margin: const EdgeInsets.only(top: 5),
                  color: Colors.transparent,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectItemSize(
                            details.choiceOptions![0].values![index],
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: primaryColor),
                            color:
                                state.nameVariant ==
                                        details.choiceOptions![0].values![index]
                                    ? primaryColor
                                    : white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(
                              child: DefaultText(
                                details.choiceOptions![0].values![index],
                                color:
                                    state.nameVariant ==
                                            details
                                                .choiceOptions![0]
                                                .values![index]
                                        ? white
                                        : textColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    scrollDirection: Axis.horizontal,
                    itemCount: details.choiceOptions![0].values!.length,
                    separatorBuilder: (BuildContext context, dynamic index) {
                      return const SizedBox(width: 10);
                    },
                  ),
                ),
                  ],
                )
                 
              ],
            ),
          );
        },
      );
    }
  }
}
