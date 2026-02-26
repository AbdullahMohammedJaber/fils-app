import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {},
      builder: (context, state) {
        var controller = context.read<LanguageCubit>();
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: heigth * 0.06),

                  ItemTitleBar(title: "Language".tr(), canBack: true),
                  SizedBox(height: heigth * 0.07),
                  ...List.generate(controller.supportedLocales.length, (index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.changeLanguage(
                              controller.supportedLocales[index]['code'],
                              context,
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            width: width,
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: const Color(
                                      0xffBA27B7,
                                    ).withOpacity(0.4),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/arabic.svg",
                                    ),
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                DefaultText(
                                  controller.supportedLocales[index]['name'],
                                  fontSize: 14,

                                  fontWeight: FontWeight.w500,
                                ),
                                const Spacer(),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: textColor),
                                  ),
                                  child:
                                      getLang() ==
                                              controller
                                                  .supportedLocales[index]['code']
                                          ? Container(
                                            margin: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: primaryDarkColor,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                          )
                                          : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: width * 0.02,
                          ),
                          child: const Divider(thickness: 1),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
