import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class ProductSellerDataSource {
  Future<ApiResult<Map<String, dynamic>>> addProduct({
    required Map<String, dynamic> data,
  });
  Future<ApiResult<Map<String, dynamic>>> editProduct({
    required Map<String, dynamic> data,
    required int  id,

  });
  Future<ApiResult<Map<String, dynamic>>> getAllProduct({required int page});
  Future<ApiResult<Map<String, dynamic>>> getDetailsProduct({required int productId});
  Future<ApiResult<Map<String, dynamic>>> deleteProduct({required int productId});
  Future<ApiResult<Map<String, dynamic>>> getColor( );
  Future<ApiResult<Map<String, dynamic>>> getSize( );

  

}

class ProductSellerDataSourceImpl implements ProductSellerDataSource {
  DioClient dioClient;
  ProductSellerDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> addProduct({
    required Map<String, dynamic> data,
  }) async {
    return await dioClient.request(
      path: ApiServiceSeller.productsAdd,
      method: 'POST',
      data: data,
    );
  }
  @override
  Future<ApiResult<Map<String, dynamic>>> editProduct({
    required Map<String, dynamic> data,
    required int id,
  }) async {
    return await dioClient.request(
      path: "${ApiServiceSeller.productsEdit}/$id",
      method: 'POST',
      data: data,
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getAllProduct({
    required int page,
  }) async {
    return await dioClient.request(
      path: ApiServiceSeller.allProduct,
      method: 'GET',
      queryParameters: {'page': page},
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> getDetailsProduct({required int productId}) async{
    return await dioClient.request(
      path:"${ApiServiceSeller.detailsProductSeller}/$productId",
      method: 'GET',
      
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> deleteProduct({required int productId})async {
   return await dioClient.request(
      path:"${ApiServiceSeller.deleteProduct}/$productId",
      method: 'GET',
      
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> getColor() async{
     return await dioClient.request(
      path:ApiServiceSeller.colorList,
      method: 'GET',
      
    );
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> getSize() async{
     return await dioClient.request(
      path:ApiServiceSeller.sizeList,
      method: 'GET',
      
    );
  }
}
