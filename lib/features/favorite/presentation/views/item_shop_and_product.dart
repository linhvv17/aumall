import 'package:aumall/features/favorite/domain/entities/product/product_entity.dart';
import 'package:aumall/features/favorite/domain/entities/product/shop_entity.dart';
import 'package:flutter/material.dart';
import '../../../shop_profile/presentation/views/shop_profile.dart';
import 'item_product_favorite.dart';

class ItemShopAndProduct extends StatefulWidget {
  final ShopEntity shop;
  final List<ProductEntity> productEntities;

  const ItemShopAndProduct(
      {super.key, required this.shop, required this.productEntities});

  @override
  State<StatefulWidget> createState() => _ItemShopAndProductState();
}

class _ItemShopAndProductState extends State<ItemShopAndProduct> {
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
        // widget.productEntities.isEmpty
        //     ? Container()
        //     : ListView.builder(
        //         itemCount: widget.productEntities.length,
        //         itemBuilder: (context, index) {
        //           return InkWell(
        //             onTap: () {
        //               // Navigator.push(
        //               //     context,
        //               //     MaterialPageRoute(
        //               //       builder: (context) => ProductDetails(
        //               //         productSimpleEntity: newProducts[index],
        //               //         index: index,
        //               //         isFromAuction: false,
        //               //       ),
        //               //     ));
        //             },
        //             child: ItemProductFavorite(
        //               productEntity: widget.productEntities[index],
        //             ),
        //           );
        //         }
        //     ),
      ],
    );
  }
}
