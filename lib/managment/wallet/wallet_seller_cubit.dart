import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/wallet/wallet_seller.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
 import 'package:fils/features/seller/wallet/withdrow_screen.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/number_format.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_seller_state.dart';

List<WalletModel> walletList = [
  WalletModel(id: 1, price: "50"),
  WalletModel(id: 2, price: "100"),
  WalletModel(id: 3, price: "500"),
  WalletModel(id: 4, price: "Max Balance".tr()),
];

class WalletModel {
  final dynamic id;
  final String? price;
  bool isSelect = false;
  WalletModel({this.id, this.price});
}

class WalletSellerCubit extends Cubit<WalletSellerState> {
  WalletSellerCubit() : super(WalletSellerState());

  Future<void> getWallet() async {
    emit(state.copyWith(loading: true));
    final result = await UserCaseSeller().walletSellerUseCase.callGetWallet();
    result.handle(
      onSuccess: (data) {
        emit(
          state.copyWith(
            loading: false,
            walletSellerResponse: data,
            totalWallet: extractDouble(data.data.adminToPay),
          ),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(loading: false, error: message));
      },
      onNoInternet: () {
        emit(state.copyWith(loading: false, error: StringApp.noInternet));
      },
    );
  }

  setupBankAccount(
    BuildContext context, {
    required String bankName,
    required String ownerName,
    required String bankNo,
    required String bankIban,
  }) async {
    showBoatToast();
    var json = await DioClient(seller: true).request(
      method: 'POST',
      path: "bank-setup/${getMyShopsDetails().id}",
      data: {
        "bank_name": bankName,
        "bank_acc_name": ownerName,
        "bank_acc_no": bankNo,
        "bank_routing_no": bankIban,
      },
    );
    closeAllLoading();
    json.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        Navigator.pop(context);
         context.read<HomeSellerCubit>().getShopInfo();
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  changeStepTow(bool value) {
    if (value == true) {
      emit(state.copyWith(stepOne: false , stepTow: true));
    }  else{
    emit(state.copyWith(stepTow: false , stepOne: true));

    }
  }

  withdrawalFunction(BuildContext context) async {
    showBoatToast();
    final json = await DioClient(seller: true).request(
      method: 'POST',
      path: "withdraw-request/store",
      data: {"amount": priceController.text, "message": getUser()!.user!.name},
    );
    closeAllLoading();
    json.handle(
      onSuccess: (data) {
        if (data['status'] == false) {
          showMessage(data['message'], value: false);
        } else {
          showMessage(data['message'], value: true);
        }
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }
}
