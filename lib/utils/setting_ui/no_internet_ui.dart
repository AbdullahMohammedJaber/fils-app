import 'package:easy_localization/easy_localization.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';

class NeonNoInternetView extends StatefulWidget {
  final VoidCallback onRetry;
  final String error;

  const NeonNoInternetView({
    super.key,
    required this.onRetry,
    required this.error,
  });

  @override
  State<NeonNoInternetView> createState() => _NeonNoInternetViewState();
}

class _NeonNoInternetViewState extends State<NeonNoInternetView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultText(widget.error.tr()),
          IconButton(onPressed: widget.onRetry, icon: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
