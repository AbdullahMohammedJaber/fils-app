import 'package:bloc/bloc.dart';
import 'package:fils/core/user_case_state/coustomer/use_case_state.dart';
import 'package:fils/utils/string.dart';
 
import 'package:flutter/widgets.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressState());

  final controller = UserCase().addressUseCase;

  Future<void> getAddress() async {
    emit(state.copyWith(loadingAddress: true));
    final result = await controller.callGetAddresses();
    result.handle(
      onSuccess: (data) {
      
        emit(state.copyWith(loadingAddress: false , addressList: List.from(data['data'])));
      },
      onNoInternet: () {
        emit(state.copyWith(loadingAddress: false , error: StringApp.noInternet));
      },
      onFailed: (message) {
        emit(state.copyWith(loadingAddress: false , error: message  ));
      },
    );
  }
}
