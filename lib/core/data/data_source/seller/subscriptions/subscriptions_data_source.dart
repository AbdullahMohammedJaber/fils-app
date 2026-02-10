import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';

abstract class SubscriptionsDataSource {
  Future<ApiResult<Map<String, dynamic>>> getAllSubscriptions();

  Future<ApiResult<Map<String, dynamic>>> paySubscriptions({
    required String packageId,
  });
}

class SubscriptionsDataSourceImpl extends SubscriptionsDataSource {
  DioClient dioClient;

  SubscriptionsDataSourceImpl(this.dioClient);

  @override
  Future<ApiResult<Map<String, dynamic>>> getAllSubscriptions() async {
    return await dioClient.request(
      path: ApiServiceSeller.packages,
      method: 'GET',
    );
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> paySubscriptions({
    required String packageId,
  }) async {
    return await dioClient.request(
      path: ApiServiceSeller.payPackages,
      method: 'POST',
      data: {"package_id": packageId, "payment_provider": "ecom"},
    );
  }
}
