import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/update_password_usecase.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final UpdatePasswordUseCase updatePasswordUseCase;
  UpdatePasswordBloc(this.updatePasswordUseCase)
      : super(UpdatePasswordInitial()) {
    on<UserUpdatePassword>((event, emit) async {
      emit(UpdatePasswordLoading());
      final failureOrSuccess = await updatePasswordUseCase(
          UpdatePasswordUseCaseParams(
              event.oldPassword, event.newPassword, event.confirmPassword));
      failureOrSuccess.fold(
          (failure) => emit(UpdatePasswordError(failure.message)),
          (success) => emit(UpdatePasswordLoaded(success)));
    });
  }
}
