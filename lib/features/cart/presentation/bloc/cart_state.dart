part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class AddToCartState extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List items;
  final num totalNumberItems;
  const CartLoaded(this.items, this.totalNumberItems);
}

class CartDataErrorState extends CartState {
  final String message;

  const CartDataErrorState(this.message);
}

class CartDataLoaded extends CartState {
  final ListProductInCartEntity listProductInCartEntity;
  const CartDataLoaded(this.listProductInCartEntity);
}

class AddToCartSuccess extends CartState {
  final bool isSuccess;
  const AddToCartSuccess(this.isSuccess);
}

class RemoveProductInCartSuccess extends CartState {
  final bool isSuccess;
  const RemoveProductInCartSuccess(this.isSuccess);
}

class UpdateProductInCartSuccess extends CartState {
  final bool isSuccess;
  const UpdateProductInCartSuccess(this.isSuccess);
}

class IncrementCountState extends CartState {}

class DecrementCountState extends CartState {}
