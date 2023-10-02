import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/shop_profile/domain/entities/shop_product_entity.dart';
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

class ItemProductSale extends StatefulWidget {
  final ShopProductEntity shopProductEntity;
  const ItemProductSale(
      {super.key, required this.shopProductEntity});

  @override
  State<StatefulWidget> createState() => _ItemProductSaleState();
}

class _ItemProductSaleState extends State<ItemProductSale> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(
                productEntityId: widget.shopProductEntity.id!,
                index: 0,
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
              border: Border.all(color: Colors.deepOrange),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.shopProductEntity.thumbnailUrl!,
                    width: kWidth(context) / 4,
                    height: kWidth(context) / 4,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.shopProductEntity.title!),
                      Text(widget.shopProductEntity
                          .description!),
                      Row(
                        children: [
                          const Text("??? ",
                            style: TextStyle(
                                color: Colors.blue),),
                          Text(
                            Utils.convertPrice(
                                widget.shopProductEntity.price!),
                            style: const TextStyle(
                                color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
