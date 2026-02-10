part of 'order_seller_cubit.dart';

class OrderSellerState {
  final bool loading;
  final String? error;
  final List<OrderSeeler>? listOrder;
  final bool hasMore;
  // shipping address
  final bool loadingListShippingAddress;
  final String ? errorListShippingAddress;
  final List<ShippingAddress>? listShippingAddress;

  OrderSellerState({
    this.loading = false,
    this.error,
    this.listOrder,
    this.hasMore = true,
    this.errorListShippingAddress,
    this.listShippingAddress,
    this.loadingListShippingAddress = true,
  });
OrderSellerState copyWith({
     bool ?loading,
    String? error,
    List<OrderSeeler>? listOrder,
    bool ?hasMore,

        bool? loadingListShippingAddress,
    String ? errorListShippingAddress,
    List<ShippingAddress>? listShippingAddress,
}){
  return OrderSellerState(
    error: error,
    hasMore: hasMore??this.hasMore,
    listOrder: listOrder??this.listOrder,
    loading: loading ?? this.loading,
    errorListShippingAddress: errorListShippingAddress,
    listShippingAddress: listShippingAddress,
    loadingListShippingAddress: loadingListShippingAddress??this.loadingListShippingAddress,
  );
}
 factory OrderSellerState.clearList(){
  return OrderSellerState(
    listOrder: null,
  );
 }
}
