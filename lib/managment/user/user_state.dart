// ignore_for_file: must_be_immutable

part of 'user_cubit.dart';

@immutable
class UserState {
  final String greeting;
  final int ?idImageProfile;
  const  UserState({this.greeting = '', this.idImageProfile});

  UserState copyWith({required String? greet,   int? idImageProfile}) {
    return UserState(greeting: greet ?? this.greeting, idImageProfile: idImageProfile ?? this.idImageProfile);
  }
}
