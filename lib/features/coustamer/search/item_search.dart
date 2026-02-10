// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:flutter/material.dart';

import '../../../utils/widget/defualt_text_form_faild.dart';
import 'filter_widget.dart';

class ItemSearch extends StatelessWidget {
  ItemSearch({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormFieldWidget(
        hintText: "Search".tr(),
        isIcon: true,
        isDouble: false,
        isPreffix: true,
        controller: searchController,
        onChange: (value) {},
        textInputType: TextInputType.name,
        textInputAction: TextInputAction.search,
        onTapDoneKey: (search) {
          print("On Tab search icon in keyboard");
          FocusScope.of(context).unfocus();
          ToWithFade(
            AppRoutes.allProductFilter,
            arguments: searchController.text,
          );
        },
        ontapIconPrefix: () {
          print("On Tab search icon in form faild");

          FocusScope.of(context).unfocus();
          ToWithFade(
            AppRoutes.allProductFilter,
            arguments: searchController.text,
          );
        },
        ontapIcon: () {
          FocusScope.of(context).unfocus();
          showModalBottomSheet(
            context: context,
            elevation: 2,
            enableDrag: true,
            useSafeArea: true,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            builder: (context) {
              return const FilterWidget();
            },
          );
        },
        pathIconPrefix: "assets/icons/search_home.svg",
        pathIcon: "assets/icons/filter_home.svg",
      ),
    );
  }
}
