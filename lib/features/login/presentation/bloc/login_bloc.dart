import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  
  LoginBloc(
    this.loginUseCase,
  ) : super(LoginInitialState()) {
    on<UserLogin>((event, emit) async {
      emit(LoginLoadingState());
      
        final failureOrSuccess = await loginUseCase(
          LoginUseCaseParams(email: event.email, password: event.password));
           failureOrSuccess.fold(
          (failure) => emit(LoginErrorState(failure.message)),
          (success) => emit(LoginFinishedState(data: success)));
    });
  }
}
