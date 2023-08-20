import 'package:aumall/features/cart/domain/entities/product_in_cart_entity.dart';

class ProductInCartModel extends ProductInCartEntity {
  const ProductInCartModel(super.id, super.productId, super.amount,
      super.quantity, super.createdAt, super.productEntity);
}
