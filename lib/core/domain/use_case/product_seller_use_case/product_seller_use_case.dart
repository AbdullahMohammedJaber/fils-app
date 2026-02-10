



import 'package:fils/core/data/response/product/all_product_seller.dart';
import 'package:fils/core/data/response/product/attrebute_response.dart';
import 'package:fils/core/data/response/product/color_product.dart';
import 'package:fils/core/data/response/product/details_product_seller.dart';
import 'package:fils/core/domain/reposetry/product_seller/product_seller_repo.dart';
import 'package:fils/core/server/result.dart';

class ProductSellerUseCase {
  ProductSellerRepoImpl productSellerRepo;
  ProductSellerUseCase(this.productSellerRepo); 

  Future<ApiResult<Map<String, dynamic>>> callAddProduct({
    required Map<String, dynamic> data,
  }) async {
    return await productSellerRepo.addProduct(data: data);
  }
    Future<ApiResult<Map<String, dynamic>>> callEditProduct({
    required Map<String, dynamic> data,
    required int id,
  }) async {
    return await productSellerRepo.editProduct(data: data , id: id);
  }
  Future<ApiResult<ProductSellerResponse>> callGetAllProducts({
    required int page,
  }) async {
    return await productSellerRepo.getAllProducts(page: page);
  }
   Future<ApiResult<DetailsProductSellerResponse>> callGetDetailsProducts({
    required int productId,
  }) async {
    return await productSellerRepo.getDetailsProducts(productId: productId);
  }

    Future<ApiResult<Map<String, dynamic>>> callDeleteProduct({
    required int productId,
  }) async {
    return await productSellerRepo.deleteProduct(productId: productId);
  }

   Future<ApiResult<ColorProductResponse>> getColor( ) async {
    return await productSellerRepo.getColor();
  }

   Future<ApiResult<AttrebuteProductResponse>> getSize( ) async {
    return await productSellerRepo.getSize();
  }
}