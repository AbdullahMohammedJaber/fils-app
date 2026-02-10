import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/request/order/order_request.dart';

import 'package:fils/core/data/response/cart/cart_list_response.dart';
import 'package:fils/core/data/response/check_out/payment_methode_response.dart';

import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/enum_class.dart';
 import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());

  final key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  functionChangeTapBar(int value) {
    emit(state.copyWith(pageTabBar: value));
    getCart();
  }

  Future<void> getCart() async {
    emit(state.copyWith(loadingCart: true));
    final result = await UserCase().cartUserCase.callCart(
      state.pageTabBar == 1 ? 0 : 1,
    );
    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(loadingCart: false, cartListResponse: data));
      },
      onNoInternet: () {
        emit(
          state.copyWith(loadingCart: false, cartError: StringApp.noInternet),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(loadingCart: false, cartError: message));
      },
    );
  }

  Future<void> deleteItemCart(int id) async {
    emit(state.copyWith(loadingDeleteCart: true));
    final result = await UserCase().cartUserCase.callDeleteItemCart(id);
    emit(state.copyWith(loadingDeleteCart: false));
    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        getCart();
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }

  plusCountItem({
    required int oldQuantity,
    required int newQuantity,
    required int id,
  }) async {
    final result = await UserCase().cartUserCase.callProcessItemCart(
      id: id,
      newQuantity: newQuantity,
    );
    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        getCart();
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }

  minusCountItem({
    required int oldQuantity,
    required int newQuantity,
    required int id,
  }) async {
    if (oldQuantity > 1) {
      final result = await UserCase().cartUserCase.callProcessItemCart(
        id: id,
        newQuantity: newQuantity,
      );
      result.handle(
        onSuccess: (data) {
          showMessage(data['message'], value: true);
          getCart();
        },
        onNoInternet: () {
          showMessage(StringApp.noInternet.tr(), value: false);
        },
        onFailed: (message) {
          showMessage(message, value: false);
        },
      );
    }
  }

  selectItemAddress(int id, String name) {
    emit(state.copyWith(addressId: id, addressName: name));
  }

  changeOrderRequest(OrderRequest orderRequest) {
    emit(state.copyWith(orderRequest: orderRequest));
  }

  Future<void> validateCart(OrderRequest orderRequest) async {
    emit(state.copyWith(loadingValidateCart: true));
    final result = await UserCase().cartUserCase.callValidateCart();
    emit(state.copyWith(loadingValidateCart: false));
    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        checkOutCart();
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }

  Future<void> checkOutCart() async {
    await getPaymentMethode();
  }

  Future<void> getPaymentMethode() async {
    showBoatToast();
    final result = await UserCase().cartUserCase.callGetPaymentMethode();
    closeAllLoading();
    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(paymentMethodResponse: data));
        ToWithFade(AppRoutes.paymentMethode);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }

  selectPaymentMethode(String key) {
    for (var element in state.paymentMethodResponse!.data) {
      element.isSelect = false;
    }
    for (var element in state.paymentMethodResponse!.data) {
      if (element.paymentTypeKey == key) {
        element.isSelect = true;
        emit(state.copyWith(paymentMethode: element));
      }
    }
  }

  Future<void> createOrder() async {
    emit(state.copyWith(loadingValidateCart: true));
    final result = await UserCase().orderUserCase.createOrder(
      body: {
        "payment_type": state.paymentMethode!.paymentTypeKey,
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "address": addressController.text,
        "cityId": state.addressId,
      },
    );
    emit(state.copyWith(loadingValidateCart: false));
    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        if (result.data!['combined_order_id'] != 0) {
          onlinePayment(result.data!['combined_order_id']);
        }
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }

  onlinePayment(int idOrder) async {
    showBoatToast();
    final result = await UserCase().orderUserCase.onlinePayment(
      combinedOrderId: idOrder.toString(),
      paymentType: state.paymentMethode!.paymentTypeKey,
    );

    closeAllLoading();
    result.handle(
      onSuccess: (data) {
        ToRemove(AppRoutes.webViewWallet, arguments: [data['link'], PaymentType.cart]);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
    );
  }
  @override
  Future<void> close() {
    print("CartCubit disposed");
    return super.close();
  }
}
