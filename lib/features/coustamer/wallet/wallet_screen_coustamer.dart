import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/wallet/wallet_balance_response.dart';
import 'package:fils/features/coustamer/wallet/wallet_transaction.dart';
import 'package:fils/features/root/item_title_bar.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/managment/wallet/wallet_cubit.dart';
import 'package:fils/managment/wallet/wallet_state.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/setting_ui/no_internet_ui.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/widget/defulat_text.dart';

class WalletScreenCoustamer extends StatefulWidget {
  const WalletScreenCoustamer({super.key});

  @override
  State<WalletScreenCoustamer> createState() => _WalletScreenCoustamerState();
}

class _WalletScreenCoustamerState extends State<WalletScreenCoustamer> {
  @override
  void initState() {
    super.initState();
    final walletCubit = context.read<WalletCubit>();
    walletCubit.getWallet();
  }

  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppCubit>().hide();
    });
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state.isLoadingWallet) {
          return Center(child: LoadingUi());
        } else if (state.walletError != null) {
          return NeonNoInternetView(onRetry: () {
            context.read<WalletCubit>().getWallet();
          }, error: state.walletError!);
        }
        BalanceResponse? balanceResponse = state.balance;

        return Scaffold(
          appBar: AppBar(toolbarHeight: 0),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(height: heigth * 0.02),
                ItemTitleBar(
                  title: "Add Funds",
                  canAdd: true,
                  onTap: () {
                    ToWithFade(AppRoutes.addMoneyWallet , arguments: 0.0);
                  },
                ),

                if (balanceResponse!.data!.lastRecharged == "Not Available")
                  Column(
                    children: [
                      SizedBox(height: heigth * 0.05),
                      DefaultText(
                        "You must charge your wallet balance in order to enjoy the application features"
                            .tr(),
                        overflow: TextOverflow.visible,
                        color: textColor,
                      ),
                      SizedBox(height: heigth * 0.02),
                      Image.asset("assets/images/wallet_F.png"),
                      SizedBox(height: heigth * 0.05),
                    ],
                  )
                else
                  Column(
                    children: [
                      SizedBox(height: heigth * 0.05),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryDarkColor,
                        ),
                        height: heigth * 0.15,
                        width: width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            DefaultText(
                              "${balanceResponse.data!.balance}",
                              color: white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(width: 5),
                            DefaultText(
                              "KWD",
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: heigth * 0.03),
                      DefaultText(
                        "Your current balance in the wallet, you can add more through the add button"
                            .tr(),
                        overflow: TextOverflow.visible,
                        color: textColor,
                      ),
                    ],
                  ),

                WalletTransactionScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
