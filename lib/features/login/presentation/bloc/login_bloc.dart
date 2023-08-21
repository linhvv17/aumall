import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/local/shared_preference.dart';
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
      final tokenFCM = await FirebaseMessaging.instance.getToken();
      final failureOrSuccess = await loginUseCase(
          LoginUseCaseParams(
              email: event.email,
              password: event.password,
              deviceToken: tokenFCM.toString(),
              tokenType: Platform.isIOS ? 1 : 2
          ));
      failureOrSuccess.fold((failure) => emit(LoginErrorState(failure.message)),
          (success) {
        PreferenceHelper.saveDataInSharedPreference(
            key: "keyUser",
            value: "${(success).id}-${success.name}");
        emit(LoginFinishedState(data: success));
      });
    });
  }
}
