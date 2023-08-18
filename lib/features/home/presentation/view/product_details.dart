import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/cart/presentation/views/cart.dart';
import 'package:aumall/features/home/data/models/detail_product_response.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../auction/data/models/auction_session_info_model.dart';
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
                    child: CircleAvatar(
                      backgroundColor: ColorManager.white,
                      radius: 20.0,
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<FavouriteBloc>(context).add(widget
                                  .productSimpleEntity.isFavorite!
                              ? RemoveFavoriteProduct(
                                  widget.productSimpleEntity.id!)
                              : AddToFavorite(
                                  product: widget.productSimpleEntity,
                                  isFavourite:
                                      widget.productSimpleEntity.isFavorite!,
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
                    //get info auction
                    BlocProvider.of<AuctionBloc>(context).add(
                        GetInfoAuctionSession(widget.productSimpleEntity.id!));
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
                      productId: widget.productSimpleEntity.id!,
                    ));

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
                      listener: (context, state) {},
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
      body: BlocListener<AuctionBloc, AuctionState>(
        listener: (context, state) {
          // do stuff here based on BlocA's state
          if (state is AuctionSessionInfoDataLoaded) {
            // showPopUpConfirmAuction(34, "123456789");
            _showInfoAuctionSession();
          }
          if (state is AuctionDataErrorState) {
            showDialogAuctionFailed(state.message);
          }
          if (state is ActionAuctionSuccess) {
            showDialogAuctionSuccess();
          }
        },
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
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
                                    rating: widget.productSimpleEntity
                                                .ratingNumber !=
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Text(
                        S.current.description,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: ColorManager.orangeLight),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Text(
                        productDetailData.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    ////reviews
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 15),
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
                            child: ReviewCard(
                                product: productDetailData, index: 0),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
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
      ),
    );
  }

  int selectedContainer = 0;

  void _showInfoAuctionSession(){
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(35),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            heightFactor: 0.7,
            child: StatefulBuilder(
                builder: (context, setNewState) {
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
                    child: const Center(
                        child: Text(
                      "Thông tin phiên đấu giá",
                      style: TextStyle(fontSize: 22),
                    )),
                  ),
                  BlocBuilder<AuctionBloc, AuctionState>(
                    buildWhen: (context, state){
                      return (state is AuctionSessionInfoDataLoaded) || (state is GetInfoAuctionSessionLoading);
                    },
                      builder: (context, state) {
                    if (state is GetInfoAuctionSessionLoading) {
                      return Center(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 100,
                            ),
                            const CircularProgressIndicator(),
                            Text(S.current.dataLoading)
                          ],
                        ),
                      );
                    }
                    if (state is AuctionSessionInfoDataLoaded) {
                      if (state.auctionSessionInfoEntity
                          .userAuctions.data.isEmpty) {
                        return const Text(
                            "Chua co ai tham gia dau gia");
                      }
                      return Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Container(
                              width: kWidth(context) * 0.9,
                              height: 60,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFF3F2F2),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                            8)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize:
                                        MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        S.current.startingPrice,
                                        style: const TextStyle(
                                          color:
                                              Color(0xFF001B2E),
                                          fontSize: 14,
                                          fontFamily: 'Domine',
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '${double.parse(state.auctionSessionInfoEntity.product.price).toInt()} đ',
                                        style: const TextStyle(
                                          color:
                                              Color(0xFF001B2E),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight:
                                              FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize:
                                        MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                    children: [
                                      Text(
                                        S.current
                                            .currentBidPrice,
                                        style: const TextStyle(
                                          color:
                                              Color(0xFF001B2E),
                                          fontSize: 14,
                                          fontFamily: 'Domine',
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '${double.parse(state.auctionSessionInfoEntity.userAuctions.data[0].price).toInt()} đ',
                                        style: const TextStyle(
                                          color:
                                              Color(0xFF001B2E),
                                          fontSize: 12,
                                          fontFamily: 'Nunito',
                                          fontWeight:
                                              FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: kWidth(context) * 0.9,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 17,
                                        height: 17,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Opacity(
                                                opacity: 0.20,
                                                child:
                                                    Container(
                                                  width: 17,
                                                  height: 17,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Color(
                                                        0xFFFB9905),
                                                    shape:
                                                        OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 3,
                                              top: 3,
                                              child: Opacity(
                                                opacity: 0.80,
                                                child:
                                                    Container(
                                                  width: 11,
                                                  height: 11,
                                                  decoration:
                                                      const ShapeDecoration(
                                                    color: Color(
                                                        0xFFFB9905),
                                                    shape:
                                                        OvalBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        'Live Auction',
                                        style: TextStyle(
                                          color:
                                              Color(0xFF001B2E),
                                          fontSize: 18,
                                          fontFamily: 'Nunito',
                                          fontWeight:
                                              FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${state.auctionSessionInfoEntity.userAuctions.data.length} Bids made',
                                    style: const TextStyle(
                                      color: Color(0xFF001B2E),
                                      fontSize: 18,
                                      fontFamily: 'Nunito',
                                      fontWeight:
                                          FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(
                                        vertical: 22),
                                itemCount: state
                                    .auctionSessionInfoEntity
                                    .userAuctions
                                    .data
                                    .length,
                                itemBuilder: (context, index) {
                                  return _buildItemUserAuction(
                                      state
                                          .auctionSessionInfoEntity
                                          .userAuctions
                                          .data[index]);
                                },
                              ),
                            ),
                            SizedBox(
                                height: 40,
                                child: ListView.builder(
                                    scrollDirection:
                                        Axis.horizontal,
                                    itemCount:
                                        _generateRecommendListPriceAuction(
                                      state
                                          .auctionSessionInfoEntity
                                          .product
                                          .price,
                                      state
                                          .auctionSessionInfoEntity
                                          .userAuctions
                                          .data[0]
                                          .price,
                                          widget.productSimpleEntity.priceStep!
                                    ).length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, j) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets
                                                    .only(
                                                left: 8.0,
                                                right: 8.0),
                                        child: ElevatedButton(
                                            child: Text(
                                                _generateRecommendListPriceAuction(
                                              state
                                                  .auctionSessionInfoEntity
                                                  .product
                                                  .price,
                                              state
                                                  .auctionSessionInfoEntity
                                                  .userAuctions
                                                  .data[0]
                                                  .price,
                                                    widget.productSimpleEntity.priceStep!
                                            )[j].toString()),
                                            onPressed: () =>
                                                {
                                                  showPopUpConfirmAuction(
                                                      state.auctionSessionInfoEntity.product.id,
                                                      _generateRecommendListPriceAuction(
                                                          state
                                                              .auctionSessionInfoEntity
                                                              .product
                                                              .price,
                                                          state
                                                              .auctionSessionInfoEntity
                                                              .userAuctions
                                                              .data[0]
                                                              .price,
                                                          widget.productSimpleEntity.priceStep!
                                                      )[j].toString()
                                                  )
                                                }),
                                      );
                                    })),
                          ],
                        ),
                      );
                    }
                    return const Text(
                        "Thông tin phiên đấu giá");
                  }),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              );
            }),
          );
        });
  }



  List<int> _generateRecommendListPriceAuction(
      String priceProduct, String maxPriceProduct, String priceStepProduct) {
    int maxPrice = double.parse(maxPriceProduct).toInt();
    int price = double.parse(priceProduct).toInt();
    int step = double.parse(priceStepProduct).toInt();

    int priceRange = maxPrice - price;
    int numberSuggest = priceRange ~/ step;

    return [
      maxPrice + step,
      maxPrice + 2 * step,
      maxPrice + 3 * step,
      maxPrice + 4 * step,
      maxPrice + 5 * step,
    ];
  }

  Widget _buildItemUserAuction(UserAuctionData userAuctionData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: SizedBox(
        width: 343,
        height: 60,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: NetworkImage(userAuctionData.user.avatarUrl),
                      fit: BoxFit.fill,
                    ),
                    shape: const OvalBorder(),
                  ),
                ),
                const SizedBox(width: 11),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userAuctionData.user.name,
                      style: const TextStyle(
                        color: Color(0xFF001B2E),
                        fontSize: 20,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMEd().format(userAuctionData.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF001B2E),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      DateFormat.Hms().format(userAuctionData.createdAt),
                      style: const TextStyle(
                        color: Color(0xFF001B2E),
                        fontSize: 14,
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              '${double.parse(userAuctionData.price).toInt()} đ',
              style: const TextStyle(
                color: Color(0xFF001B2E),
                fontSize: 16,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPopUpConfirmAuction(int productId, String price) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Xác nhận tham gia đấu giá'),
            content: Text("Bạn xác nhận tham gia đấu giá với mức giá $price"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Huỷ bỏ')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => {
                        print("auction auction action"),
                        Navigator.pop(context),
                        BlocProvider.of<AuctionBloc>(context).add(ActionAuction(
                          productId,
                          price,
                        ))
                      },
                  child: const Text(
                    'Xác nhận',
                  )),
            ],
          );
        });
  }

  void showDialogAuctionFailed(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tham gia đấu giá thất bại'),
            content:
                 Text(message),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Đã hiểu')),
            ],
          );
        });
  }
  void showDialogAuctionSuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Tham gia đấu giá thành công'),
            content:
                const Text("Hiện bạn là người trả giá cao nhất cho sản phẩm"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Đã hiểu')),
            ],
          );
        });
  }
}
