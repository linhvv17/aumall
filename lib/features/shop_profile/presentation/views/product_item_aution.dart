import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shopping/domain/entities/products_entity.dart';
import '../bloc/shop_profile_bloc.dart';

class ProductAuctionAuMall extends StatefulWidget {
  const ProductAuctionAuMall({super.key, required this.productFavoriteEntity});
  final ProductAuMallEntity productFavoriteEntity;

  @override
  State<StatefulWidget> createState() => _ProductAuctionAuMallState();
}

class _ProductAuctionAuMallState extends State<ProductAuctionAuMall> {
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
                                  ? double.parse(widget.productFavoriteEntity.ratingNumber!)
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
                    // Text(
                    //   product.category,
                    //   style: Theme.of(context).textTheme.caption!.copyWith(
                    //         color: ColorManager.grey,
                    //       ),
                    // ),
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
                            text: '${widget.productFavoriteEntity.price} \$',
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
