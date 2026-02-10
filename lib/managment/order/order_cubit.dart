import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/order/order_response.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderState());

  void changePageTapBar(int index) {
    emit(state.copyWith(pageTapBar: index));
    getOrder(refresh: true);
  }

  String getUrl() {
    switch (state.pageTapBar) {
      case 1:
        return "purchase-history?delivery_status=pending&payment_status=paid";
      case 2:
        return "purchase-history?delivery_status=delivered&payment_status=paid";
      case 3:
        return "purchase-history?delivery_status=cancelled";
      case 4:
        return "purchase-history?delivery_status=pending&payment_status=unpaid";
      default:
        return "purchase-history?delivery_status=pending&payment_status=paid";
    }
  }

  int _page = 1;
  bool _loading = true;
  bool _hasMore = true;
  List<Orders> _items = [];

  Future<void> getOrder({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(state.copyWith(loading: true));
    } else {
      if (_loading || !_hasMore) return;
    }
    _loading = true;
    final result = await UserCase().orderUserCase.getOrder(
      page: _page,
      url: getUrl(),
    );
    _loading = false;
    emit(state.copyWith(loading: _loading));
    result.handle(
      onSuccess: (data) {
        _hasMore = data.meta.currentPage < data.meta.lastPage;
        _items.addAll(data.data);
        _page++;
        emit(state.copyWith(orderList: List.from(_items), hasMore: _hasMore));
      },
      onNoInternet: () {
        emit(state.copyWith(error: StringApp.noInternet));
      },
      onFailed: (message) {
        emit(state.copyWith(error: message));
      },
    );
  }
}
