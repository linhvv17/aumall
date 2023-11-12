import 'package:flutter/material.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shop_profile/presentation/views/shop_profile.dart';
import '../../domain/entities/list_product_in_cart_entity.dart';
import '../../domain/entities/shop_item_cart_entity.dart';
import 'cart_item.dart';

class ItemCart extends StatefulWidget {
  final ShopItemCartEntity shop;
  final List<ProductInCartEntity> productEntities;

  const ItemCart(
      {super.key, required this.shop, required this.productEntities});

  @override
  State<StatefulWidget> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShopProfileView(shopId: widget.shop.user_id!)));
          },
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        widget.shop.image_url!,
                      ),
                      backgroundColor: Colors.transparent,
                    )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.shade600),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      "AuMall",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.shop.name!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        widget.productEntities.isEmpty
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.productEntities.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              productEntityId: widget.productEntities[index].id!,
                              index: index,
                              isFromAuction: false,
                              isFavorite: true,
                            ),
                          ));
                    },
                    child: CartItem(
                      item: widget.productEntities[index],
                      index: index,
                    ),
                  );
                }),
      ],
    );
  }
}
