part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartStarted extends CartEvent{
  
}
class AddToCart extends CartEvent {
  final ProductEntity product;
  final int index;
  const AddToCart(this.product, this.index);
}

class RemoveFromCart extends CartEvent {
  final int id;

  const RemoveFromCart(this.id);
}

class IncrementCount extends CartEvent {
  final CartProduct cartProduct;
  final int index;

  const IncrementCount(this.cartProduct, this.index);
}

class DecrementCount extends CartEvent {
  final CartProduct cartProduct;
  final int index;
  const DecrementCount(this.cartProduct, this.index);
}
