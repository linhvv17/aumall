import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/list_notification_entity.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repository.dart';

class GetDetailNotificationUseCase
    extends BaseUsecase<NotificationEntity, DetailNotificationUseCaseParams> {
  final NotificationBaseRepository notificationBaseRepository;
  GetDetailNotificationUseCase(this.notificationBaseRepository);

  @override
  Future<Either<Failure, NotificationEntity>> call(DetailNotificationUseCaseParams params) async {
    final response = await notificationBaseRepository.getDetailNotification(params.id);
    return response;
  }
}

class DetailNotificationUseCaseParams {
  final int id;

  DetailNotificationUseCaseParams({
    required this.id,
  });
}
