import 'package:aumall/core/usecase/usecase.dart';
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_banner_usecase.dart';
import 'package:bloc/bloc.dart';

import '../../../domain/usecases/get_list_product_home_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';


class HomeBloc extends Bloc<HomeEvent, HomeLoadState>{
  final GetBannerUseCase getBannerUseCase;
  final GetListProductHomeUseCase getListProductHomeUseCase;
  HomeBloc(this.getBannerUseCase, this.getListProductHomeUseCase) : super(HomeStateLoading()){
    on<GetListProductHomeData>((event, emit) async {
      final failureOrSuccess = await getListProductHomeUseCase(NoParams());

      failureOrSuccess.fold(
              (failure) => emit(HomeErrorState(failure.message)),
              // (success) => emit(HomeStateLoadedFullData(null, success))
              (success) => emit(HomeStateLoadListProductDataLoaded(success))
      );
    });
    on<GetBannerData>((event, emit) async {
      final failureOrSuccess = await getBannerUseCase(NoParams());

      failureOrSuccess.fold(
              (failure) => emit(HomeErrorState(failure.message)),
              // (success) => emit(HomeStateDataLoaded(success)),
              (success) => emit(HomeStateLoadedFullData(success,null))
      );
    });
  }
}