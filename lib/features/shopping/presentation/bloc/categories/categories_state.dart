part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  final CategoriesEntity categoriesEntity;
  const CategoriesLoadedState(this.categoriesEntity);
}

class CategoriesErrorState extends CategoriesState {
  final String message;

  const CategoriesErrorState(this.message);
}
