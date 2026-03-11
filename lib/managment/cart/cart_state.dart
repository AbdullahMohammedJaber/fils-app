// ignore_for_file: must_be_immutable

part of 'cart_cubit.dart';

@immutable
class CartState {
  final int pageTabBar; // 1 is product , 2 is auction
  final CartListResponse? cartListResponse;
  final bool loadingCart;
  final bool loadingDeleteCart;
  final String? cartError;
  final double tax;
  final int? addressId;
  final String? addressName;
  final bool loadingValidateCart;
  final PaymentMethodResponse? paymentMethodResponse;
  final PaymentMethode? paymentMethode;
  final OrderRequest? orderRequest;

    const CartState({
    this.pageTabBar = 1,
    this.tax = 0.0,
    this.cartListResponse,
    this.loadingCart = false,
    this.loadingValidateCart = false,
    this.loadingDeleteCart = false,
    this.cartError,
    this.addressId,
    this.addressName,
    this.paymentMethodResponse,
    this.paymentMethode,
    this.orderRequest,
    

  });

  CartState copyWith({
    int? pageTabBar,
    CartListResponse? cartListResponse,
    bool? loadingCart,
    bool? loadingDeleteCart,
    String? cartError,
    OrderRequest? orderRequest,
    double? tax,
    int? addressId,
    PaymentMethodResponse? paymentMethodResponse,
    String? addressName,
    bool? loadingValidateCart,
    PaymentMethode? paymentMethode,
    
  }) {
    return CartState(
      pageTabBar: pageTabBar ?? this.pageTabBar,
      cartListResponse: cartListResponse ?? this.cartListResponse,
      loadingCart: loadingCart ?? this.loadingCart,
      cartError: cartError ?? this.cartError,
      tax: tax ?? this.tax,
      loadingDeleteCart: loadingDeleteCart ?? this.loadingDeleteCart,
      addressId: addressId ?? this.addressId,
      addressName: addressName,
      paymentMethode: paymentMethode ?? this.paymentMethode,
      paymentMethodResponse:
          paymentMethodResponse ?? this.paymentMethodResponse,
      loadingValidateCart: loadingValidateCart ?? this.loadingValidateCart,
      orderRequest: orderRequest ?? this.orderRequest,
    );
  }
 
}
