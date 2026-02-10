// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/data/response/product/attrebute_response.dart';
import 'package:fils/core/data/response/product/color_product.dart';
import 'package:fils/core/data/response/product/details_product_seller.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/managment/category/category_cubit.dart';
import 'package:fils/managment/home/home_seller_cubit.dart';
import 'package:fils/managment/product/seller/product_seller_cubit.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/global_function/attachment_manage.dart';
import 'package:fils/utils/global_function/number_format.dart';
import 'package:fils/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  EditProductCubit() : super(EditProductState());

  fillForm(
    BuildContext context,
    DetailsProductSeller detailsProductSellerResponse,
  ) async {
    List<Category> _category = [];
    await context.read<CategoryCubit>().functionFetchCategory();
    for (var element
        in context.read<CategoryCubit>().state.categoryResponse!.data) {
      if (element.id == detailsProductSellerResponse.categoryId) {
        emit(
          state.copyWith(idCategory: element.id, nameCategory: element.name),
        );
      }
    }
    Future.delayed(Duration(seconds: 1), () async {
      await context.read<CategoryCubit>().functionFetchSubCategory(
        categoryId: state.idCategory!,
      );
      for (var element
          in context.read<CategoryCubit>().state.categoryResponse!.data) {
        if (detailsProductSellerResponse.categoryIds.contains(element.id)) {
          _category.add(element);
        }
      }
      functionChangeCategoryListData(_category);
    });

    emit(
      state.copyWith(
        urlImage: detailsProductSellerResponse.thumbnailImg.data[0].url,
        idImage: int.parse(detailsProductSellerResponse.thumbnailImg.data[0].id.toString()),
      ),
    );
    initOption(detailsProductSellerResponse);
  }
 List<ColorProduct> colorSelect = [];
  List<ColorProduct> colorList = [];
 
  List<Value> sizeSelect = [];
  List<Value> sizeList = [];
   initOption(DetailsProductSeller detailsProductSellerResponse) {
    int lengthColor = detailsProductSellerResponse.colors.length;
    int lengthChoiceOptions = detailsProductSellerResponse.choiceOptions[0].values.length;
    if (lengthColor != 0) {
    
      colorSelect = [];
      for (var element in detailsProductSellerResponse.colors) {
        colorSelect.add(
          ColorProduct(id: element, code: element, name: element),
        );
      }
    }
    if (lengthChoiceOptions != 0) {
    
      sizeSelect = [];
      for (var element
          in detailsProductSellerResponse.choiceOptions[0].values) {
        sizeSelect.add(
          Value(
            id: element,
            value: element,
            attributeId: element,
            colorCode: element,
          ),
        );
      }
    }
 
    
  }
  clearAttachment() {
    emit(
      EditProductState.clearAttachment(
        categoryIds: state.categoryIds,
        idCategory: state.idCategory,
        nameCategores: state.nameCategores,
        nameCategory: state.nameCategory,
      ),
    );
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

  functionSelectImage(BuildContext context) async {
    try {
      emit(
        state.copyWith(
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

  Future<void> editProduct(
    BuildContext context, int id , {
    required String name,
    required String description,
    required String price,
    required String discount,
    required String quantity,
  }) async {
    List<int> _categoryIds = state.categoryIds!;
    _categoryIds.add(state.idCategory ?? 0);
    emit(state.copyWith(loading: true, categoryIds: _categoryIds));

    final result = await UserCaseSeller().productSellerUseCase.callEditProduct(
      id: id,
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
        "colors_active":  colorSelect.isNotEmpty ? "1" : "0",
        "colors":
             colorSelect.isNotEmpty
                ?  colorSelect.map((e) {
                  return e.code;
                }).toList()
                : [],
        "choice_attributes":  sizeSelect.isNotEmpty ? ["1"] : [],
        "choice_no":  sizeSelect.isNotEmpty ? ["1"] : [],
        "choice":  sizeSelect.isNotEmpty ? ["Size"] : [],
        if ( sizeSelect.isNotEmpty)
          "choice_options_1":
              sizeSelect.map((e) {
                return e.value;
              }).toList(),

        "unit_price": price,
        "date_range": null,
        "discount": discount.isEmpty ? 0 : extractDouble(discount),
        "discount_type": "percent",
        "current_stock": quantity,
        "category_ids":
            state.categoryIds!.map((e) {
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

        Navigator.pop(context);
        context.read<ProductSellerCubit>().getAllProduct(refresh: true);
        context.read<HomeSellerCubit>().getHomeSelerRequest();

      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage("No Internet Connection", value: false);
      },
    );
  }
}
