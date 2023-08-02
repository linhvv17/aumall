import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import '../../../core/colors/colors.dart';
import '../../../core/theme/bloc/theme_bloc.dart';
import '../../../core/theme/theme_data.dart';
import '../../../core/utilities/enums.dart';
import '../../../core/utilities/mediaquery.dart';
import '../../../core/utilities/strings.dart';
import '../../../generated/l10n.dart';
import '../../login/presentation/widgets/alert_snackbar.dart';
import '../../shop/data/models/products_model.dart';
import '../../shop/domain/entities/products_entity.dart';

class NewProductItem extends StatefulWidget {
  const NewProductItem({super.key, required this.product});

  final ProductAuMallModel product;



  @override
  State<StatefulWidget> createState() => _NewProductItemState();
}

class _NewProductItemState extends State<NewProductItem>{


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
              widget.product.thumbnailUrl!,
              width: 200,
              height: 200,
            ),
            Positioned(
              top: 10,
              left: 8,
              child: Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.dark,
                ),
                child: Center(
                  child: Text(
                    S.current.newText.toUpperCase(),
                    style: const TextStyle(color: ColorManager.white),
                  ),
                ),
              ),
            ),
            // Positioned(
            //   left: kWidth(context) * 0.33,
            //   top: 5,
            //   child: Container(
            //       decoration: const BoxDecoration(
            //         shape: BoxShape.circle,
            //         boxShadow: [
            //           BoxShadow(
            //             blurRadius: 5,
            //             color: ColorManager.grey,
            //             spreadRadius: 2,
            //           )
            //         ],
            //       ),
            //       // child: product.isFavourite
            //       //     ? CircleAvatar(
            //       //         backgroundColor: ColorManager.orangeLight,
            //       //         radius: 20.0,
            //       //         child: Material(
            //       //           color: Colors.transparent,
            //       //           child: InkWell(
            //       //             onTap: () {},
            //       //             child: const Icon(
            //       //               Icons.shopping_bag,
            //       //               size: 20.0,
            //       //               color: ColorManager.white,
            //       //             ),
            //       //           ),
            //       //         ),
            //       //       )
            //       //     : const SizedBox()
            //     child: CircleAvatar(
            //       backgroundColor: ColorManager.orangeLight,
            //       radius: 20.0,
            //       child: Material(
            //         color: Colors.transparent,
            //         child: InkWell(
            //           onTap: () {},
            //           child: const Icon(
            //             Icons.shopping_bag,
            //             size: 20.0,
            //             color: ColorManager.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Positioned(
              left: kWidth(context) * 0.34,
              bottom: kHeight(context) * 0.007,
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
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<FavouriteBloc>(context)
                                .add(widget.product.isFavorite!
                                ? RemoveFavoriteProduct(widget.product.id!)
                                : AddToFavorite(
                              product: widget.product,
                              isFavourite: widget.product.isFavorite!,
                            ));

                            setState(() {
                              print('setState bf ${widget.product.isFavorite}');
                              widget.product.isFavorite = !widget.product.isFavorite!;
                              print('setState at ${widget.product.isFavorite}');
                            });
                          },
                          child: widget.product.isFavorite!
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
                          rating: widget.product.ratingNumber!.toDouble(),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '(${widget.product.ratingNumber})',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.product.title!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: ColorManager.grey,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      widget.product.title!,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.product.price} \$',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ColorManager.dark),
                          ),
                        ],
                      ),
                    ),
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
