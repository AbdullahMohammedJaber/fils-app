import 'package:fils/core/server/dio_helper.dart';

import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';
 
abstract class WalletDataSource {
  Future<ApiResult<Map<String, dynamic>>> getWallet();

  Future<ApiResult<Map<String, dynamic>>> getWalletTransaction();

  Future<ApiResult<Map<String, dynamic>>> addMoneyWallet(String value);
}

class WalletDataSourceImpl extends WalletDataSource {
  final DioClient dioClient;

  WalletDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getWallet() async {
    return dioClient.request(path: ApiService.wallet, method: 'GET');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> getWalletTransaction() async {
    return dioClient.request(path: ApiService.walletTransaction, method: 'GET');
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> addMoneyWallet(String value) async {
    return dioClient.request<Map<String, dynamic>>(
      path: ApiService.walletCharge,
      method: 'POST',
      data: {"amount": value, "payment_provider": 'ecom'},
    );
  }
}
