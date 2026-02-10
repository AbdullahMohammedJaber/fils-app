import 'package:fils/core/data/data_source/customer/order/order_data_source.dart';
import 'package:fils/core/data/response/order/order_response.dart';
import 'package:fils/core/server/result.dart';

import '../../../../../utils/string.dart';

abstract class OrderRepo {
  Future<ApiResult<OrderResponse>> getOrder({
    required String url,
    required int page,
  });
  Future<ApiResult<Map<String, dynamic>>> createOrder({
    required Map<String, dynamic> body,
  });
  Future<ApiResult<Map<String, dynamic>>> onlinePayment({required String combinedOrderId , required String paymentType}) ;
}

class OrderRepoImpl extends OrderRepo {
  OrderDataSourceImpl orderDataSourceImpl;

  OrderRepoImpl(this.orderDataSourceImpl);

  @override
  Future<ApiResult<OrderResponse>> getOrder({
    required String url,
    required int page,
  }) async {
    final result = await orderDataSourceImpl.getOrder(page: page, url: url);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      OrderResponse orderResponse = OrderResponse.fromJson(result.data!);
      return ApiResult.success(orderResponse, statusCode: 200);
    } else {
      return ApiResult.failed(
        message: result.data!['message'],
        statusCode: result.statusCode,
      );
    }
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> createOrder({required Map<String, dynamic> body}) async {
    final result = await orderDataSourceImpl.createOrder(body: body);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(result.data!, statusCode: 200);
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> onlinePayment({required String combinedOrderId, required String paymentType}) async{
    final result = await orderDataSourceImpl.onlinePayment(combinedOrderId: combinedOrderId , paymentType: paymentType);
    if (result.isNoInternet) {
      return ApiResult.noInternet(message: StringApp.noInternet);
    } else if (result.isSuccess) {
      return ApiResult.success(result.data!, statusCode: 200);
    } else {
      return ApiResult.failed(
        message: result.message,
        statusCode: result.statusCode,
      );
    }
  }
}
