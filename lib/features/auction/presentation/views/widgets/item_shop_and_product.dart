import 'package:aumall/features/auction/domain/entities/product/product_entity.dart';
import 'package:aumall/features/auction/domain/entities/product/shop_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../home/presentation/view/product_details.dart';
import '../../../../home/widgets/customGridView.dart';
import '../../../../shop_profile/presentation/views/shop_profile.dart';
import '../../bloc/auction_bloc.dart';
import '../product_item_aution.dart';

class ItemShopAndProduct extends StatefulWidget {
  final ShopEntity shop;
  final List<ProductEntity> productEntities;
  final int typeProduct;

  const ItemShopAndProduct(
      {super.key, required this.shop, required this.productEntities, required this.typeProduct});

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopProfileView(shopId: widget.shop.user_id!)
                      ));
                },
                child: Container(
                  decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              widget.shop.image_url!,
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
                                      child: Text(
                                        "AuMall",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red.shade100),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text("Gian hàng chính hãng",
                                          style: TextStyle(
                                            color: Colors.red.shade500,
                                          )),
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
                ),
              ),
              const SizedBox(height: 10,),
              widget.productEntities.isEmpty
                  ? Container()
                  : SizedBox(
                      height: widget.productEntities.length > 2 ? 550 : 275,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: widget.productEntities.length > 4
                            ? 4
                            : widget.productEntities.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                height: 250,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetails(
                                            productEntityId:
                                            widget.productEntities[index]
                                                .id!,
                                            index: index,
                                            isFavorite: false,
                                            isFromAuction: true,
                                          ),
                                    ))
                                    .then((value) => {
                                  BlocProvider.of<
                                      AuctionBloc>(
                                      context)
                                      .add(
                                      const GetListAuctionProduct(
                                          2))
                                });
                              },
                              child:
                              // Container()
                              ProductItemAuction(
                                productEntity:
                                widget.productEntities[index],
                                isAuctionProduct: true,
                                typeProduct: widget.typeProduct,
                              ));

                        },
                      ),
                    ),

              // widget.productEntities.length == 1
              //         ? ItemProductOfShop(
              //             productEntity:
              //                 widget.productEntities.elementAt(0),
              //             isAuctionProduct: false,
              //           )
              //         : Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               ItemProductOfShop(
              //                 productEntity:
              //                     widget.productEntities.elementAt(0),
              //                 isAuctionProduct: false,
              //               ),
              //               ItemProductOfShop(
              //                 productEntity:
              //                     widget.productEntities.elementAt(1),
              //                 isAuctionProduct: false,
              //               ),
              //             ],
              //           ),

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
      ),
    );
  }
}
