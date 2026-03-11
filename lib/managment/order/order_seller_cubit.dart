import 'package:bloc/bloc.dart';
import 'package:fils/core/data/response/order/order_seller_response.dart';
import 'package:fils/core/data/response/order/shipping_address_response.dart';
import 'package:fils/core/user_case_state/seller/use_case_seller_state.dart';
import 'package:fils/utils/string.dart';
part 'order_seller_state.dart';

class OrderSellerCubit extends Cubit<OrderSellerState> {
  OrderSellerCubit() : super(OrderSellerState()) {
    initOrder();
  }

  initOrder() {
    emit(OrderSellerState.clearList());
  }

  bool _loading = true;
  bool _hasMore = true;
  int _page = 1;
  final List<OrderSeeler> _items = [];
  Future<void> getOrders({refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _items.clear();
      emit(state.copyWith(loading: true, error: null));
    } else {
      if (!_hasMore || _loading) {
        return;
      }
    }
    _loading = true;
    final result = await UserCaseSeller().orderSellerUseCase.getOrders(_page);
    result.handle(
      onSuccess: (data) {
        _items.addAll(data.data!.data!);
        _hasMore = data.data!.meta!.currentPage! < data.data!.meta!.lastPage!;
        _page++;
        emit(
          state.copyWith(
            loading: false,
            listOrder: List.from(_items),
            hasMore: _hasMore,
            error: null,
          ),
        );
      },
      onFailed: (message) {
        emit(state.copyWith(loading: false, error: message));
      },
      onNoInternet: () {
        emit(
          state.copyWith(
            loading: false,
            error: StringApp.noInternet,
          ),
        );
      },
    );
    _loading = false;
  }

  Future<void> getListShippingAddress()async{
    emit(state.copyWith(loadingListShippingAddress: true ));

    final result =await UserCaseSeller().orderSellerUseCase.getShppingAddress();
    emit(state.copyWith(loadingListShippingAddress: false ));
    result.handle(onSuccess: (data) {
       final items = data.data;
       emit(state.copyWith(listShippingAddress: List.from(items!)));
    },
    onFailed: (message) {
      emit(state.copyWith(errorListShippingAddress: message));
    },
    onNoInternet: () {
      emit(state.copyWith(errorListShippingAddress:StringApp.noInternet ));
    },
    );

  }
}
