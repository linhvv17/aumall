import 'package:aumall/features/cart/presentation/views/cart.dart';
import 'package:aumall/features/home/data/models/detail_product_response.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../favorite/presentation/bloc/favourite_bloc.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../../shop/presentation/bloc/send_review_bloc.dart';
import '../../../shop/presentation/widgets/review_card.dart';
import '../../widgets/carousel.dart';
import '../../widgets/product_item.dart';
import '../bloc/product_detail_bloc/product_detail_event.dart';

class ProductDetails extends StatefulWidget {
  final ProductAuMallEntity productSimpleEntity;
  final int index;
  bool? isFromAuction;

  ProductDetails(
      {super.key,
      required this.productSimpleEntity,
      required this.index,
      this.isFromAuction});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with TickerProviderStateMixin {
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      upperBound: 1,
      lowerBound: 0,
    );
    BlocProvider.of<ProductDetailBloc>(context)
        .add(GetProductDetailData(widget.productSimpleEntity.id!));
    super.initState();
  }

  static late AnimationController animationController;

  void animateCartAdd(BuildContext contextRenderBox, ImageProvider image) {
    var overlayEntry = OverlayEntry(
      builder: (context) {
        RenderBox? box = contextRenderBox.findRenderObject() as RenderBox?;
        if (box != null) {
          var startOffset = box
              .localToGlobal(Offset(kWidth(context) / 4, kWidth(context) / 4));
          var endOffset = Offset(kWidth(context), kHeight(context));

          CurvedAnimation curvedAnimation = CurvedAnimation(
              parent: animationController, curve: Curves.easeInCubic);

          var animatedOffset = Tween<Offset>(begin: startOffset, end: endOffset)
              .animate(curvedAnimation);
          // animationController.reset();
          animationController.animateTo(1);
          return AnimatedBuilder(
            animation: animationController,
            builder: (_, child) {
              return Positioned(
                  top: animatedOffset.value.dy,
                  left: animatedOffset.value.dx,
                  child: child!);
            },
            child: SizedBox(
              width: -120 + kWidth(context) / 2,
              height: -120 + kWidth(context) / 2,
              child: Card(
                elevation: 2,
                color: Colors.grey.shade200,
                child: Image(
                  image: image,
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
    Overlay.of(contextRenderBox).insert(overlayEntry);
    Future.delayed(const Duration(milliseconds: 500), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          widget.productSimpleEntity.title!,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          widget.isFromAuction!
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 5,
                          color: ColorManager.grey,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: BlocConsumer<FavouriteBloc, FavouriteState>(
                      listener: (context, state) {
                        if (state is AddToFavouriteState) {
                          showSnackbar(S.current.addfav, context, Colors.green);
                        } else if (state is RemoveFromFavoriteState) {
                          showSnackbar(
                              S.current.deletefav, context, Colors.green);
                        }
                      },
                      builder: (context, state) {
                        return CircleAvatar(
                          backgroundColor: ColorManager.white,
                          radius: 20.0,
                          child: InkWell(
                            onTap: () {
                              BlocProvider.of<FavouriteBloc>(context).add(
                                  widget.productSimpleEntity.isFavorite!
                                      ? RemoveFavoriteProduct(
                                          widget.productSimpleEntity.id!)
                                      : AddToFavorite(
                                          product: widget.productSimpleEntity,
                                          isFavourite: widget
                                              .productSimpleEntity.isFavorite!,
                                        ));

                              setState(() {
                                widget.productSimpleEntity.isFavorite =
                                    !widget.productSimpleEntity.isFavorite!;
                              });
                            },
                            child: widget.productSimpleEntity.isFavorite!
                                ? const Icon(
                                    Icons.favorite,
                                    size: 20.0,
                                    color: ColorManager.orangeLight,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    size: 20.0,
                                    color: ColorManager.grey,
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.isFromAuction!
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  child: Container(
                    width: kWidth(context) * 0.4,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Center(child: Text("Đấu giá ngay!")),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(35),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setNewState) {
                            return Column(
                              children: [
                                Container(
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),
                                    ),
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  child: Center(
                                      child: Text(
                                        "Thông tin phiên đấu giá",
                                        style: const TextStyle(fontSize: 22),
                                      )),
                                ),
                                Text("Thông tin phiên đấu giá"),
                              ],
                            );
                          });
                        });
                  },
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Container(
                    width: kWidth(context) * 0.4,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: BlocConsumer<CartBloc, CartState>(
                      listener: (context, state) {
                        if (state is AddToCartState) {
                          showSnackbar(
                              S.current.addedToCart, context, Colors.green);
                        }
                      },
                      builder: (context, state) {
                        return Center(
                          child: Text(
                            S.current.addToCart.toUpperCase(),
                          ),
                        );
                      },
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<CartBloc>(context).add(AddProductToCart(
                        widget.productSimpleEntity, widget.index));

                    animateCartAdd(
                      context,
                      NetworkImage(
                        widget.productSimpleEntity.thumbnailUrl!,
                      ),
                    );
                  },
                ),
                InkWell(
                  child: Container(
                    width: kWidth(context) * 0.4,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: BlocConsumer<CartBloc, CartState>(
                      listener: (context, state) {
                      },
                      builder: (context, state) {
                        return Center(
                          child: Text(
                            S.current.goToCart.toUpperCase(),
                          ),
                        );
                      },
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CartView(
                              isFromBottomBar: false,
                            )));
                  },
                ),
              ],
            ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
        if (state is ProductDetailLoaded) {
          ProductDetailDataModel productDetailData =
              state.productDetailEntity.productDetailData!;
          var averageRate = 0.0;
          var totalRate = 0.0;

          if (productDetailData.reviews.isNotEmpty) {
            for (int i = 0; i < productDetailData.reviews.length; i++) {
              totalRate = totalRate + productDetailData.reviews[i].rating;
            }
            averageRate = totalRate / productDetailData.reviews.length;
          }

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //media of product
                  Carousel(images: productDetailData.images),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //title
                            SizedBox(
                              width: kWidth(context) / 2,
                              child: Text(
                                productDetailData.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            //sub title
                            Text(
                              productDetailData.title,
                              style: const TextStyle(
                                color: ColorManager.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            //rating
                            Row(
                              children: [
                                RatingBarIndicator(
                                  itemSize: 25.0,
                                  rating:
                                      widget.productSimpleEntity.ratingNumber !=
                                              null
                                          ? averageRate
                                          : 0.0,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  direction: Axis.horizontal,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  widget.productSimpleEntity.reviewNumber !=
                                          null
                                      ? '(${averageRate.toStringAsFixed(1)})'
                                      : S.current.notYetReview,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Colors.grey,
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        //price
                        Text(
                          "₫${double.parse(productDetailData.price).toInt()}",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: ColorManager.orangeLight),
                        )
                      ],
                    ),
                  ),

                  //shop info
                  Container(
                    // width: 350,
                    // height: 65,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 49,
                              height: 49,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(productDetailData
                                      .user.avatarUrl
                                      .toString()),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productDetailData.user.shopName.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF393F42),
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  productDetailData.user.name.toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF939393),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 77),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 10),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFD9D9D9)),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Follow',
                                style: TextStyle(
                                  color: Color(0xFF393F42),
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //description
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      S.current.description,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: ColorManager.orangeLight),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(
                      productDetailData.description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  ////reviews
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.current.rateandreview,
                            style: Theme.of(context).textTheme.titleLarge),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.productReviews,
                                  arguments: widget.productSimpleEntity);
                              BlocProvider.of<SendReviewBloc>(context).add(
                                  GetReviews(widget.productSimpleEntity.id
                                      .toString()));
                            },
                            child: Text(S.current.seeMore))
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: Row(
                      children: [
                        RatingBarIndicator(
                          itemSize: 25.0,
                          rating: productDetailData.ratingNumber != null
                              ? averageRate
                              : 0.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          direction: Axis.horizontal,
                          itemCount: 5,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          productDetailData.ratingNumber != null
                              ? averageRate.toStringAsFixed(1)
                              : "0.0",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          productDetailData.reviewNumber != null
                              ? "(${productDetailData.reviews.length})"
                              : S.current.notYetReview,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  productDetailData.reviews.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          child:
                              ReviewCard(product: productDetailData, index: 0),
                        )
                      : const SizedBox(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text(S.current.mayLike,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  SizedBox(
                    height: 330,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.productDetailEntity.relatedProducts!
                          .relatedProducts?.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ProductDetails(
                            //         product: widget.products[index],
                            //         products: widget.products,
                            //         index: index,
                            //       ),
                            //     ));
                          },
                          child: SizedBox(
                              width: kWidth(context) / 2,
                              height: 330,
                              child: ProductItem(
                                  product: state
                                      .productDetailEntity
                                      .relatedProducts!
                                      .relatedProducts![index])),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: kHeight(context) / 11,
                  )
                ],
              ),
            ),
          );
        } else if (state is ProductDetailErrorState) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      }),
    );
  }
}
