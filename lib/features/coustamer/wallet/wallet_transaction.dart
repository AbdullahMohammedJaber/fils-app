import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/wallet/wallet_transaction.dart';
import 'package:fils/managment/wallet/wallet_cubit.dart';
import 'package:fils/managment/wallet/wallet_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class WalletTransactionScreen extends StatefulWidget {
  const WalletTransactionScreen({super.key});

  @override
  State<WalletTransactionScreen> createState() =>
      _WalletTransactionScreenState();
}

class _WalletTransactionScreenState extends State<WalletTransactionScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() {
    Future.delayed(Duration(seconds: 1), () {
      context.read<WalletCubit>().getWalletTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        if (state.isLoadingTransaction) {
          return Expanded(child: Center(child: LoadingUi()));
        }
        if (state.walletError != null) {
          return DefaultText(state.walletError);
        }

        TransactionHistoryResponse? transactionHistoryResponse =
            state.transactions;
        if(transactionHistoryResponse!=null){
          if (transactionHistoryResponse.data.isNotEmpty) {
            return Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  var item = transactionHistoryResponse.data[index];
                  return Row(
                    children: [
                      Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/icons/gift.svg",
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              transactionHistoryResponse
                                  .data[index]
                                  .description ??
                                  "",
                              color: getTheme() ? white : blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      DefaultText(
                        item.amount,
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  );
                },
                separatorBuilder:
                    (context, index) => SizedBox(height: heigth * 0.02),
                itemCount: transactionHistoryResponse.data.length,
              ),
            );
          } else {
            return Expanded(
              child: IconButton(
                onPressed: () {
                  context.read<WalletCubit>().getWalletTransaction();
                },
                icon: DefaultText(StringApp.noData.tr()),
              ),
            );
          }
        }
        return Expanded(
          child: IconButton(
            onPressed: () {
              context.read<WalletCubit>().getWalletTransaction();
            },
            icon: DefaultText(StringApp.noData.tr()),
          ),
        );
      },
    );
  }
}
