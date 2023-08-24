import 'package:aumall/core/error/failure.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:aumall/features/notification/domain/entities/notification_entity.dart';
import 'package:dartz/dartz.dart';

import '../entities/list_notification_entity.dart';

abstract class NotificationBaseRepository {
  Future<Either<Failure, ListNotificationEntity>> getNotificationList();
  Future<Either<Failure, NotificationEntity>> getDetailNotification(int idNotification);

}

class GetNotificationParams {
  final int id;
  GetNotificationParams({required this.id});
}
