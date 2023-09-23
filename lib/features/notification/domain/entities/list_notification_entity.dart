import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:aumall/features/shopping/domain/entities/products_entity.dart';
import 'package:equatable/equatable.dart';

import 'notification_entity.dart';

class ListNotificationEntity extends Equatable {
  final List<NotificationEntity> listNotification;
  const ListNotificationEntity(this.listNotification);
  @override
  List<Object?> get props => [];
}
