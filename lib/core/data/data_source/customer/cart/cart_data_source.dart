import 'package:fils/core/server/dio_helper.dart';

import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

import 'package:fils/utils/storage.dart';

abstract class CartDataSource {
  Future<ApiResult<Map<String, dynamic>>> getCart(int type);
  Future<ApiResult<Map<String, dynamic>>> deleteItemCart(int id);
  Future<ApiResult<Map<String, dynamic>>> validateCart();
  Future<ApiResult<Map<String, dynamic>>> processItemCart({
    required int id,
    required int newQuantity,
  });

  Future<ApiResult<Map<String, dynamic>>> getPaymentMethode();
}

class CartDataSourceImpl extends CartDataSource {
  final DioClient dioClient;

  CartDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getCart(int type) async {
    return dioClient.request<Map<String, dynamic>>(
      path: "${ApiService.cart}?is_auction=$type",
      method: 'POST',
      data: {"user_id": getUser()!.user!.id},
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> deleteItemCart(int id) async {
    return dioClient.request<Map<String, dynamic>>(
      path: '${ApiService.cart}/$id',
      method: 'DELETE',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> processItemCart({
    required int id,
    required int newQuantity,
  }) async {
    return dioClient.request<Map<String, dynamic>>(
      path: ApiService.cartProcess,
      method: 'POST',
      data: {"cart_ids": "$id", "cart_quantities": "$newQuantity"},
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> validateCart()async {
      return dioClient.request<Map<String, dynamic>>(
      path: ApiService.validateCart,
      method: 'GET',
      
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> getPaymentMethode() async{
    return dioClient.request<Map<String, dynamic>>(
      path: ApiService.paymentMethods,
      method: 'GET',
    );
  }
}
