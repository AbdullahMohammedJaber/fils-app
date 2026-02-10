import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/home/home_response.dart';
import 'package:fils/core/server/dio_helper.dart';

import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/storage.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()){
    if(isLogin()){
    updateFcmToken();

    }
  }

  Future<void> getHomeRequest() async {
    emit(HomeLoading());

    final result = await UserCase().homeUserCase.callGetHome();

    result.handle(
      onSuccess: (data) {
        emit(HomeSuccess(homeResponse: data));
      },
      onFailed: (message) {
        emit(HomeUnknownError());
      },
      onNoInternet: () {
        emit(HomeNoInternet());
      },
    );
  }

  Future<void> updateFcmToken() async {
    DioClient dioClient = DioClient(seller: false);
    if (isLogin() && getFcmToken() != null) {
      await dioClient.request(
        method: 'POST',
        path: "profile/update-device-token",
        data: {"device_token": getFcmToken(), "user_timezone": getTimeZoon()},
      );
    }
  }

  @override
  Future<void> close() {
    print("HomeCubit disposed");
    return super.close();
  }
}
