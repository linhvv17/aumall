import 'package:aumall/features/cart/presentation/views/cart.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../generated/l10n.dart';
import '../../../favorite/presentation/bloc/favourite_bloc.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../../shop/presentation/widgets/review_card.dart';
import '../../data/models/product_detail_model.dart';
import '../../widgets/carousel.dart';
import '../../widgets/product_item.dart';
import '../bloc/product_detail_bloc/product_detail_event.dart';

class ProductDetails extends StatefulWidget {
  final ProductSimpleEntity productSimpleEntity;
  // final List<ProductEntity> products;
  final int index;
  const ProductDetails(
      {super.key,
      required this.productSimpleEntity,
      // required this.products,
      required this.index
      });

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
    BlocProvider.of<ProductDetailBloc>(context).add(
         GetProductDetailData(widget.productSimpleEntity.id!)
    );
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
    Overlay.of(contextRenderBox)?.insert(overlayEntry);
    Future.delayed(const Duration(milliseconds: 500), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<ProductEntity> newProductsList = widget.products.reversed.toList();
    // newProductsList.shuffle();
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
          style: Theme.of(context).textTheme.headline6,
        ),
        actions: [
          Padding(
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
                    showSnackbar(S.current.deletefav, context, Colors.green);
                  }
                },
                builder: (context, state) {
                  return CircleAvatar(
                    backgroundColor: ColorManager.white,
                    radius: 20.0,
                    child: InkWell(
                      onTap: () {
                        // BlocProvider.of<FavouriteBloc>(context)
                        //     .add(AddToFavorite(
                        //   product: widget.productSimpleEntity,
                        //   isFavourite: widget.productSimpleEntity.isFavourite,
                        // ));
                      },
                      child:
                      const Icon(
                        Icons.favorite,
                        size: 20.0,
                        color: ColorManager.orangeLight,
                      ),
                      // widget.productSimpleEntity.isFavourite
                      //     ? const Icon(
                      //         Icons.favorite,
                      //         size: 20.0,
                      //         color: ColorManager.orangeLight,
                      //       )
                      //     : const Icon(
                      //         Icons.favorite_outline,
                      //         size: 20.0,
                      //         color: ColorManager.grey,
                      //       ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: kWidth(context) / 2.4,
            height: kHeight(context) / 14,
            child: FloatingActionButton.extended(
                heroTag: "add",
                backgroundColor: ColorManager.orangeLight,
                elevation: 8,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () {

                  // BlocProvider.of<CartBloc>(context).add(AddToCart(widget.product, widget.index));

                  // animateCartAdd(
                  //   context,
                  //   NetworkImage(
                  //     widget.product.images[0].url,
                  //   ),
                  // );
                },
                label: BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    if (state is AddToCartState) {
                      showSnackbar(S.current.addedToCart, context, Colors.green);
                    }
                  },
                  builder: (context, state) {
                    return Text(
                      S.current.addToCart.toUpperCase(),
                    );
                  },
                )),
          ),
          SizedBox(
            width: kWidth(context) / 2.4,
            height: kHeight(context) / 14,
            child: FloatingActionButton.extended(
                heroTag: "goToCart",
                backgroundColor: ColorManager.orangeLight,
                elevation: 8,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () => {
                  // BlocProvider.of<CartBloc>(context).add(AddToCart(widget.product));
                  // animateCartAdd(
                  //   context,
                  //   NetworkImage(
                  //     widget.product.images[0].url,
                  //   ),
                  // );
                  // MaterialPageRoute(builder: (context) => const CartView())

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartView()))

                },
                label: BlocConsumer<CartBloc, CartState>(
                  listener: (context, state) {
                    // if (state is AddToCartState) {
                    //   showSnackbar(S.current.addedToCart, context, Colors.green);
                    // }
                  },
                  builder: (context, state) {
                    return Text(
                      S.current.goToCart.toUpperCase(),
                    );
                  },
                )),
          ),
        ],
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder:(context, state){
          if(state is ProductDetailLoaded){
            print('ProductDetailsbuild ${state.productDetailEntity.productDetailData!.toJson()}');
            print('ProductDetailsbuild ${state.productDetailEntity.productDetailData?.reviewNumber}');
            ProductDetailData productDetailData = state.productDetailEntity.productDetailData!;
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //media of product
                    Carousel(images: productDetailData!.images!),
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
                                width: kWidth(context)/2,
                                child: Text(
                                  productDetailData.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              //sub title
                              Text(
                                productDetailData.title!,
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
                                    rating: widget.productSimpleEntity.ratingNumber != null ?
                                    widget.productSimpleEntity.ratingNumber!.toDouble() : 0.0,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    direction: Axis.horizontal,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    widget.productSimpleEntity.reviewNumber != null ?
                                    '(${widget.productSimpleEntity.reviewNumber})'
                                        : S.current.notYetReview,
                                    style:
                                    Theme.of(context).textTheme.caption!.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //price
                          Text(
                            "₫${productDetailData.price}",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: ColorManager.orangeLight),
                          )
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
                            .headline6!
                            .copyWith(color: ColorManager.orangeLight),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        productDetailData.description!,
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
                              style: Theme.of(context).textTheme.headline6),
                          TextButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, AppRoutes.productReviews,
                                //     arguments: widget.product);
                                // BlocProvider.of<SendReviewBloc>(context)
                                //     .add(GetReviews(widget.product.id));
                              },
                              child:  Text(S.current.seeMore))
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
                            rating: productDetailData.ratingNumber != null ?
                            productDetailData.ratingNumber!.toDouble() : 0.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            direction: Axis.horizontal,
                            itemCount: 5,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                              productDetailData.ratingNumber != null ?
                              productDetailData.ratingNumber!.toStringAsFixed(1) : "0.0",
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            productDetailData.reviewNumber != null ?
                            '(${productDetailData.reviewNumber})'
                                : S.current.notYetReview,
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    productDetailData!.reviews!.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: ReviewCard(product: productDetailData, index: 0),
                    )
                        : const SizedBox(),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(S.current.mayLike,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    SizedBox(
                      height: 330,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.productDetailEntity.relatedProducts!.relatedProducts?.length,
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
                                child: ProductItem(product: state.productDetailEntity.relatedProducts!.relatedProducts![index])
                            ),
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
          }
          else if(state is ProductDetailErrorState){
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        }
      ),
    );
  }
}
