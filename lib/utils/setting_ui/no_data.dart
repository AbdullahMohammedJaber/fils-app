import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/string.dart';

import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

class EmptyDataScreen extends StatelessWidget {
  final VoidCallback? onReload;

  const EmptyDataScreen({super.key, this.onReload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.hourglass_empty, color: Colors.grey.shade400, size: 80),

            const SizedBox(height: 20),

            // العنوان
            DefaultText(StringApp.noData.tr(), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
