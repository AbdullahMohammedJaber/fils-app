 import 'package:flutter/material.dart';

class BannerAdsScreen extends StatelessWidget {
  const BannerAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 15 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                "assets/test/banners.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover, 
              ),
            ),
          ),
          const SizedBox(height: 3),
        ],
      ),
    );
  }
}
