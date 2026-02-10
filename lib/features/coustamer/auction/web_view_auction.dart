import 'dart:developer';

import 'package:fils/managment/auction/auction_cubit.dart';
 import 'package:fils/utils/enum_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewAuction extends StatefulWidget {
  final String urlPayment;
  final PaymentType paymentType ;
  const PaymentWebViewAuction({super.key, required this.urlPayment , required this.paymentType});

  @override
  State<PaymentWebViewAuction> createState() => _PaymentWebViewAuctionState();
}

class _PaymentWebViewAuctionState extends State<PaymentWebViewAuction> {
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
                   context.read<AuctionCubit>().functionWebView(
                    url: remainingUrl,
                    paymentType: widget.paymentType,
                  ); 
                }
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
