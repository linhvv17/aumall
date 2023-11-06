import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/shopping/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/utils.dart';
import '../../../home/presentation/view/product_details.dart';

class ItemProductOfShop extends StatefulWidget {
  final ProductEntity productEntity;
  bool? isAuctionProduct;
  int? typeProduct;
  ItemProductOfShop(
      {super.key, required this.productEntity, this.isAuctionProduct, this.typeProduct});

  @override
  State<StatefulWidget> createState() => _ItemProductOfShopState();
}

class _ItemProductOfShopState extends State<ItemProductOfShop> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                productEntityId: widget.productEntity.id!,
                index: 0,
                isFavorite: false,
                isFromAuction: false,
              ),
            )
        );
      },
      child: SizedBox(
        width: kWidth(context)/2 - 16,
        child: Container(
          decoration: BoxDecoration(
              color: BlocProvider.of<ThemeBloc>(context).themeData ==
                      appThemeData[AppTheme.lightTheme]
                  ? ColorManager.white
                  : Colors.white.withOpacity(0.2),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    widget.productEntity.thumbnailUrl!,
                    // height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  widget.productEntity.title!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: Utils.convertPrice(
                            widget.productEntity.price!),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: ColorManager.dark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3.0),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemCount: 1,
                      itemSize: 25.0,
                      rating:
                      widget.productEntity.ratingNumber != null
                          ? double.parse(widget.productEntity.ratingNumber!)

                          : 0.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(${widget.productEntity.ratingNumber!})',
                      style:
                      Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
