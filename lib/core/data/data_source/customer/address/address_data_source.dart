import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class AddressDataSource {
  Future<ApiResult<Map<String, dynamic>>> getAddresses();
}

class AddressDataSourceImpl extends AddressDataSource {
  final DioClient dioClient;

  AddressDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getAddresses() async {
    return await dioClient.request(method: 'GET', path: ApiService.addresses);
  }
}
