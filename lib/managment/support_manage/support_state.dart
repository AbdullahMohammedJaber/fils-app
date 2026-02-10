part of 'support_cubit.dart';

sealed class SupportState extends Equatable {
  const SupportState();

  @override
  List<Object> get props => [];
}

final class SupportInitial extends SupportState {}

class SupportLoading extends SupportState {}

class SupportSuccess extends SupportState {}

class SupportFailure extends SupportState {}
