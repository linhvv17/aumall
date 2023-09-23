import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/utils.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shopping/domain/entities/products_entity.dart';

class ItemProductOfShop extends StatefulWidget {
  final ProductAuMallEntity productAuMallEntity;
  bool? isAuctionProduct;
  int? typeProduct;
  ItemProductOfShop(
      {super.key, required this.productAuMallEntity, this.isAuctionProduct, this.typeProduct});

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
                productSimpleEntity: widget.productAuMallEntity,
                index: 0,
                isFromAuction: false,
              ),
            ));
      },
      child: SizedBox(
        width: kWidth(context)/2 - 16,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: BlocProvider.of<ThemeBloc>(context).themeData ==
                        appThemeData[AppTheme.lightTheme]
                    ? ColorManager.white
                    : Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.productAuMallEntity.thumbnailUrl!,
                  height: 100,
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  widget.productAuMallEntity.title!,
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
                            widget.productAuMallEntity.price!),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: ColorManager.dark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    RatingBarIndicator(
                      itemCount: 1,
                      itemSize: 25.0,
                      rating:
                      widget.productAuMallEntity.ratingNumber != null
                          ? double.parse(widget.productAuMallEntity.ratingNumber!)

                          : 0.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(${widget.productAuMallEntity.ratingNumber!})',
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
