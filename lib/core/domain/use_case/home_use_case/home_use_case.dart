import 'package:dio/dio.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/core/data/response/home/home_seller_response.dart';
import 'package:fils/core/domain/reposetry/home_repo/coustomer/home_repo.dart';
import 'package:fils/core/domain/reposetry/home_repo/seller/home_seller_repo.dart';
import 'package:fils/core/server/result.dart';

import '../../../data/response/home/suggest_product_response.dart';
import '../../../data/response/product/all_products_response.dart';

class HomeUseCase {
  HomeRepo homeRepo;

  HomeUseCase(this.homeRepo);

  Future<ApiResult<HomeResponse>> callGetHome() async {
    return await homeRepo.homeCustomer();
  }

  Future<ApiResult<SuggestProductResponse>> callSuggestProduct({
    required int page,
    required CancelToken cancelToken,
  }) {
    return homeRepo.suggestProduct(page: page, cancelToken: cancelToken);
  }

  Future<ApiResult<AllProductsResponse>> callAllProducts({required int page}) {
    return homeRepo.getAllProducts(page: page);
  }
}




class HomeSellerUseCase {
  final HomeSellerRepo homeSellerRepo;

  HomeSellerUseCase(this.homeSellerRepo);

  Future<ApiResult<HomeSellerResponse>> callGetHomeSeller() async {
    return await homeSellerRepo.getHomeSeller();
  }
}
