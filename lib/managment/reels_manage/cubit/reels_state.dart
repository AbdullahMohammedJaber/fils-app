part of 'reels_cubit.dart';

abstract class ReelsState {}

class ReelsInitial extends ReelsState {}

class ReelsLoading extends ReelsState {
  final List<Reels> reels;
  ReelsLoading({this.reels = const []});
}

class ReelsLoaded extends ReelsState {
  final List<Reels> reels;
  final bool hasMore;
  final bool loadingPage;

  ReelsLoaded({
    required this.reels,
    this.hasMore = false,
    this.loadingPage = false,
  });
}

class ReelsError extends ReelsState {
  final String message;
  ReelsError({required this.message});
}
