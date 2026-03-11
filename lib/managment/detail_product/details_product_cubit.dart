import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/product/details_product_response.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/managment/app_manage/app_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_product_state.dart';

class DetailsProductCubit extends Cubit<DetailsProductState> {
  DetailsProductCubit() : super(DetailsProductState());

  Future<void> getDetailsProduct(int id) async {
    emit(state.copyWith(loadingDetails: true, error: null));
    final result = await UserCase().detailsProductUserCase.callDetailsProduct(
      id,
    );
    result.handle(
      onSuccess: (data) {
        emit(
          state.copyWith(
            loadingDetails: false,
            error: null,
            detailsProductResponse: data,
          ),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(loadingDetails: false, error: StringApp.noInternet),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(loadingDetails: false, error: message));
      },
    );
  }

  bool goCart = false;
  int countProduct = 1;

  functionPlusCountProduct() {
    if (countProduct <
        state.detailsProductResponse!.data.product.data.currentStock) {
      countProduct++;
      emit(state.copyWith(countItem: countProduct));
    } else {
      showMessage("${"Product Quantity".tr()} $countProduct ", value: false);
    }
  }

  functionMinusCountProduct() {
    if (state.countItem > 1) {
      countProduct--;
      emit(state.copyWith(countItem: countProduct));
    }
  }

  functionChangeTypeCart(bool value) {
    goCart = value;
  }

  Future<void> functionAddCart({required int id}) async {
    if (goCart) {
      emit(state.copyWith(loadingAddCartGoCart: true, loadingAddCart: false));
    } else {
      emit(state.copyWith(loadingAddCartGoCart: false, loadingAddCart: true));
    }

    final result = await UserCase().detailsProductUserCase.addProductCart(
      id: id,
      quantity: state.countItem,
      name: state.nameVariant,
    );
    emit(state.copyWith(loadingAddCart: false, loadingAddCartGoCart: false));
    result.handle(
      onSuccess: (data) {
        if (data['result']) {
          showMessage(data['message'], value: true);
          if (goCart) {
            NavigationService.navigatorKey.currentContext!.read<AppCubit>().onClickBottomNavigationBar(3, NavigationService.navigatorKey.currentContext!.read<AppCubit>().state.selectPageRoot);
            ToRemoveAll(AppRoutes.rootGeneral);
          }
        } else {
          showMessage(data['message'], value: false);
        }
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet.tr(), value: false);
      },
    );
  }

  selectItemSize(String name) {
    emit(state.copyWith(nameVariant: name));
  }
}
