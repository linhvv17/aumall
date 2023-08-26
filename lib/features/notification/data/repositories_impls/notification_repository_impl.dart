import 'package:aumall/core/error/error_handler.dart';
import 'package:aumall/core/error/failure.dart';
import 'package:aumall/core/network/network_info.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/list_notification_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_datasource.dart';

class NotificationRepositoryImpl extends NotificationBaseRepository {
  final NetworkInfo networkInfo;
  final NotificationDatasource notificationDatasource;
  NotificationRepositoryImpl(this.networkInfo, this.notificationDatasource);

  @override
  Future<Either<Failure, ListNotificationEntity>> getNotificationList() async {
    if (await networkInfo.isConnected) {
      try {
        final data = await notificationDatasource.getListNotification();
        print("NotificationRepositoryImpl getNotificationList() try ${data}");
        return right(data);
      } catch (error) {
        print("NotificationRepositoryImpl getNotificationList() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> getDetailNotification(int idNotification) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await notificationDatasource.getDetailNotification(idNotification);
        print("NotificationRepositoryImpl getDetailNotification() try ${data}");
        return right(data);
      } catch (error) {
        print("NotificationRepositoryImpl getDetailNotification() catch ${error}");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(OfflineFailure(S.current.noInternetError));
    }
  }

}
