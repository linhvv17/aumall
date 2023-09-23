import 'package:aumall/features/notification/domain/usecases/get_detail_notification_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../shopping/domain/entities/products_entity.dart';
import '../../domain/entities/list_notification_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/usecases/get_list_notification_usecase.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  List<ProductSimpleEntity> favouriteList = [];
  final GetListNotificationUseCase _getListNotificationUseCase;
  final GetDetailNotificationUseCase _getDetailNotificationUseCase;


  NotificationBloc(
      this._getListNotificationUseCase,
      this._getDetailNotificationUseCase)
      : super(NotificationInitial()) {
    on<GetListNotification>((event, emit) async {
      emit(NotificationDataLoading());
      final failureOrSuccess = await _getListNotificationUseCase(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(NotificationDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
          (success) => emit(NotificationDataLoaded(success)));
    });
    on<GetDetailNotification>((event, emit) async {
      emit(NotificationDataLoading());
      final failureOrSuccess = await _getDetailNotificationUseCase(
          DetailNotificationUseCaseParams(id: event.id)
      );
      failureOrSuccess.fold(
          (failure) => emit(NotificationDataErrorState(failure.message)),
          // (success) => emit(HomeStateDataLoaded(success)),
          (success) => emit(NotificationDetailDataLoaded(success)));
    });

  }
}
