// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetListNotification extends NotificationEvent {}
class GetDetailNotification extends NotificationEvent {
  final int id;
  const GetDetailNotification({required this.id});
}


