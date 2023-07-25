
import 'package:aumall/features/cart/data/models/cart_product_model.dart';
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
  List<CartProductModel> cartItemsProductModel = [];
  List<Map<String, dynamic>> orderItems = [];
  num totalAmount = 0;
  num totalNumberItems = 0;


  final Box<CartProduct> itemBox = Hive.box<CartProduct>("product-cahce");
  final Box<CartProductModel> itemBoxCartProduct = Hive.box<CartProductModel>("product-cache");


  CartBloc() : super(CartInitial()) {
    on<CartStarted>((event, emit) {
      if (state is CartInitial) {
        emit(CartLoading());
        List<CartProductModel> list = itemBoxCartProduct.values.toList();
        cartItemsProductModel = list;

        for (var element in list) {
          totalAmount = totalAmount + element.amount * double.parse(element.price);
          totalNumberItems = totalNumberItems + element.amount;
        }

        emit(CartLoaded(cartItemsProductModel, totalNumberItems));
      }
    });



    on<AddProductToCart>((event, emit) {
      emit(CartLoading());
      //add to local store
      CartProductModel cartProductModel = CartProductModel(
          id: event.productAuMallEntity.id.toString(),
          name: event.productAuMallEntity.title!,
          description: event.productAuMallEntity.description!,
          price: event.productAuMallEntity.price!,
          ratings: event.productAuMallEntity.ratingNumber as num,
          numOfReviews: event.productAuMallEntity.reviewNumber!,
          productImage: event.productAuMallEntity.thumbnailUrl!,
          isFavourite: event.productAuMallEntity.isFavorite!

      );
      if(checkExitsItemProduct(cartProductModel)){

        updateDataProductToHive(cartProductModel, event.index);
      } else {
        cartProductModel.amount = 1;
        itemBoxCartProduct.put(cartProductModel.id, cartProductModel);
      }

      countNumberItemsAndTotalPriceForAll();
      emit(AddToCartState());
      emit(CartLoaded(itemBoxCartProduct.values.toList(), totalNumberItems));
    });



    on<RemoveFromCart>((event, emit) async {
      emit(CartLoading());
      await itemBoxCartProduct.deleteAt(event.id);
      countNumberItemsAndTotalPriceForAll();

      emit(CartLoaded(itemBoxCartProduct.values.toList(), totalNumberItems));
    });

    on<IncrementCount>((event, emit) async {
      event.cartProduct.amount++;
      //save to hive
      updateDataProductToHive(event.cartProduct, event.index);

      countNumberItemsAndTotalPriceForAll();

      emit(IncrementCountState());
      emit(CartLoaded(itemBoxCartProduct.values.toList(), totalNumberItems));
    });
    on<DecrementCount>((event, emit) async {
      if (event.cartProduct.amount > 0) {
        event.cartProduct.amount--;

        //save to hive
        updateDataProductToHive(event.cartProduct, event.index);

        if(event.cartProduct.amount == 0){
          itemBoxCartProduct.delete(event.cartProduct.id);
        }

        countNumberItemsAndTotalPriceForAll();

        emit(DecrementCountState());
        emit(CartLoaded(itemBoxCartProduct.values.toList(), totalNumberItems));
      }
    });

  }


  Future<void> updateDataProductToHive(CartProductModel cartProductToUpdate, int index) async{


    CartProductModel cartProductModel = CartProductModel(
        id: cartProductToUpdate.id,
        name: cartProductToUpdate.name,
        description: cartProductToUpdate.description,
        price: cartProductToUpdate.price,
        ratings: cartProductToUpdate.ratings,
        numOfReviews: cartProductToUpdate.numOfReviews,
        productImage: cartProductToUpdate.productImage,
        amount: cartProductToUpdate.amount);


    CartProductModel? cartProductModelInStorage = itemBoxCartProduct.get(cartProductModel.id);

    if(cartProductModelInStorage != null){
      // cartProductModel.amount = cartProductModelInStorage.amount+1;
      itemBoxCartProduct.put(cartProductModel.id, cartProductModel);
    } else{
      if (kDebugMode) {
        print("AddToCart go to update Increment amount itemBox.get(cartProduct.id) = null");
      }
    }
    if(cartProductToUpdate.amount == 0){
      itemBoxCartProduct.deleteAt(index);
    }
  }


  bool checkExitsItemProduct(CartProductModel cartProductToCheck) {
    for (var element in cartItems) {
      if(element.id == cartProductToCheck.id) {
        cartProductToCheck.amount = element.amount + 1;
        return true;
      }
    }
    return false;
  }


  void countNumberItemsAndTotalPriceForAll(){
    List<CartProductModel> list = itemBoxCartProduct.values.toList();
    cartItemsProductModel = list;
    totalAmount = 0;
    totalNumberItems = 0;
    for (var element in list) {
      totalAmount = totalAmount + element.amount * double.parse(element.price);
      totalNumberItems = totalNumberItems + element.amount;
    }
  }

}
