import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class OrderDataSource {
  Future<ApiResult<Map<String, dynamic>>> getOrder({
    required String url,
    required int page,
  });

  Future<ApiResult<Map<String, dynamic>>> createOrder({
    required Map<String, dynamic> body,
  });

  Future<ApiResult<Map<String, dynamic>>> onlinePayment({required String combinedOrderId , required String paymentType}) ;
}

class OrderDataSourceImpl extends OrderDataSource {
  DioClient dioClient;

  OrderDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getOrder({
    required String url,
    required int page,
  }) async {
    return await dioClient.request(path: '$url&page=$page', method: 'GET');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> createOrder({
    required Map<String, dynamic> body,
  }) async {
    return await dioClient.request(
      path: ApiService.createOrder,
      method: 'POST',
      data: body,
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> onlinePayment({required String combinedOrderId , required String paymentType}) async{
    return await dioClient.request(
      method: 'GET',
      path: ApiService.onlinePayment,
      data: {
        "combined_order_id" : combinedOrderId,
        "payment_option" : paymentType,
      }
    );
  }
}
