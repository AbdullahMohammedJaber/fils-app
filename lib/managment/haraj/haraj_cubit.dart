// ignore_for_file: unused_field, unused_local_variable

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/haraj/details_haraj.dart';
import 'package:fils/core/data/response/haraj/haraj_response.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../utils/global_function/attachment_manage.dart';

part 'haraj_state.dart';

class HarajCubit extends Cubit<HarajState> {
  HarajCubit() : super(HarajState(products: []));

  bool _hasMore = false;
  bool _loading = false;
  int _page = 1;
  List<MarketOpenResponse> _items = [];

  Future<void> getAllHaraj({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(state.copyWith(loading: true));
    } else {
      if (_loading || !_hasMore) return;
    }
    _loading = true;
    final result = await UserCase().harajUserCase.getAllHaraj(page: _page);
    emit(state.copyWith(loading: false));
    _loading = false;

    result.handle(
      onSuccess: (data) {
        final data = result.data;
        _items.addAll(data!.data!);
        _hasMore = data.meta!.currentPage < data.meta!.lastPage;
        _page++;
        emit(state.copyWith(product: List.from(_items), hasMore: _hasMore));
      },
      onFailed: (message) {
        emit(state.copyWith(error: message, loading: false));
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet, loading: false));
      },
    );
  }

  Future<void> getDetailsHaraj(String slug) async {
    emit(
      state.copyWith(
        loadingDetails: true,
        product: state.products,
        productInCategory: state.productInCategory,
      ),
    );
    final result = await UserCase().harajUserCase.getDetailsHaraj(slug: slug);
    result.handle(
      onSuccess: (data) {
        emit(
          state.copyWith(
            loadingDetails: false,
            detailsOpenMarketResponse: data,
            product: state.products,
            productInCategory: state.productInCategory,
          ),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            loadingDetails: false,
            errorDetails: StringApp.noInternet,
            product: state.products,
            productInCategory: state.productInCategory,
          ),
        );
      },
      onFailed: (message) {
        emit(
          state.copyWith(
            loadingDetails: false,
            errorDetails: message,
            product: state.products,
            productInCategory: state.productInCategory,
          ),
        );
      },
    );
  }

  functionChangeCategoryData(String name, int id) {
    emit(state.copyWith(nameCategory: name, idCategory: id));
  }

  functionSelectImage(BuildContext context) async {
    try {
      emit(
        state.copyWith(
          loadingUploadImage: true,
          idImage: null,
          imageProduct: null,
        ),
      );
      final result = await pickEditAndUploadImage(
        context: context,
        endpoint: "file/upload",
        fileKey: "aiz_file",
      );
      if (result != null) {
        emit(
          state.copyWith(
            imageProduct: result.file,
            idImage: result.imageId,
            loadingUploadImage: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            loadingUploadImage: false,
            idImage: null,
            imageProduct: null,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loadingUploadImage: false,
          idImage: null,
          imageProduct: null,
        ),
      );
    }
  }

  removeProductImage() {
    emit(HarajState.clearAttachment(list: state.products));
  }

  Future<void> functionUploadHaraj(
    BuildContext context, {
    required String name,
    required String price,
    required String discount,
    required String quantity,
    required String description,
    required String location,
  }) async {
    emit(state.copyWith(loadingAddHaraj: true));
    final result = await UserCase().harajUserCase.addHaraj(
      harajData: {
        "name": name,
        "brand_id": "1",
        "unit": "PC",
        "tags": [
          "[{\"value\": \"mobile\"}, {\"value\": \"tech\"}, {\"value\": \"fashion\"}]",
        ],
        "photos": "",
        "thumbnail_img": state.idImage,
        "video_provider": "youtube",
        "lang": getLocal() ?? "sa",
        "unit_price": price,
        "discount": discount,
        "discount_type": "percent",
        "current_stock": quantity,
        "description": description,
        "category_id": state.idCategory,
        "location": location,
        "conditon": "used",
      },
    );
    result.handle(
      onSuccess: (data) {
        Navigator.pop(context);
        disposeForm(success: true);
      },
      onFailed: (message) {
        emit(state.copyWith(loadingAddHaraj: false));
        showMessage(message, value: false);
      },
      onNoInternet: () {
        emit(state.copyWith(loadingAddHaraj: false));

        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  disposeForm({bool success = false}) {
    if (success) {
      emit(HarajState.initial(list: state.products));
      getAllHaraj(refresh: true);
    } else {
      emit(HarajState.initial(list: state.products));
    }
  }

  clearList() {
    emit(HarajState.clearList());
  }

  bool _hasMoreHarajInCategory = false;
  bool _loadingHarajInCategory = false;
  int _pageHarajInCategory = 1;
  List<MarketOpenResponse> _itemsHarajInCategory = [];

  Future<void> getHarajInCategory({
    bool refresh = false,
    required int categoryId,
  }) async {
    if (refresh) {
      _pageHarajInCategory = 1;
      _hasMoreHarajInCategory = true;
      _itemsHarajInCategory.clear();
      emit(
        state.copyWith(loadingHarajInCategory: true, product: state.products),
      );
    } else {
      if (_loadingHarajInCategory || !_hasMoreHarajInCategory) return;
    }
    _loadingHarajInCategory = true;
    final result = await UserCase().harajUserCase.getHarajInCategory(
      page: _pageHarajInCategory,
      categoryId: categoryId,
    );
    emit(
      state.copyWith(loadingHarajInCategory: false, product: state.products),
    );
    _loadingHarajInCategory = false;

    result.handle(
      onSuccess: (data) {
        final data = result.data;
        _itemsHarajInCategory.addAll(data!.data!);
        _hasMoreHarajInCategory = data.meta!.currentPage < data.meta!.lastPage;
        _pageHarajInCategory++;
        emit(
          state.copyWith(
            productInCategory: List.from(_itemsHarajInCategory),
            hasMoreHarajInCategory: _hasMoreHarajInCategory,
            product: state.products,
          ),
        );
      },
      onFailed: (message) {
        emit(
          state.copyWith(
            errorHarajInCategory: message,
            loadingHarajInCategory: false,
            product: state.products,
          ),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            errorHarajInCategory: StringApp.noInternet,
            loadingHarajInCategory: false,
            product: state.products,
          ),
        );
      },
    );
  }

  Future<void> deleteHaraj(int id) async {
    showBoatToast();
    final result = DioClient().request(
      path: 'classified/delete/$id',
      method: 'DELETE',
    );
    closeAllLoading();
    Navigator.pop(NavigationService.navigatorKey.currentContext!);
    getAllHaraj(refresh: true);
  }

  @override
  Future<void> close() {
    print('HarajCubit disposed');
    return super.close();
  }
}
