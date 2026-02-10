part of 'home_seller_cubit.dart';

sealed class HomeSellerState extends Equatable {
  const HomeSellerState();

  @override
  List<Object> get props => [];
}

final class HomeSellerInitial extends HomeSellerState {}


class HomeSuccessSeller extends HomeSellerState {
  final HomeSellerResponse homeResponse;

  const HomeSuccessSeller({required this.homeResponse});
}

class HomeLoadingSeller extends HomeSellerState {}

class HomeNoInternetSeller extends HomeSellerState {
   final String error ;

 const HomeNoInternetSeller({required this.error});
}

class HomeUnknownErrorSeller extends HomeSellerState {
  final String error ;

 const HomeUnknownErrorSeller({required this.error});

}