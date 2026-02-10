// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/data/response/product/all_product_seller.dart';
import 'package:fils/core/data/response/product/attrebute_response.dart';
import 'package:fils/core/data/response/product/color_product.dart';
import 'package:fils/core/data/response/product/details_product_seller.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/attachment_manage.dart';
import 'package:fils/utils/global_function/number_format.dart';
import 'package:fils/utils/navigation_service/navigation_server.dart';
import 'package:fils/utils/setting_ui/loading_ui.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_seller_state.dart';

class ProductSellerCubit extends Cubit<ProductSellerState> {
  ProductSellerCubit() : super(ProductSellerState());

  clearForm() {
    emit(ProductSellerState.initial(products: state.products));
  }

  functionChangeCategoryData(String name, int id) {
    emit(state.copyWith(nameCategory: name, idCategory: id));
  }

  functionChangeCategoryListData(List<Category> categorys) {
    emit(
      state.copyWith(
        categoryIds: categorys.map((e) => int.parse(e.id.toString())).toList(),
        nameCategores: categorys.map((e) => e.name).toList().join(', '),
      ),
    );
  }

  

  removeProductImage() {
    emit(
      ProductSellerState.clearAttachment(
        categoryIds: state.categoryIds,
        nameCategores: state.nameCategores,
        idCategory: state.idCategory,
        nameCategory: state.nameCategory,
        colorSelect: state.colorSelect,
        sizeLSelect: state.sizeSelect,
      ),
    );
  }

