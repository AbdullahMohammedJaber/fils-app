
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';
import 'package:fils/utils/storage.dart';

abstract class PackageSellerDataSource {

  Future<ApiResult<Map<String , dynamic>>> getPackageInfo();
}


class PackageSellerDataSourceImpl extends PackageSellerDataSource{
  DioClient dioClient;
  PackageSellerDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> getPackageInfo() async{
    return await dioClient.request(path: "${ApiServiceSeller.packageInfo}/${getUser()!.user!.id}", method: 'GET');
    
    
  }

}