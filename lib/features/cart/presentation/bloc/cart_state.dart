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
  final num  totalNumberItems;
  const CartLoaded(this.items, this.totalNumberItems);
}

class IncrementCountState extends CartState {

}
class DecrementCountState extends CartState {
  
}