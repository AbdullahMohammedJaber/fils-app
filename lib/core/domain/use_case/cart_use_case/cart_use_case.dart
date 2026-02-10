import 'package:fils/core/data/response/cart/cart_list_response.dart';
import 'package:fils/core/data/response/check_out/payment_methode_response.dart';
import 'package:fils/core/domain/reposetry/cart/cart_repo.dart';
import 'package:fils/core/server/result.dart';

class CartUseCase {
  CartRepo cartRepo;

  CartUseCase(this.cartRepo);

  Future<ApiResult<CartListResponse>> callCart(int type) async {
    return await cartRepo.getCart(type);
  }

  Future<ApiResult<Map<String, dynamic>>> callDeleteItemCart(int id) async {
    return await cartRepo.deleteItemCart(id);
  }

  Future<ApiResult<Map<String, dynamic>>> callProcessItemCart({
    required int id,

    required int newQuantity,
  }) async {
    return await cartRepo.processItemCart(newQuantity: newQuantity, id: id);
  }

  Future<ApiResult<Map<String, dynamic>>> callValidateCart() async {
    return await cartRepo.validateCart();
  }

  Future<ApiResult<PaymentMethodResponse>> callGetPaymentMethode() async {
    return await cartRepo.getPaymentMethode();
  }
}
