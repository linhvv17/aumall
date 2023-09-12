import 'package:aumall/features/home/data/models/detail_product_response.dart';
import 'package:flutter/material.dart';
import '../../../favorite/presentation/views/product_item_aumall.dart';
import '../../../home/widgets/customGridView.dart';
import '../../domain/entities/products_entity.dart';

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
    return Column(
      children: [
        Row(
          children: [
            Image.network(
              widget.shop.imageUrl!,
              width: 50,
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    widget.shop.name!,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrange),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text("AuMall"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.deepOrange.shade300),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text("Gian hàng chính hãng"),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 200,
          child: Expanded(
            child: GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: widget.productAuMallEntities.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 2, height: 330),
              itemBuilder: (context, index) {
                return ProductItemAuMall(
                  productFavoriteEntity: widget.productAuMallEntities[index],
                  isAuctionProduct: false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
