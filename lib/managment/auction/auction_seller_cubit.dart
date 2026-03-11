// ignore_for_file: unused_field

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fils/core/data/response/auction/auction_seller_response.dart';
import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/attachment_manage.dart';
import 'package:fils/utils/global_function/timer_format.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auction_seller_state.dart';

class AuctionSellerCubit extends Cubit<AuctionSellerState> {
  AuctionSellerCubit() : super(AuctionSellerState());

  bool _loading = true;
  bool _hasMore = true;
  final List<AuctionSeller> _items = [];
  int _page = 1;
  Future<void> fetchAllAuction({bool refresh = false}) async {
    if (refresh) {
      _hasMore = true;
      _page = 1;
      _items.clear();
      emit(state.copyWith(loading: true));
    } else {
      if (_loading || !_hasMore) {
        return;
      }
    }
    _loading = true;
    final result = await UserCaseSeller().auctionSellerUseCase
        .getAllAuctionSeller(page: _page);
    _loading = false;
    emit(state.copyWith(loading: false));
    result.handle(
      onSuccess: (data) {
        _hasMore = data.data.meta.currentPage < data.data.meta.lastPage;
        _page ++ ;
        _items.addAll(data.data.data);
        emit(state.copyWith(hasMore: _hasMore , auctions: List.from(_items)));
      },
      onFailed: (message) {
        emit(state.copyWith(error: message));
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet));
      },
    );
  }

    functionSelectMultiImage(BuildContext context) async {
    try {
      emit(
        state.copyWith(
          loadingUploadImages: true,

          imageProducts: null,
          imageIds: null,
          categoresId: state.categoresId,
        ),
      );
      final result = await pickAndUploadMultiImages(
        context: context,
        endpoint: "file/upload",
        fileKey: "aiz_file",
        seller: true,
      );
      if (result != null) {
        emit(
          state.copyWith(
            loadingUploadImages: false,
            imageProducts: result.map((e) => e.file).toList(),
            imageIds: result.map((e) => e.imageId).toList(),
          ),
        );
      } else {
        emit(
          state.copyWith(
            loadingUploadImages: false,
            imageProducts: null,
            imageIds: null,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loadingUploadImages: false,
          imageProducts: null,
          imageIds: null,
        ),
      );
    }
  }
  changeCategoryData({required int id, required String name}) {
    emit(state.copyWith(idCategory: id, nameCategory: name));
  }

  functionChangeCategoryListData(List<Category> categorys) {
    emit(
      state.copyWith(
        categoresId: categorys.map((e) => int.parse(e.id.toString())).toList(),
        nameCategores: categorys.map((e) => e.name).toList().join(', '),
      ),
    );
  }

    functionSelectImage(BuildContext context) async {
    try {
      emit(state.copyWith(idImage: null, imageProduct: null));
      final result = await pickEditAndUploadImage(
        context: context,
        endpoint: "file/upload",
        fileKey: "aiz_file",
        seller: true
      );
      if (result != null) {
        emit(
          state.copyWith(
            imageProduct: result.file,
            idImage: int.parse(result.imageId),
          ),
        );
      } else {
        emit(state.copyWith(idImage: null, imageProduct: null));
      }
    } catch (e) {
      emit(state.copyWith(idImage: null, imageProduct: null));
    }
  }

  clearAttachment() {
    emit(AuctionSellerState.clearAttachment(
      list: state.auctions!,
      categoresId: state.categoresId,
      idCategory: state.idCategory,
      nameCategores: state.nameCategores,
      nameCategory: state.nameCategory,
    ));
  }

  clearForm() {
    emit(AuctionSellerState.clearForm(list: state.auctions));
  }
   Future<void> addAuction(BuildContext context,{
    required String name,
    required String price,
    required String fee,
    required String descreption,
    required DateTime dataStart,
    required DateTime dataEnd,
    required TimeOfDay timeStart,
    required TimeOfDay timeEnd,
    required String  type,

  }) async {
    if (dataStart.isAfter(dataEnd)) {
      showMessage(
         "The start date cannot be greater than the end date".tr(),
        value: false,
      );
     
    } else {
       List<int > ids = [];
      ids.add(state.idCategory!);
      for (var element in state.categoresId!) {
        ids.add(element);
      }
      emit(state.copyWith(loadingForm: true));
      final result = await UserCaseSeller().auctionSellerUseCase.addAuctionSeller(
        data: {
          "name": name,
          "brand_id": "1", // static
          "unit": "kg", // static
          "weight": "0.5", // static

          "tags": [
            "[{\"value\": \"auction\"}, {\"value\": \"exclusive\"}, {\"value\": \"rare\"}]",
          ],

          "thumbnail_img": state.idImage,
          "starting_bid": price,
          "description": descreption,
          "auction_date_range":
              "${formatDate2(dataStart)} ${formatTimeOfDay2(timeStart)} to ${formatDate2(dataEnd)} ${formatTimeOfDay2(timeEnd)}",
          "category_ids":
              ids.map((e) {
                return e;
              }).toList(),
          "category_id": state.idCategory,
          "auction_type": type,
          "assurance_fee": fee.isEmpty ? "0" : fee,
          "lang": getLocal(),
        },
      );
      emit(state.copyWith(loadingForm: false));

      result.handle(
        onSuccess: (data) {
          clearForm();
          showMessage(data['message'], value: true);
          fetchAllAuction(refresh: true);
        NavigationService.navigatorKey.currentContext!.read<HomeSellerCubit>().getHomeSelerRequest();

          Navigator.pop(context);
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
}
