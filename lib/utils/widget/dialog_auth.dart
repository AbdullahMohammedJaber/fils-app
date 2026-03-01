// ignore_for_file: library_private_types_in_public_api

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:flutter/material.dart';


import 'button_widget.dart';
import 'defulat_text.dart';

showDialogAuth(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return const ScaleTransitionDialog();
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
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
          'To continue, you must log in.'.tr(),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidget(
              title: "Login".tr(),
              onTap: () {
                Navigator.pop(context);
                ToWithFade( AppRoutes.login );
              },
            ),
          ),
        ],
      ),
    );
  }
}
