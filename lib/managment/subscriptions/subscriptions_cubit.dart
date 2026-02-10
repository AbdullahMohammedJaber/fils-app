import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/subscriptions/subscriptions_response.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/route/app_routes.dart';
import 'package:fils/route/control_route.dart';
import 'package:fils/utils/const.dart';
import 'package:fils/utils/enum_class.dart';
import 'package:fils/utils/string.dart';
import 'package:meta/meta.dart';

part 'subscriptions_state.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  SubscriptionsCubit() : super(SubscriptionsState());

  Future<void> getSubscriptions() async {
    emit(state.copyWith(loading: true));

    final result =
        await UserCaseSeller().subscriptionUseCase.callSubscription();
    emit(state.copyWith(loading: false));
    result.handle(
      onSuccess: (data) {
        emit(state.copyWith(subscribe: List.from(data.data!)));
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet));
      },
      onFailed: (message) {
        emit(state.copyWith(error: message));
      },
    );
  }

  Future<void> paySubscribe(String packageId) async {
    emit(state.copyWith(loadingSubscribe: true));
    final result = await UserCaseSeller().subscriptionUseCase.paySubscriptions(
      packageId: packageId,
    );
    emit(state.copyWith(loadingSubscribe: false));
    result.handle(
      onSuccess: (data) {
        print(result.data!['link']);
        ToWithFade(
          AppRoutes.webViewWallet,
          arguments: [result.data!['link'], PaymentType.pakage],
        );
      },
      onFailed: (message) {
        showMessage(message, value: false);
      },
      onNoInternet: () {
        showMessage(StringApp.noInternet, value: false);
      },
    );
  }
}
