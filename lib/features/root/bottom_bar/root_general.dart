import 'package:fils/features/root/bottom_bar/bottom_bar_widget.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/app_manage/app_state.dart';
import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../exit_app.dart';

class RootGeneral extends StatefulWidget {
  final String userType;
  const RootGeneral({super.key, required this.userType});

  @override
  State<RootGeneral> createState() => _RootGeneralState();
}

class _RootGeneralState extends State<RootGeneral> {
  @override
  void initState() {
     
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LanguageCubit, LanguageState>(
      listener: (context, state) {
       
      },
      builder: (context, state) {
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            final controller = context.read<AppCubit>();
            return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                showDialogExitApp(context);
              },
              child: Scaffold(
                body:
                    widget.userType == UserType.customer.name
                        ? controller.screenListCoustomer[state.selectPageRoot]
                        : controller.screenListSeller[state.selectPageRoot],

                bottomNavigationBar: SafeArea(
                  child: CurvedBottomNavigationBar(
                    activeColor: orange,
                    backgroundColor: getTheme() ? Colors.black : Colors.white,
                    inactiveColor: getTheme() ? Colors.white : textColor,
                    userType: widget.userType,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
