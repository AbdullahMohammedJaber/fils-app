import 'dart:math';
import 'package:flutter/material.dart';

import '../storage.dart';

class FlipView extends StatelessWidget {
  final Widget? child;

  const FlipView({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(
        getLang() == 'en' || getLang() == 'hi' ? 0 : pi,
      ),
      child: child,
    );
  }
}
