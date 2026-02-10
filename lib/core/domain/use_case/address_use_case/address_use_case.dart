


import 'package:fils/core/domain/reposetry/address/address_repo.dart';
import 'package:fils/core/server/result.dart';

class AddressUseCase {
  AddressRepositoryImpl addressRepository;
  AddressUseCase(this.addressRepository);

  Future<ApiResult<Map<String, dynamic>>> callGetAddresses() async {
    final result = await addressRepository.getAddresses();
    return result;
  }
}