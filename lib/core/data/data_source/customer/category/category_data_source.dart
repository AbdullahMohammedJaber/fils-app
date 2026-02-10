import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class CategoryDataSource {
  Future<ApiResult<Map<String, dynamic>>> getCategory();
  Future<ApiResult<Map<String, dynamic>>> getSubCategory({required int categoryId});

}

class CategoryDataSourceImpl extends CategoryDataSource {
  DioClient dioClient;

  CategoryDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getCategory() async {
    return dioClient.request(path: ApiService.categories, method: 'GET');
  }
  
  @override
  Future<ApiResult<Map<String, dynamic>>> getSubCategory({required int categoryId}) async{
    return dioClient.request(path: "${ApiService.subCategories}/$categoryId", method: 'GET');

  }
}
