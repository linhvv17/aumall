

import 'package:aumall/core/error/failure.dart';

import 'package:aumall/features/cart/domain/entities/product_in_cart_entity.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {


  ProductsRepositoryImpl();

  @override
  Future<Either<Failure, ProductInCartEntity>> getCartData() {
    // TODO: implement getCartData
    throw UnimplementedError();
  }


}
