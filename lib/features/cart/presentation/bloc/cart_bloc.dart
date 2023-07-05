
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:aumall/features/shop/domain/entities/products_entity.dart';
import '../../data/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartProduct> cartItems = [];
  List<Map<String, dynamic>> orderItems = [];
  num totalAmount = 0;
  num totalNumberItems = 0;


  final Box<CartProduct> itemBox = Hive.box<CartProduct>("product-cahce");


  CartBloc() : super(CartInitial()) {
    on<CartStarted>((event, emit) {
      if (state is CartInitial) {
        emit(CartLoading());
        List<CartProduct> list = itemBox.values.toList();
        cartItems = list;

        for (var element in list) {
          totalAmount = totalAmount + element.amount * element.price;
          totalNumberItems = totalNumberItems + element.amount;
        }

        emit(CartLoaded(cartItems, totalNumberItems));
      }
    });

    on<AddToCart>((event, emit) {
      emit(CartLoading());

      CartProduct cartProduct = CartProduct(
          id: event.product.id,
          name: event.product.name,
          description: event.product.description,
          price: event.product.price,
          ratings: event.product.ratings,
          category: event.product.category,
          stock: event.product.stock,
          numOfReviews: event.product.numOfReviews,
          user: event.product.user,
          productImage: event.product.images.first.url,
          amount: event.product.qouantity
      );
      if(checkExitsItem(cartProduct)){
        updateDataToHive(cartProduct, event.index);
      } else {
        itemBox.put(cartProduct.id, cartProduct);
      }
      // List<CartProduct> list = itemBox.values.toList();
      // cartItems = list;
      // totalAmount = 0;
      // totalNumberItems = 0;
      // for (var element in list) {
      //   totalAmount = totalAmount + element.amount * element.price;
      //   totalNumberItems = totalNumberItems + element.amount;
      // }
      countNumberItemsAndTotalPrice();
      emit(AddToCartState());
      emit(CartLoaded(itemBox.values.toList(), totalNumberItems));
    });
    on<RemoveFromCart>((event, emit) async {
      emit(CartLoading());
      await itemBox.deleteAt(event.id);
      // List<CartProduct> list = itemBox.values.toList();
      // cartItems = list;
      // totalAmount = 0;
      // totalNumberItems = 0;
      // for (var element in list) {
      //   totalAmount = totalAmount + element.amount * element.price;
      //   totalNumberItems = totalNumberItems + element.amount;
      // }
      countNumberItemsAndTotalPrice();

      emit(CartLoaded(itemBox.values.toList(), totalNumberItems));
    });
    on<IncrementCount>((event, emit) async {
      event.cartProduct.amount++;
      //save to hive
      updateDataToHive(event.cartProduct, event.index);

      // List<CartProduct> list = itemBox.values.toList();
      // cartItems = list;
      // totalAmount = 0;
      // totalNumberItems = 0;
      // for (var element in list) {
      //   totalAmount = totalAmount + element.amount * element.price;
      //   totalNumberItems = totalNumberItems + element.amount;
      // }

      countNumberItemsAndTotalPrice();

      emit(IncrementCountState());
      emit(CartLoaded(itemBox.values.toList(), totalNumberItems));
    });
    on<DecrementCount>((event, emit) async {
      if (event.cartProduct.amount > 0) {
        event.cartProduct.amount--;

        //save to hive
        updateDataToHive(event.cartProduct, event.index);

        if(event.cartProduct.amount == 0){
          itemBox.delete(event.cartProduct.id);
        }

        List<CartProduct> list = itemBox.values.toList();
        cartItems = list;
        totalAmount = 0;
        totalNumberItems = 0;
        for (var element in list) {
          totalAmount = totalAmount + element.amount * element.price;
          totalNumberItems = totalNumberItems + element.amount;
        }

        countNumberItemsAndTotalPrice();

        emit(DecrementCountState());
        emit(CartLoaded(itemBox.values.toList(), totalNumberItems));
      }
    });
  }


  Future<void> updateDataToHive(CartProduct cartProductToUpdate, int index) async{
    CartProduct cartProduct = CartProduct(
        id: cartProductToUpdate.id,
        name: cartProductToUpdate.name,
        description: cartProductToUpdate.description,
        price: cartProductToUpdate.price,
        ratings: cartProductToUpdate.ratings,
        category: cartProductToUpdate.category,
        stock: cartProductToUpdate.stock,
        numOfReviews: cartProductToUpdate.numOfReviews,
        user: cartProductToUpdate.user,
        productImage: cartProductToUpdate.productImage,
        amount: cartProductToUpdate.amount);
    if(itemBox.get(cartProduct.id) != null){
      itemBox.put(cartProduct.id, cartProduct);
    } else{
      if (kDebugMode) {
        print("AddToCart go to update Increment amount itemBox.get(cartProduct.id) = null");
      }
    }
    if(cartProductToUpdate.amount == 0){
      itemBox.deleteAt(index);
    }
  }

  bool checkExitsItem(CartProduct cartProductToCheck) {
    for (var element in cartItems) {
      if(element.id == cartProductToCheck.id) {
        cartProductToCheck.amount = element.amount + 1;
        return true;
      }
    }
    return false;
  }

  void countNumberItemsAndTotalPrice(){
    List<CartProduct> list = itemBox.values.toList();
    cartItems = list;
    totalAmount = 0;
    totalNumberItems = 0;
    for (var element in list) {
      totalAmount = totalAmount + element.amount * element.price;
      totalNumberItems = totalNumberItems + element.amount;
    }
  }



}
