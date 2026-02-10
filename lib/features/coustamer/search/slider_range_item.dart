// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/search/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/storage.dart';
import '../../../utils/widget/defulat_text.dart';


class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  _PriceRangeSliderState createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
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
              "Price".tr(),
              fontWeight: FontWeight.w600,
              color: getTheme() ? white : blackColor,
              fontSize: 16,
            ),
            RangeSlider(
              values: state.currentRangeValues,
              min: 1,
              max: 1000,
              divisions: 50,
              activeColor: purpleColor,
              inactiveColor: Colors.black,
              onChanged: (RangeValues price) {
                controller.changeRangePrice(price);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAnimatedLabel(
                  '${state.currentRangeValues.start.toInt()} KWD',
                ),
                _buildAnimatedLabel(
                  '${state.currentRangeValues.end.toInt()} KWD',
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedLabel(String? text) {
    return DefaultText(
      text!,
      fontWeight: FontWeight.w500,
      color: getTheme() ? white : blackColor,
      fontSize: 14,
    );
  }
}
