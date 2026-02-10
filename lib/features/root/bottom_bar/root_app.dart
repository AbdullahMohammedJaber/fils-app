// ignore_for_file: must_be_immutable

import 'package:fils/managment/language/language_cubit.dart';
import 'package:fils/managment/language/language_state.dart';
import 'package:fils/managment/update/cubit/update_cubit.dart';
import 'package:fils/utils/deeb_link.dart';
 import 'package:fils/utils/enum_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/storage.dart';
import 'root_general.dart';

class RootAppScreen extends StatefulWidget {
  int? currentIndex;
  RootAppScreen({super.key, this.currentIndex});

  @override
  State<RootAppScreen> createState() => _RootAppScreenState();
}

class _RootAppScreenState extends State<RootAppScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       AppLinkHandler.handleIfNeeded();
      context.read<UpdateCubit>().checkForUpdate(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin()) {
      return BlocConsumer<LanguageCubit, LanguageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RootGeneral(userType: getUser()!.user!.type);
        },
      );
    } else {
      return BlocConsumer<LanguageCubit, LanguageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RootGeneral(userType: UserType.customer.name);
        },
      );
    }
  }
}
