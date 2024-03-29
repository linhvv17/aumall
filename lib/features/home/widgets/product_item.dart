import 'package:aumall/features/home/data/models/detail_product_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../core/colors/colors.dart';
import '../../../core/theme/theme_data.dart';
import '../../../core/utilities/enums.dart';
import '../../../core/utilities/mediaquery.dart';
import '../../../core/utilities/strings.dart';
import '../../../generated/l10n.dart';
import '../../favorite/presentation/bloc/favourite_bloc.dart';
import '../../login/presentation/widgets/alert_snackbar.dart';
import '../../shop/domain/entities/products_entity.dart';
import '../data/models/product_detail_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final RelatedProducts product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            color: BlocProvider.of<ThemeBloc>(context).themeData== appThemeData[AppTheme.lightTheme]
                    ? ColorManager.white
                    : Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Image.network(
              product.thumbnailUrl!,
              width: 200,
              height: 200,
            ),
            Positioned(
              left: kWidth(context) * 0.3,
              bottom: kHeight(context) * 0.13,
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
                   if(state is AddToFavouriteState){
                       showSnackbar(S.current.addfav,context, Colors.green);
                }else if(state is RemoveFromFavoriteState){
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
                             // BlocProvider.of<FavouriteBloc>(context).add(
                             //    AddToFavorite(
                             //        product: product,
                             //        isFavourite: product.isFavourite,
                             //        ));
                          },
                          child:
                          const Icon(
                            Icons.favorite,
                            size: 20.0,
                            color: ColorManager.orangeLight,
                          ),
                          // product.isFavourite
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
                          rating: product.ratingNumber != null ?
                          product.ratingNumber!.toDouble() : 0.0,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          '(${product.reviewNumber})',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    // Text(
                    //   product.category,
                    //   style: Theme.of(context).textTheme.caption!.copyWith(
                    //         color: ColorManager.grey,
                    //       ),
                    // ),
                    const SizedBox(height: 6.0),
                    Text(
                      product.title!,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6.0),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${product.price} \$',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
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
