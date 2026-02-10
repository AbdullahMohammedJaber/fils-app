import 'package:fils/core/data/data_source/customer/address/address_data_source.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/utils/string.dart';

abstract class AddressRepository {
  Future<ApiResult<Map<String, dynamic>>> getAddresses();
}

class AddressRepositoryImpl extends AddressRepository {
  final AddressDataSource addressDataSource;

  AddressRepositoryImpl(this.addressDataSource);

  @override
  Future<ApiResult<Map<String, dynamic>>> getAddresses() async {
    final result = await addressDataSource.getAddresses();
    if(result.isSuccess){
      return ApiResult.success(result.data!);
    }else if(result.isNoInternet){
      return ApiResult.noInternet(message: StringApp.noInternet);  
    }else{
      return ApiResult.failed(message: result.message!);
    }
  }
}
