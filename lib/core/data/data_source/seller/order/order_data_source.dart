import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';
import 'package:fils/utils/storage.dart';

abstract class OrderSellerDataSource {
  Future<ApiResult<Map<String, dynamic>>> getOrders(int page);
  Future<ApiResult<Map<String, dynamic>>> getShippingAddress();
}

class OrderSellerDataSourceImpl extends OrderSellerDataSource {
  DioClient dioClient;
  OrderSellerDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> getOrders(int page) async {
    return await dioClient.request(
      path: ApiServiceSeller.orders,
      method: 'GET',
      queryParameters: {"payment_status": "paid", "page": page , "delivery_status": "pending"},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getShippingAddress() async {
    return await dioClient.request(
      path: ApiServiceSeller.listShippingAddress,
      method: 'GET',
      queryParameters: {"shop_id": getMyShopsDetails().id},
    );
  }
}
