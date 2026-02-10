import 'package:fils/core/data/response/order/order_response.dart';
import 'package:fils/core/data/response/order/order_seller_response.dart';
import 'package:fils/core/data/response/order/shipping_address_response.dart';
import 'package:fils/core/domain/reposetry/order/coustomer/order_repo.dart';
import 'package:fils/core/domain/reposetry/order/seller/order_repo.dart';

import '../../../server/result.dart';

class OrderUseCase {
  OrderRepoImpl orderRepoImpl;

  OrderUseCase(this.orderRepoImpl);

  Future<ApiResult<OrderResponse>> getOrder({
    required int page,
    required String url,
  }) async {
    return await orderRepoImpl.getOrder(page: page, url: url);
  }

  Future<ApiResult<Map<String, dynamic>>> createOrder({
    required Map<String, dynamic> body,
  }) async {
    return await orderRepoImpl.createOrder(body: body);
  }

  Future<ApiResult<Map<String, dynamic>>> onlinePayment({
    required String combinedOrderId,
    required String paymentType,
  }) async {
    return await orderRepoImpl.onlinePayment(
      combinedOrderId: combinedOrderId,
      paymentType: paymentType,
    );
  }
}

class OrderSellerUseCase {
  OrderSellerRepoImpl orderSellerRepoImpl;
  OrderSellerUseCase(this.orderSellerRepoImpl);
  Future<ApiResult<OrderSellerResponse>> getOrders(int page) async {
    return await orderSellerRepoImpl.getOrders(page);
  }
    Future<ApiResult<ShippingAddressResponse>> getShppingAddress() async {
    return await orderSellerRepoImpl.getShippingAddress();
  }
}
