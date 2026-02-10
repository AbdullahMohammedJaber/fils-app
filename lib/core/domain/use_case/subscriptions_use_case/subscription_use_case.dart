import 'package:fils/core/data/response/subscriptions/subscriptions_response.dart';
import 'package:fils/core/domain/reposetry/subscriptions/subscriptions.dart';
import 'package:fils/core/server/result.dart';

class SubscriptionUseCase {
  SubscriptionsRepoImpl subscriptionsRepoImpl;

  SubscriptionUseCase(this.subscriptionsRepoImpl);

  Future<ApiResult<SubscribeResponse>> callSubscription() async {
    return await subscriptionsRepoImpl.getAllSubscriptions();
  }
  Future<ApiResult<Map<String, dynamic>>> paySubscriptions({
    required String packageId,
  })async{
    return await subscriptionsRepoImpl.paySubscriptions(packageId: packageId);
    
  }
}
