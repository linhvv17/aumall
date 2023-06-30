
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/register_entity.dart';
import '../../domain/usecases/register_usecase.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  RegisterBloc(
    this.registerUseCase,
  ) : super(RegisterInitialState()) {
    on<UserRegister>((event, emit) async {
      emit(RegisterLoadingState());
      final failureOrSuccess = await registerUseCase(RegisterUseCaseParams(
          name: event.name,
          email: event.email,
          password: event.password,
         ));
      failureOrSuccess.fold(
          (failure) => emit(RegisterErrorState(failure.message)),
          (success) => emit(RegisterFinishedState(data: success)));
    });
  }
}
