 
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class DetailsProductDataSource {
  Future<ApiResult<Map<String, dynamic>>> getDetailsProduct(int id);

  Future<ApiResult<Map<String, dynamic>>> addProductCart({
    required int id,
    required int quantity,
    String? name,
  });
}

class DetailsProductDataSourceImpl extends DetailsProductDataSource {
  DioClient dioClient;

  DetailsProductDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getDetailsProduct(int id) async {
    return dioClient.request(path: '${ApiService.products}/$id', method: 'GET');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addProductCart({
    required int id,
    required int quantity,
    String? name,
  }) {
    return dioClient.request(
      path: '${ApiService.addCart}?is_auction=0',
      method: 'POST',
      data: {"id": id, if (name != null) "variant": name, "quantity": quantity},
    );
  }
}
