import 'package:fils/core/data/data_source/customer/details_product/details_product_data_source.dart';
import 'package:fils/core/data/response/product/details_product_response.dart';
import 'package:fils/core/server/result.dart';

import '../../../../utils/string.dart';

abstract class DetailsProductRepo {
  Future<ApiResult<DetailsProductResponse>> getDetailsProduct(int id);

  Future<ApiResult<Map<String, dynamic>>> addProductCart({
    required int id,
    required int quantity,
    String? name,
  });
}

class DetailsProductRepoImpl extends DetailsProductRepo {
  DetailsProductDataSource detailsProductDataSource;

  DetailsProductRepoImpl(this.detailsProductDataSource);

  @override
  Future<ApiResult<DetailsProductResponse>> getDetailsProduct(int id) async {
    final result = await detailsProductDataSource.getDetailsProduct(id);

    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      final cart = DetailsProductResponse.fromJson(result.data!);
      return ApiResult.success(
        cart,
        message: result.message,
        statusCode: result.statusCode,
      );
    }

    return ApiResult.failed(
      statusCode: result.statusCode,
      message: result.message,
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addProductCart({
    required int id,
    required int quantity,
    String? name,
  }) async {
    final result = await detailsProductDataSource.addProductCart(
      id: id,
      quantity: quantity,
      name: name,
    );

    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        result.data!,
        message: result.message,
        statusCode: result.statusCode,
      );
    }

    return ApiResult.failed(
      statusCode: result.statusCode,
      message: result.message,
    );
  }
}
