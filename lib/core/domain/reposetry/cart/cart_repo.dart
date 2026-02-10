import 'package:fils/core/data/data_source/customer/cart/cart_data_source.dart';
import 'package:fils/core/data/response/cart/cart_list_response.dart';
import 'package:fils/core/data/response/check_out/payment_methode_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class CartRepo {
  Future<ApiResult<CartListResponse>> getCart(int type);

  Future<ApiResult<Map<String, dynamic>>> deleteItemCart(int id);

  Future<ApiResult<Map<String, dynamic>>> validateCart();
  Future<ApiResult<PaymentMethodResponse>> getPaymentMethode();
  Future<ApiResult<Map<String, dynamic>>> processItemCart({
    required int id,

    required int newQuantity,
  });
}

class CartRepoImpl extends CartRepo {
  CartDataSource cartDataSource;

  CartRepoImpl(this.cartDataSource);

  @override
  Future<ApiResult<CartListResponse>> getCart(int type) async {
    final result = await cartDataSource.getCart(type);
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      final cart = CartListResponse.fromJson(result.data!);
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
  Future<ApiResult<Map<String, dynamic>>> deleteItemCart(int id) async {
    final result = await cartDataSource.deleteItemCart(id);
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

  @override
  Future<ApiResult<Map<String, dynamic>>> processItemCart({
    required int id,
    required int newQuantity,
  }) async {
    final result = await cartDataSource.processItemCart(
      id: id,
      newQuantity: newQuantity,
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

  @override
  Future<ApiResult<Map<String, dynamic>>> validateCart() async {
    final result = await cartDataSource.validateCart();
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

  @override
  Future<ApiResult<PaymentMethodResponse>> getPaymentMethode() async {
    final result = await cartDataSource.getPaymentMethode();
    if (result.isNoInternet) {
      return ApiResult.failed(
        statusCode: result.statusCode,
        message: StringApp.noInternet,
      );
    } else if (result.isSuccess) {
      return ApiResult.success(
        PaymentMethodResponse.fromJson(result.data!),
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
