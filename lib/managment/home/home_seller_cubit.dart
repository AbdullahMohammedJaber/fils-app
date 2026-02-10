import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fils/core/data/response/home/home_seller_response.dart';
import 'package:fils/core/data/response/report/report_response.dart';
import 'package:fils/core/server/dio_helper.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/utils/storage.dart';
import 'package:fils/utils/string.dart';
import 'package:fils/utils/theme/color_manager.dart';

part 'home_seller_state.dart';

class HomeSellerCubit extends Cubit<HomeSellerState> {
  HomeSellerCubit() : super(HomeSellerInitial()) {
    if (isLogin()) {
      updateFcmToken();
      if (getMyShopsDetails().id != 0) {
        getShopInfo();
      }
       _fetchData();
    }
  }

  Future<void> getHomeSelerRequest() async {
    emit(HomeLoadingSeller());

    final result = await UserCaseSeller().homeSellerUseCase.callGetHomeSeller();

    result.handle(
      onSuccess: (data) {
        emit(HomeSuccessSeller(homeResponse: data));
      },
      onFailed: (message) {
        emit(HomeUnknownErrorSeller(error: message));
      },
      onNoInternet: () {
        emit(HomeNoInternetSeller(error: StringApp.noInternet));
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

  Future<void> getShopInfo() async {
    final result =
        await UserCaseSeller().shopsSellerUseCase.shopsSellerRepoImpl
            .getShopsSellerInfo();
    result.handle(
      onSuccess: (data) {
        setShopInfo(data);
      },
    );
  }

  Data? data;

  List<Map<String, dynamic>> reportList = [];
  _fetchData() async {
    final json = await DioClient(
      seller: true,
    ).request(method: 'GET', path: "dashboard/dashboard-counters");

    ReportsResponse reportsResponse = ReportsResponse.fromJson(json.data);
    data = reportsResponse.data;
    reportList.add({
      'name': "Total Orders",
      "value": data!.totalOrders,
      "color": moveH,
    });
    reportList.add({
      'name': "Paid Orders",
      "value": data!.paidOrders,
      "color": blueH,
    });
    reportList.add({
      'name': "Delivered Orders",
      "value": data!.deliveredOrders,
      "color": orangeH,
    });
    reportList.add({
      'name': "Canceled Orders",
      "value": data!.canceledOrders,
      "color": nahdiH,
    });
    reportList.add({
      'name': "Products",
      "value": data!.products,
      "color": zaherH,
    });
    reportList.add({
      'name': "Total Sales",
      "value": int.parse(data!.totalSales),
      "color": kohliH,
    });
  }
}
