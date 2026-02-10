import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/theme/color_manager.dart';
import '../../utils/widget/button_widget.dart';
import '../../utils/widget/defulat_text.dart';

void showDialogExitApp(BuildContext context) {
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: DefaultText(
          'Exit'.tr(),
          type: FontType.bold,
          fontSize: 20,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DefaultText(
              'Are you sure you want to go out?'.tr(),
              overflow: TextOverflow.visible,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width * 0.25,
                    child: ButtonWidget(
                      title: "Exit".tr(),
                      onTap: () {
                        Navigator.pop(context);
                        if (Platform.isAndroid || Platform.isIOS) {
                          exit(0);
                        }
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width * 0.25,
                    child: ButtonWidget(
                      title: "Cancel".tr(),
                      colorButton: blackColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}