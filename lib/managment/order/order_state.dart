part of 'order_cubit.dart';

@immutable
class OrderState {
  final int pageTapBar;
  final bool loading;
  final String? error;
  final List<Orders>? orderList;
  final bool hasMore;
  const OrderState({
    this.pageTapBar = 1,
    this.loading = true,
    this.hasMore = true,
    this.error,
    this.orderList,
  });

  OrderState copyWith({
    int? pageTapBar,
    String? url,
    bool? loading,
    bool? hasMore,
    String? error,
    List<Orders>? orderList,
  }) {
    return OrderState(
      pageTapBar: pageTapBar ?? this.pageTapBar,
      loading: loading ?? this.loading,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      orderList: orderList,
    );
  }
}
