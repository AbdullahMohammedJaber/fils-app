import 'package:flutter/material.dart';
import 'package:fils/utils/const.dart';

class CartEmptyScreen extends StatelessWidget {
  const CartEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/icons/empty-cart.png",
        height: heigth * 0.3,
      ),
    );
  }
}
