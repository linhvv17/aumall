import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetListNotificationUseCase
    extends BaseUsecase<ListNotificationEntity, NoParams> {
  final NotificationBaseRepository notificationBaseRepository;
  GetListNotificationUseCase(this.notificationBaseRepository);

  @override
  Future<Either<Failure, ListNotificationEntity>> call(NoParams params) async {
    final response = await notificationBaseRepository.getNotificationList();
    return response;
  }
}