  functionSelectImage(BuildContext context) async {
    try {
      emit(
        state.copyWith(
          loadingUploadImage: true,
          idImage: null,
          imageProduct: null,
          categoryIds: state.categoryIds,
        ),
      );
      final result = await pickEditAndUploadImage(
        context: context,
        endpoint: "file/upload",
        fileKey: "aiz_file",
        seller: true,
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

  changeTyoeSelectColor(bool value) {
    if (value == true && state.colorList == null) {
      getColorList();
    }
    emit(state.copyWith(selectColor: value));
  }

  changeTyoeSelectSize(bool value) {
    if (value == true && state.sizeList == null) {
      getSizeList();
    }

    emit(state.copyWith(selectSize: value));
  }

  Future<void> getColorList() async {
    showBoatToast();
    final result = await UserCaseSeller().productSellerUseCase.getColor();
    closeAllLoading();

    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(colorList:List.from(data.data) ));
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }

  Future<void> getSizeList() async {
    showBoatToast();
    final result = await UserCaseSeller().productSellerUseCase.getSize();
    closeAllLoading();

    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(sizeList:List.from(data.data[0].values) ));

      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }
 selectColorId(ColorProduct color) {
    dynamic index = state.colorSelect.indexWhere((element) => element.id == color.id);

    if (index != -1) {

      state.colorSelect[index].isSelect = false;
      state.colorSelect.removeAt(index);
      emit(state.copyWith(colorSelect: state.colorSelect ));
    } else {
      color.isSelect = true;
      state.colorSelect.add(color);
      emit(state.copyWith(colorSelect: state.colorSelect ));

    }
     
    
  }
 selectSizeId(Value size) {
    dynamic index = state.sizeSelect.indexWhere((element) => element.id == size.id);

    if (index != -1) {
      state.sizeSelect[index].isSelect = false;
      state.sizeSelect.removeAt(index);
    } else {
      size.isSelect = true;
      state.sizeSelect.add(size);
    }
   emit(state.copyWith(sizeSelect: state.sizeSelect ));
  }

  Future<void> addProduct(
    BuildContext context, {
    required String name,
    required String description,
    required String price,
    required String discount,
    required String quantity,
  }) async {
    List<int> _categoryIds = state.categoryIds;
    _categoryIds.add(state.idCategory ?? 0);
    emit(state.copyWith(loading: true, categoryIds: _categoryIds));

    final result = await UserCaseSeller().productSellerUseCase.callAddProduct(
      data: {
        "name": name,

        "tags": ["[{\"value\": \"$name\"}]"],
        "thumbnail_img": state.idImage,
        "shop_id": getMyShopsDetails().id,

        "description": description,
        "low_stock_quantity": "1",
        "stock_visibility_state": "quantity",
        "cash_on_delivery": "1",
        "est_shipping_days": null,
       "colors_active": state.colorSelect.isNotEmpty ? "1" : "0",
        "colors":
           state. colorSelect.isNotEmpty
                ? state.colorSelect.map((e) {
                  return e.code;
                }).toList()
                : [],
        "choice_attributes": state.sizeSelect.isNotEmpty ? ["1"] : [],
        "choice_no": state.sizeSelect.isNotEmpty ? ["1"] : [],
        "choice": state.sizeSelect.isNotEmpty ? ["Size"] : [],
        if (state.sizeSelect.isNotEmpty)
          "choice_options_1":
              state.sizeSelect.map((e) {
                return e.value;
              }).toList(),

        "unit_price": price,
        "date_range": null,
        "discount": discount.isEmpty ? 0 : extractDouble(discount),
        "discount_type": "percent",
        "current_stock": quantity,
        "category_ids":
            state.categoryIds.map((e) {
              return e;
            }).toList(),
        "category_id": state.idCategory,
        "auction_type": "normal",
        "min_qty": "1",
        "lang": getLocal() ?? "sa",
      },
    );
    emit(state.copyWith(loading: false));

    result.handle(
      onSuccess: (data) {
        showMessage(result.data!['message'], value: true);
        clearForm();
        Navigator.pop(context);
        getAllProduct(refresh: true);
        NavigationService.navigatorKey.currentContext!.read<HomeSellerCubit>().getHomeSelerRequest();
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage("No Internet Connection", value: false);
      },
    );
  }

  bool _loading = true;
  bool _hasMore = true;
  int _page = 1;
  List<ProductSeller> _products = [];
  Future<void> getAllProduct({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _products.clear();
      emit(state.copyWith(loadingGetAllProduct: true , error: null));
    } else {
      if (!_hasMore || _loading) {
        return;
      }
    }
    _loading = true;
    final result = await UserCaseSeller().productSellerUseCase
        .callGetAllProducts(page: _page);
    result.handle(
      onSuccess: (data) {
        _products.addAll(data.data.data);
        _hasMore = data.data.meta.currentPage < data.data.meta.lastPage;
        _page++;
        emit(
          state.copyWith(
            loadingGetAllProduct: false,
            products: List.from(_products),
            hasMore: _hasMore,
            error: null,
          ),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(loadingGetAllProduct: false, error: message));
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            loadingGetAllProduct: false,
            error: StringApp.noInternet,
          ),
        );
      },
    );
    _loading = false;
  }

  Future<void> getDetailsProduct(int idProduct) async {
    emit(state.copyWith(loadingGetDetailsProduct: true));

    final result = await UserCaseSeller().productSellerUseCase
        .callGetDetailsProducts(productId: idProduct);
    result.handle(
      onSuccess: (data) {
        emit(
          state.copyWith(
            loadingGetDetailsProduct: false,
            detailsProductSellerResponse: data,
          ),
        );
      },
      onFailed: (message) {
        emit(
          state.copyWith(
            loadingGetDetailsProduct: false,
            errorDetails: message,
          ),
        );
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            loadingGetDetailsProduct: false,
            errorDetails: StringApp.noInternet,
          ),
        );
      },
    );
  }

  Future<void> deleteProduct(int productId) async {
    emit(state.copyWith(loading: true));

    final result = await UserCaseSeller().productSellerUseCase
        .callDeleteProduct(productId: productId);
    emit(state.copyWith(loading: false));
    result.handle(
      onSuccess: (data) {
        showMessage(data['message'], value: true);
        getAllProduct();
        NavigationService.navigatorKey.currentContext!
            .read<HomeSellerCubit>()
            .getHomeSelerRequest();
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
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
