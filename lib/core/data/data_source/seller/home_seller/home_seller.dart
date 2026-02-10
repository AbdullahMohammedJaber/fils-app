



import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class HomeSellerDataSource {

  Future<ApiResult<Map<String, dynamic>>> getHomeSeller();
}

class HomeSellerDataSourceImpl extends HomeSellerDataSource {
  DioClient dioClient;
  HomeSellerDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> getHomeSeller() async{
    return await dioClient.request(
      method: 'GET',
      path: ApiServiceSeller.home,
    );
   }

}

