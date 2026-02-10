part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final bool hasMore;
  final List<Notifications> notifications;

  NotificationLoaded({required this.hasMore, required this.notifications});
}

class NotificationLoadingError extends NotificationState {
  final String? error;

  NotificationLoadingError({this.error});
}
