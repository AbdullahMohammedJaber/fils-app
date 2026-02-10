import 'package:fils/core/data/response/product/details_product_response.dart';
import 'package:fils/core/server/result.dart';

import '../../reposetry/details_product_repo/details_product_repo.dart';

class DetailsProductUseCase {
  DetailsProductRepo detailsProductRepo;

  DetailsProductUseCase(this.detailsProductRepo);

  Future<ApiResult<DetailsProductResponse>> callDetailsProduct(int id) async {
    return await detailsProductRepo.getDetailsProduct(id);
  }

  Future<ApiResult<Map<String , dynamic>>> addProductCart({
    required int id,
    required int quantity,
    String? name,
  }) async {
    return await detailsProductRepo.addProductCart(
      quantity: quantity,
      id: id,
      name: name,
    );
  }
}
