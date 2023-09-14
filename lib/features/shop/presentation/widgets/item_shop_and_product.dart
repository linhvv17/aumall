import 'package:flutter/material.dart';
import '../../../home/widgets/customGridView.dart';
import '../../domain/entities/products_entity.dart';
import 'item_product_of_shop.dart';

class ItemShopAndProduct extends StatefulWidget {
  final ShopEntity shop;
  final List<ProductAuMallEntity> productAuMallEntities;

  const ItemShopAndProduct(
      {super.key, required this.shop, required this.productAuMallEntities});

  @override
  State<StatefulWidget> createState() => _ItemShopAndProductState();
}

class _ItemShopAndProductState extends State<ItemShopAndProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(
                        widget.shop.imageUrl!,
                      ),
                      backgroundColor: Colors.transparent,
                    )),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          widget.shop.name!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red.shade600),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text("AuMall",
                                style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red.shade100),
                              child:  Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text("Gian hàng chính hãng",
                                  style: TextStyle(color: Colors.red.shade500,)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            widget.productAuMallEntities.isEmpty
                ? Container()
                : widget.productAuMallEntities.length == 1
                    ? ItemProductOfShop(
                        productFavoriteEntity:
                            widget.productAuMallEntities.elementAt(0),
                        isAuctionProduct: false,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemProductOfShop(
                            productFavoriteEntity:
                                widget.productAuMallEntities.elementAt(0),
                            isAuctionProduct: false,
                          ),
                          ItemProductOfShop(
                            productFavoriteEntity:
                                widget.productAuMallEntities.elementAt(1),
                            isAuctionProduct: false,
                          ),
                        ],
                      ),
            // SizedBox(
            //   height: 200,
            //   child: Expanded(
            //     child: GridView.builder(
            //       physics: const AlwaysScrollableScrollPhysics(
            //           parent: BouncingScrollPhysics()),
            //       itemCount: widget.productAuMallEntities.length,
            //       gridDelegate:
            //           const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
            //               crossAxisCount: 2, height: 330),
            //       itemBuilder: (context, index) {
            //         return ItemProductOfShop(
            //           productFavoriteEntity: widget.productAuMallEntities[index],
            //           isAuctionProduct: false,
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
