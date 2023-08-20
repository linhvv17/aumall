import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../bloc/favourite_bloc.dart';

class ProductItemAuMall extends StatefulWidget {
  final ProductAuMallEntity productFavoriteEntity;
  bool? isAuctionProduct;
  ProductItemAuMall(
      {super.key, required this.productFavoriteEntity, this.isAuctionProduct});

  @override
  State<StatefulWidget> createState() => _ProductItemAuMallState();
}

class _ProductItemAuMallState extends State<ProductItemAuMall> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: BlocProvider.of<ThemeBloc>(context).themeData ==
                    appThemeData[AppTheme.lightTheme]
                ? ColorManager.white
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Image.network(
              widget.productFavoriteEntity.thumbnailUrl!,
              width: 200,
              height: 200,
            ),
            widget.isAuctionProduct!
                ? Container()
                : Positioned(
                    left: kWidth(context) * 0.34,
                    bottom: kHeight(context) * 0.008,
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
                            showSnackbar(
                                S.current.addfav, context, Colors.green);
                          } else if (state is RemoveFromFavoriteState) {
                            showSnackbar(
                                S.current.deletefav, context, Colors.green);
                          }
                        },
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: ColorManager.white,
                            radius: 20.0,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<FavouriteBloc>(context).add(
                                      widget.productFavoriteEntity.isFavorite!
                                          ? RemoveFavoriteProduct(
                                              widget.productFavoriteEntity.id!)
                                          : AddToFavorite(
                                              product:
                                                  widget.productFavoriteEntity,
                                              isFavourite: widget
                                                  .productFavoriteEntity
                                                  .isFavorite!,
                                            ));
                                  setState(() {
                                    widget.productFavoriteEntity.isFavorite =
                                        !widget
                                            .productFavoriteEntity.isFavorite!;
                                  });
                                },
                                child: widget.productFavoriteEntity.isFavorite!
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
                          );
                        },
                      ),
                    ),
                  ),
            Positioned(
              bottom: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBarIndicator(
                          itemSize: 25.0,
                          rating:
                              widget.productFavoriteEntity.ratingNumber != null
                                  ? widget.productFavoriteEntity.ratingNumber!
                                      .toDouble()
                                  : 0.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '(${widget.productFavoriteEntity.reviewNumber})',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget
                          .productFavoriteEntity.categoryOfProductEntity!.name!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManager.grey,
                          ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      widget.productFavoriteEntity.title!,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Utils.convertPrice(
                                widget.productFavoriteEntity.price!),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ColorManager.dark),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    widget.isAuctionProduct!
                        ? InkWell(
                            child: Container(
                              width: kWidth(context) * 0.4,
                              height: 30,
                              decoration: ShapeDecoration(
                                color: Colors.deepOrangeAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Center(child: Text(S.current.auction)),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      productSimpleEntity:
                                          widget.productFavoriteEntity,
                                      index: 1,
                                      isFromAuction: widget.isAuctionProduct!
                                          ? true
                                          : false,
                                    ),
                                  ));
                            },
                          )
                        : Container()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
