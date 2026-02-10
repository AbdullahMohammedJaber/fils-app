 
import 'package:fils/core/data/data_source/seller/order/order_data_source.dart';
import 'package:fils/core/data/response/order/order_seller_response.dart';
import 'package:fils/core/data/response/order/shipping_address_response.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class OrderSellerRepo {
  Future<ApiResult<OrderSellerResponse>> getOrders(int page);
  Future<ApiResult<ShippingAddressResponse>> getShippingAddress();

}

class OrderSellerRepoImpl extends OrderSellerRepo{
  OrderSellerDataSourceImpl orderDataSourceImpl;
  OrderSellerRepoImpl(this.orderDataSourceImpl);
  @override
  Future<ApiResult<OrderSellerResponse>> getOrders(int page) async{
     final result = await orderDataSourceImpl.getOrders(page);
     if(result.isFailed){
      return ApiResult.failed(message: result.message);
     }
     else if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
     }else{
      return ApiResult.success(OrderSellerResponse.fromJson(result.data!));
     }
  }
  
  @override
  Future<ApiResult<ShippingAddressResponse>> getShippingAddress()async {
     final result = await orderDataSourceImpl.getShippingAddress();
     if(result.isFailed){
      return ApiResult.failed(message: result.message);
     }
     else if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);
     }else{
      return ApiResult.success(ShippingAddressResponse.fromJson(result.data!));
     }
  }

}