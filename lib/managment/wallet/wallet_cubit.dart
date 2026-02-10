import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/features/coustamer/wallet/done_pay.dart';
import 'package:fils/managment/cart/cart_cubit.dart';
import 'package:fils/managment/shops/shops_cubit.dart';
import 'package:fils/managment/wallet/wallet_state.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';
 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletState());

  Future<void> getWallet() async {
    emit(state.copyWith(isLoadingWallet: true, walletError: null));
    final result = await UserCase().walletUserCase.callWallet();
    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(isLoadingWallet: false, balance: data));
        setBalance(double.parse(data.data!.balance!));
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            isLoadingWallet: false,
            walletError: StringApp.noInternet,
          ),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(isLoadingWallet: false, walletError: message));
      },
    );
  }

  Future<void> getWalletTransaction() async {
    emit(state.copyWith(isLoadingTransaction: true, transactionError: null));
    final result = await UserCase().walletUserCase.callWalletTransaction();

    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(isLoadingTransaction: false, transactions: data));
      },
      onFailed: (message) {
        emit(
          state.copyWith(
            isLoadingTransaction: false,
            transactionError: message,
          ),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            isLoadingTransaction: false,
            transactionError: StringApp.noInternet,
          ),
        );
      },
    );
  }

  Future<bool> addMoneyWallet(String value) async {
    bool success = false;
    emit(state.copyWith(isLoadingAddMoneyWallet: true));
    final result = await UserCase().walletUserCase.addMoneyWallet(value);
    emit(state.copyWith(isLoadingAddMoneyWallet: false));

    result.handle(
      onSuccess: (data) {
        success = true;
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        ToWithFade(AppRoutes.webViewWallet, arguments: [data['link'], PaymentType.wallet]);
      },
      onFailed: (message) {
        success = false;
        showMessage(message, value: false);
      },
      onNoInternet: () {
        success = false;
        showMessage(StringApp.noInternet, value: false);
      },
    );
    return success;
  }

  Future<bool> functionWebView({
    required String url,
    PaymentType paymentType = PaymentType.cart,
  }) async {
    final DioClient dioClient = DioClient();
    bool success = false;
    Navigator.pop(NavigationService.navigatorKey.currentContext! );
    showBoatToast();
    final response = await dioClient.request(path: url, method: 'GET');
    closeAllLoading();
    if (response.statusCode == 200) {
      if (paymentType == PaymentType.auction || paymentType == PaymentType.wallet) {
        showMessage("Done".tr(), value: true);
        getWallet();
        success = true;
      } else if(paymentType == PaymentType.cart){
        NavigationService.navigatorKey.currentContext!
            .read<CartCubit>()
            .getCart();
        

        showModalBottomSheet(
          context: NavigationService.navigatorKey.currentContext!,
          elevation: 1,
          isDismissible: true,
          isScrollControlled: true,
          backgroundColor: white,
          constraints: BoxConstraints(maxHeight: heigth * 0.6),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          builder: (context) {
            return const donePay();
          },
        );
        success = true;
      }else if(paymentType == PaymentType.pakage){
         showMessage("Done".tr(), value: true);
         NavigationService.navigatorKey.currentContext!.read<ShopsCubit>().getInfoPakage();
         success = true;
      }
    } else {
      success = false;

      showModalBottomSheet(
        context: NavigationService.navigatorKey.currentContext!,
        elevation: 1,
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: white,
        constraints: BoxConstraints(maxHeight: heigth * 0.6),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (context) {
          return const faieldPay();
        },
      );
    }
    return success;
  }
}
