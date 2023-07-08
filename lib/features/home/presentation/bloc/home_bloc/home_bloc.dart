import 'package:aumall/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_banner_usecase.dart';
import 'package:bloc/bloc.dart';

import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeLoadState>{
  final GetBannerUseCase getBannerUseCase;
  HomeBloc(this.getBannerUseCase) : super(HomeStateLoading()){
    on<GetBannerData>((event, emit) async {
      final failureOrSuccess = await getBannerUseCase(NoParams());

      failureOrSuccess.fold(
              (failure) => emit(HomeErrorState(failure.message)),
              (success) => emit(HomeStateDataLoaded(success))
      );
    });
  }
}