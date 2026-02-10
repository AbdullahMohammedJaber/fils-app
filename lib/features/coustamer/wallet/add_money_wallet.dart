import 'package:easy_localization/easy_localization.dart';
import 'package:fils/managment/wallet/wallet_cubit.dart';
import 'package:fils/managment/wallet/wallet_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
import 'package:fils/utils/widget/button_widget.dart';
import 'package:fils/utils/widget/custom_validation.dart';
import 'package:fils/utils/widget/defualt_text_form_faild.dart';
import 'package:fils/utils/widget/defulat_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../root/item_title_bar.dart';

class AddMoneyWallet extends StatefulWidget {
  final double ?amount;
  const AddMoneyWallet({super.key , this.amount});

  @override
  State<AddMoneyWallet> createState() => _AddMoneyWalletState();
}

class _AddMoneyWalletState extends State<AddMoneyWallet> {
  TextEditingController balance = TextEditingController();
  final _key = GlobalKey<FormState>();
  @override
  void initState() {
     
    super.initState();
    if(widget.amount!=null && widget.amount! > 0){
      balance.text = widget.amount.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false, toolbarHeight: 0),
          body: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: heigth * 0.03),
                    ItemTitleBar(canBack: true, title: "Add Funds".tr()),
                    SizedBox(height: heigth * 0.03),
                    DefaultText(
                      "You must charge your wallet balance in order to enjoy the application features"
                          .tr(),
                      overflow: TextOverflow.visible,
                      color: textColor,
                    ),
                    SizedBox(height: heigth * 0.05),

                    ValidateWidget(
                      validator: (v) {
                        if (balance.text.isEmpty) {
                          return StringApp.requiredField.tr();
                        } else {
                          return null;
                        }
                      },
                      child: TextFormFieldWidget(
                        hintText: "enter balance".tr(),
                        controller: balance,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.send,
                      ),
                    ),
                    SizedBox(height: heigth * 0.05),
                    ButtonWidget(
                      title:
                          state.isLoadingAddMoneyWallet
                              ? state.isLoadingAddMoneyWallet
                              : "Confirm".tr(),
                      onTap: () {
                        if (!_key.currentState!.validate()) {
                        } else {
                          context.read<WalletCubit>().addMoneyWallet(
                            balance.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: heigth * 0.05),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
