import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fils/core/data/response/shops/shops_response.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/attachment_manage.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shops_state.dart';

class ShopsCubit extends Cubit<ShopsState> {
  ShopsCubit() : super(ShopsState());

  Future<void> getAllShops() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result =
          await UserCaseSeller().shopsSellerUseCase.callGetAllShops();

      result.handle(
        onSuccess: (data) {
          if (data.data.data.isEmpty) {
            whereShopEmpty();
           // getInfoPakage();
          } else {
            emit(state.copyWith(isLoading: false, shopsResponse: data));
            setMyShopsDetails(data.data.data.first);

            getInfoPakage();
          }
        },
        onFailed: (message) {
          emit(state.copyWith(isLoading: false));
        },
        onNoInternet: () {
          emit(state.copyWith(isLoading: false));
        },
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void whereShopEmpty() {
    clearFormShop();
    ToWithFade(AppRoutes.formShop);
  }

  clearFormShop() {
    emit(ShopsState.clearAttachment());
  }

  Future<void> functionSelectImage(BuildContext context) async {
    try {
      emit(state.copyWith(shopImage: null, shopImageId: null));
      final result = await pickEditAndUploadImage(
        context: context,
        endpoint: "file/upload",
        fileKey: "aiz_file",
        seller: true,
      );
      if (result != null) {
        emit(
          state.copyWith(shopImage: result.file, shopImageId: result.imageId),
        );
      } else {
        emit(state.copyWith(shopImage: null, shopImageId: null));
      }
    } catch (e) {
      emit(state.copyWith(shopImage: null, shopImageId: null));
    }
  }

  void selectAndUploadFileC() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        emit(state.copyWith(shopLinciseImage: file));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
    }
  }

  Future<void> createShop({required Map<String, dynamic> data}) async {
    emit(state.copyWith(isLoading: true));
    final result = await UserCaseSeller().shopsSellerUseCase
        .callCreateShopsSeller(data: data,
         file: state.shopLinciseImage);

    result.handle(
      onSuccess: (data) {
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
        whenCreateStore();
        emit(state.copyWith(isLoading: false));
        showMessage(data['message'], value: true);
      },
      onFailed: (message) {
        emit(state.copyWith(isLoading: false));
        showMessage(message, value: false);
      },
      onNoInternet: () {
        emit(state.copyWith(isLoading: false));
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  void whenCreateStore() {
    if (getPackageInfo()!.data == null) {
      showMessage(
        "You must subscribe to a package to be able to add products and enjoy the services."
            .tr(),
        value: false,
      );
      ToWithFade(AppRoutes.subscriptionsScreen);
    }
  }

  Future<void> getInfoPakage() async {
    if (getMyShopsDetails().id != 0) {
      NavigationService.navigatorKey.currentContext!
          .read<HomeSellerCubit>()
          .getShopInfo();
    }
    final result =
        await UserCaseSeller().shopsSellerUseCase.packageSellerRepoImpl
            .getPackageInfo();
    result.handle(
      onSuccess: (data) {
        setPackageInfo(data);
        if (data.data == null) {
          whenCreateStore();
        }
      },
    );
  }

  clearAttachment() {
    emit(ShopsState.clearAttachment());
  }
}
