import 'package:fils/core/data/response/category/categoryResponse.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

import '../../../data/data_source/customer/category/category_data_source.dart';

abstract class CategoryRepo {
  Future<ApiResult<CategoryResponse>> getCategory();
  Future<ApiResult<CategoryResponse>> getSubCategory({required int categoryId});
}

class CategoryRepoImpl extends CategoryRepo {
  CategoryDataSourceImpl categoryDataSourceImpl;

  CategoryRepoImpl(this.categoryDataSourceImpl);

  @override
  Future<ApiResult<CategoryResponse>> getCategory() async {
    final result = await categoryDataSourceImpl.getCategory();
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    } else {
      CategoryResponse categoryResponse = CategoryResponse.fromJson(
        result.data!,
      );
      return ApiResult.success(categoryResponse, statusCode: 200);
    }
  }

  @override
  Future<ApiResult<CategoryResponse>> getSubCategory({
    required int categoryId,
  }) async {
    final result = await categoryDataSourceImpl.getSubCategory(categoryId: categoryId);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isFailed) {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    } else {
      CategoryResponse categoryResponse = CategoryResponse.fromJson(
        result.data!,
      );
      return ApiResult.success(categoryResponse, statusCode: 200);
    }
  }
}
