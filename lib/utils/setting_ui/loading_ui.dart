import 'package:bot_toast/bot_toast.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingUi extends StatelessWidget {
  const LoadingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.discreteCircle(
        color: primaryColor,
        secondRingColor: orangeH,
        thirdRingColor: primaryDarkColor ,
        size: 30,
      ),
    );
  }
}

showBoatToast({String? title}) {
  BotToast.showCustomLoading(
    toastBuilder: (wid) {
      return LoadingUi();
    },
  );
}

closeAllLoading() {
  BotToast.closeAllLoading();
}
