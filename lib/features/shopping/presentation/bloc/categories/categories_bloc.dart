import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../domain/entities/categories_entity.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  CategoriesBloc(
    this.getCategoriesUseCase,
  ) : super(CategoriesInitial()) {
    on<GetCategories>((event, emit) async {
      emit(CategoriesLoadingState());
      final failureOrSuccess = await getCategoriesUseCase(NoParams());
      failureOrSuccess.fold(
          (failure) => emit(CategoriesErrorState(failure.message)), (success) {
        emit(CategoriesLoadedState(success));
      });
    });
  }
}
