part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final HomeResponse homeResponse;

  HomeSuccess({required this.homeResponse});
}

class HomeLoading extends HomeState {}

class HomeNoInternet extends HomeState {}

class HomeUnknownError extends HomeState {}

 
