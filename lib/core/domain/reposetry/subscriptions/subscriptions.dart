import 'package:fils/core/data/data_source/seller/subscriptions/subscriptions_data_source.dart';
import 'package:fils/core/data/response/subscriptions/subscriptions_response.dart';
import 'package:fils/utils/string.dart';

import '../../../server/result.dart';

abstract class SubscriptionsRepo {
  Future<ApiResult<SubscribeResponse>> getAllSubscriptions();

  Future<ApiResult<Map<String, dynamic>>> paySubscriptions({
    required String packageId,
  });
}

class SubscriptionsRepoImpl extends SubscriptionsRepo {
  SubscriptionsDataSourceImpl subscriptionsDataSourceImpl;

  SubscriptionsRepoImpl(this.subscriptionsDataSourceImpl);

  @override
  Future<ApiResult<SubscribeResponse>> getAllSubscriptions() async {
    final result = await subscriptionsDataSourceImpl.getAllSubscriptions();
    if (result.isSuccess) {
      return ApiResult.success(SubscribeResponse.fromJson(result.data!));
    } else if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }

  @override
  Future<ApiResult<Map<String, dynamic>>> paySubscriptions({
    required String packageId,
  }) async {
    final result = await subscriptionsDataSourceImpl.paySubscriptions(
      packageId: packageId,
    );
    if (result.isSuccess) {
      return ApiResult.success(result.data!);
    } else if (result.isNoInternet) {
      return ApiResult.failed(message: StringApp.noInternet);
    } else {
      return ApiResult.failed(message: result.message);
    }
  }
}
