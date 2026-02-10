import 'package:fils/core/data/data_source/seller/product_seller/product_data_source.dart';
import 'package:fils/core/data/response/product/all_product_seller.dart';
import 'package:fils/core/data/response/product/attrebute_response.dart';
import 'package:fils/core/data/response/product/color_product.dart';
import 'package:fils/core/data/response/product/details_product_seller.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class ProductSellerRepo {
  Future<ApiResult<Map<String, dynamic>>> addProduct({
    required Map<String, dynamic> data,
  });
  Future<ApiResult<Map<String, dynamic>>> editProduct({
    required Map<String, dynamic> data,
    required int  id,

  });

  Future<ApiResult<ProductSellerResponse>> getAllProducts({
    required int page,
  });
   Future<ApiResult<DetailsProductSellerResponse>> getDetailsProducts({
    required int productId
  });
     Future<ApiResult<Map<String, dynamic>>> deleteProduct({
    required int productId
  });
   Future<ApiResult<ColorProductResponse>> getColor( );
   Future<ApiResult<AttrebuteProductResponse>> getSize( );
}

class ProductSellerRepoImpl implements ProductSellerRepo {
  ProductSellerDataSourceImpl productSellerDataSource;
  ProductSellerRepoImpl(this.productSellerDataSource);
  @override
  Future<ApiResult<Map<String, dynamic>>> addProduct({
    required Map<String, dynamic> data,
  }) async {
    final result =await productSellerDataSource.addProduct(data: data);
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if 
    (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);

    }
    else{
      return ApiResult.success(result.data!);
    }
  }
  @override
  Future<ApiResult<Map<String, dynamic>>> editProduct({
    required Map<String, dynamic> data,
    required int id,

  }) async {
    final result =await productSellerDataSource.editProduct(data: data , id: id);
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if 
    (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);

    }
    else{
      return ApiResult.success(result.data!);
    }
  }
  @override
  Future<ApiResult<ProductSellerResponse>> getAllProducts({required int page}) async{
    final result = await productSellerDataSource.getAllProduct(page: page);
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);
    }
    else{
      return ApiResult.success(ProductSellerResponse.fromJson(  result.data!));
    }
  }
  
  @override
  Future<ApiResult<DetailsProductSellerResponse>> getDetailsProducts({required int productId}) async{
  final result = await productSellerDataSource.getDetailsProduct( productId: productId);
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);
    }
    else{
      return ApiResult.success(DetailsProductSellerResponse.fromJson(  result.data!));
    }
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> deleteProduct({required int productId}) async{
    final result = await productSellerDataSource.deleteProduct( productId: productId);
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);
    }
    else{
      return ApiResult.success(   result.data! );
    }
  }
  
  @override
  Future<ApiResult<ColorProductResponse>> getColor() async{
    final result = await productSellerDataSource.getColor( );
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);
    }
    else{
      return ApiResult.success(  ColorProductResponse.fromJson( result.data!) );
    }
  }
  
  @override
  Future<ApiResult<AttrebuteProductResponse>> getSize() async{
    final result = await productSellerDataSource.getSize( );
    if(result.isFailed){
      return ApiResult.failed(message: result.message);
    }
    else if (result.isNoInternet){
      return ApiResult.failed(message: StringApp.noInternet);
    }
    else{
      return ApiResult.success(  AttrebuteProductResponse.fromJson( result.data!) );
    }
  }
}
