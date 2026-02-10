// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../managment/auth_manage/auth_cubit.dart';
import 'button_widget.dart';
import 'defulat_text.dart';

showDialogLogout(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      // ignore: prefer_const_constructors
      return ScaleTransitionDialog();
    },
  );
}

class ScaleTransitionDialog extends StatefulWidget {
  const ScaleTransitionDialog({super.key});

  @override
  _ScaleTransitionDialogState createState() => _ScaleTransitionDialogState();
}

class _ScaleTransitionDialogState extends State<ScaleTransitionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            DefaultText(
              'Authentication'.tr(),
              type: FontType.bold,
              fontSize: 20,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: DefaultText(
          'Do you want to log out of the application?'.tr(),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              title: "Logout".tr(),
              onTap: () {
                Navigator.pop(context);
                 context.read<AuthCubit>().logoutAccountUser();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              title: "Cancel".tr(),
              colorButton: blackColor,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

showDialogDelete(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      // ignore: prefer_const_constructors
      return ScaleTransitionDialogDelete();
    },
  );
}

class ScaleTransitionDialogDelete extends StatefulWidget {
  const ScaleTransitionDialogDelete({super.key});

  @override
  _ScaleTransitionDialogDeleteState createState() =>
      _ScaleTransitionDialogDeleteState();
}

class _ScaleTransitionDialogDeleteState
    extends State<ScaleTransitionDialogDelete>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            DefaultText(
              'Authentication'.tr(),
              type: FontType.bold,
              fontSize: 20,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        content: DefaultText(
          'Do you want to delete account ?'.tr(),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              title: "Delete".tr(),
              onTap: () {
                Navigator.pop(context);
                context.read<AuthCubit>().deleteAccountUser();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              title: "Cancel".tr(),
              colorButton: blackColor,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
