import 'package:easy_localization/easy_localization.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/wallet/wallet_seller_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WalletSeller extends StatefulWidget {
  const WalletSeller({super.key});

  @override
  State<WalletSeller> createState() => _WalletSellerState();
}

class _WalletSellerState extends State<WalletSeller> {
  @override
  void initState() {
    super.initState();
    context.read<WalletSellerCubit>().getWallet();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletSellerCubit, WalletSellerState>(
      builder: (context, state) {
        if (state.loading) {
          return LoadingUi();
        }
        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(width: width, height: heigth * 0.06),
                Row(
                  children: [
                    Expanded(
                      child: ItemTitleBar(title: "Wallet".tr(), canBack: true),
                    ),
                    GestureDetector(
                      onTap: () {
                        ToWithFade(AppRoutes.settingWallet);
                      },
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/setting.svg",
                            color: getTheme() ? white : textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: width, height: heigth * 0.05),
                Container(
                  height: heigth * 0.12,
                  width: width,
                  decoration: BoxDecoration(
                    color: primaryDarkColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DefaultText(
                            "${state.totalWallet}",
                            color: white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: width * 0.015),
                          DefaultText(
                            "KWD",
                            color: white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(height: heigth * 0.01),
                    ],
                  ),
                ),
                SizedBox(width: width, height: heigth * 0.03),
                DefaultText(
                  "Your current balance in the wallet.".tr(),
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(width: width, height: heigth * 0.05),
                ButtonWidget(
                  onTap: () {
                    if(state.totalWallet>0){

                    
                    ToWithFade(AppRoutes.withdrowScreen , arguments:state.totalWallet.toString() );
                  }},
                  title: "Withdraw Funds".tr(),
                  colorButton: state.totalWallet == 0 ? textColor : secondColor,
                  radius: 18,
                ),
                SizedBox(width: width, height: heigth * 0.05),
                if(state.walletSellerResponse !=null)  
                state.walletSellerResponse!.data.latestPayouts.isNotEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          "Latest Transactions".tr(),
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            //ToWithFade(context, TransactionHistory());
                          },
                          child: DefaultText(
                            "View Full Transactions".tr(),
                            color: primaryDarkColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    )
                    : const SizedBox(),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 1,
                                  offset: const Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/icons/payment_failed.svg",
                              ),
                            ),
                          ),
                          SizedBox(width: width * 0.03),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultText(
                                  "Failed transaction!".tr(),
                                  color: blackColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/calendar.svg",
                                        ),
                                        SizedBox(width: width * 0.01),
                                        DefaultText(
                                          "10.02.2025",
                                          color: textColor,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: width * 0.03),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/clock.svg",
                                        ),
                                        SizedBox(width: width * 0.01),
                                        DefaultText(
                                          "05:34 AM",
                                          color: textColor,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          DefaultText(
                            "- ${"KWD"} 57",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xffE4626F),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: heigth * 0.01);
                    },
                    itemCount:
                        state.walletSellerResponse!.data.latestPayouts.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
