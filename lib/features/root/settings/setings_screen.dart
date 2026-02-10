import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/settings/item_settings.dart';
import 'package:fils/features/root/item_title_bar.dart';
 
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/dialog_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetingsScreen extends StatelessWidget {
  const SetingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  SizedBox(height: heigth * 0.05),
                  ItemTitleBar(title: "Settings".tr(), canBack: true),
                  SizedBox(height: heigth * 0.05),
                  itemSetting(
                    title: "Language".tr(),
                    onClick: () {
                      ToWithFade(AppRoutes.languageScreen);
                    },
                    pathIcon: "assets/icons/language.svg",
                    showBackIcon: true,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: width * 0.02),
                    child: Divider(thickness: 0.2, color: textColor),
                  ),
                  itemSetting(
                    title: "Edit Personal information".tr(),
                    onClick: () {
                      if (!isLogin()) {
                        showDialogAuth(context);
                      } else {
                        ToWithFade(AppRoutes.editPersonalInformationScreen);
                      }
                    },
                    pathIcon: "assets/icons/edit_account.svg",
                    showBackIcon: true,
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: width * 0.02),
                    child: Divider(thickness: 0.2, color: textColor),
                  ),
                  
                  itemSetting(
                    title: "About Us".tr(),
                    showBackIcon: true,
                    pathIcon: "assets/icons/about_us.svg",
                    onClick: () {
                      ToWithFade(AppRoutes.aboutUsScreen);
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: width * 0.02),
                    child: Divider(thickness: 0.2, color: textColor),
                  ),
                  itemSetting(
                    title: "Privacy Policy".tr(),
                    showBackIcon: true,
                    pathIcon: "assets/icons/about_us.svg",
                    onClick: () {
                      ToWithFade(AppRoutes.privacyPolicyScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
