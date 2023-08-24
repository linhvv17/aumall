part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationDataLoading extends NotificationState {}

class NotificationDataErrorState extends NotificationState {
  final String message;
  const NotificationDataErrorState(this.message);
}

class NotificationDataLoaded extends NotificationState {
  final ListNotificationEntity listNotificationEntity;
  const NotificationDataLoaded(this.listNotificationEntity);
}

class NotificationDetailDataLoaded extends NotificationState {
  final NotificationEntity notificationEntity;
  const NotificationDetailDataLoaded(this.notificationEntity);
}
