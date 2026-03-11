import 'dart:developer';

import 'package:fils/managment/wallet/wallet_cubit.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewWallet extends StatefulWidget {
  final String urlPayment;
  final PaymentType paymentType ;
  const PaymentWebViewWallet({super.key, required this.urlPayment , required this.paymentType});

  @override
  State<PaymentWebViewWallet> createState() => _PaymentWebViewWalletState();
}

class _PaymentWebViewWalletState extends State<PaymentWebViewWallet> {
  late WebViewController controller;

  @override
  void initState() {
    controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) async {
                log("===========>>> onPageStarted  $url");

                if (url.contains('https://dashboard.fils.app/api')) {
                  String baseUrl = "https://dashboard.fils.app/api/v1/";
                  String remainingUrl = url.replaceFirst(baseUrl, "");
                  Navigator.pop( context );

                   context.read<WalletCubit>().functionWebView(
                    url: remainingUrl,
                    paymentType: widget.paymentType,
                  ); 
                }
              },
              onPageFinished: (url) {
                Navigator.pop(context);
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.urlPayment));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*  WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FloatingButtonController>(context, listen: false).hide();
    });*/
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
