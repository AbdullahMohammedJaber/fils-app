import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class WalletSellerDataSource {
  Future<ApiResult<Map<String, dynamic>>> getWallet();
}

class WalletSellerDataSourceImpl extends WalletSellerDataSource {
  DioClient dioClient;
  WalletSellerDataSourceImpl(this.dioClient);
  @override
  Future<ApiResult<Map<String, dynamic>>> getWallet() async {
    return await dioClient.request(
      path: ApiServiceSeller.wallet,
      method: 'GET',
    );
  }
}
