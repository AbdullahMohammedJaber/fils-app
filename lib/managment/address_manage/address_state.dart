// ignore_for_file: must_be_immutable

part of 'address_cubit.dart';

@immutable
class AddressState {

  final bool loadingAddress;
  final String ?error;
  List<dynamic> ? addressList ;
    AddressState({this.loadingAddress = false , this.error , this.addressList});

  AddressState copyWith({
    bool? loadingAddress,
    String? error,
    List<dynamic>? addressList,
  }) {
    return AddressState(
      loadingAddress: loadingAddress ?? this.loadingAddress,
      error: error  ,
      addressList: addressList ?? this.addressList,
    );
  }
}
