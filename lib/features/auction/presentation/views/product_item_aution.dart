import 'package:aumall/features/auction/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';


class ProductItemAuction extends StatefulWidget {
  final ProductEntity productEntity;
  bool? isAuctionProduct;
  int? typeProduct;
  ProductItemAuction(
      {super.key, required this.productEntity, this.isAuctionProduct, this.typeProduct});

  @override
  State<StatefulWidget> createState() => _ProductItemAuctionState();
}

class _ProductItemAuctionState extends State<ProductItemAuction> {
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
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    widget.productEntity.thumbnailUrl!,
                    width: kWidth(context)/2,
                    height: kWidth(context)/3,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
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
                          '(${widget.productEntity.reviewNumber})',
                          style:
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 8.0),
                    // Text(
                    //   widget
                    //       .productEntity.categoryOfProductEntity!.name!,
                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    //     color: ColorManager.grey,
                    //   ),
                    // ),
                    const SizedBox(height: 6.0),
                    Text(
                      widget.productEntity.title!,
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
                                widget.productEntity.price!),
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
                        width: kWidth(context) * 0.3,
                        height: 30,
                        decoration: ShapeDecoration(
                          color:  (widget.typeProduct! == 1)? Colors.lightBlue:(widget.typeProduct! == 2)? Colors.green: Colors.red ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Center(child: Text(S.current.auction)),
                      ),
                      onTap: () {
                        //1: now
                        (widget.typeProduct! == 2) ?
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                productEntityId:
                                widget.productEntity.id!,
                                index: 1,
                                isFromAuction: widget.isAuctionProduct!
                                    ? true
                                    : false,
                                isFavorite: false,
                                priceStep: widget.productEntity.priceStep,
                              ),
                            )) :
                        //2: coming
                        (widget.typeProduct! == 1) ?
                        showDialogCanNotAuction(1) :
                        //3: finished
                        showDialogCanNotAuction(3)
                        ;
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


  void showDialogCanNotAuction(int type) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(type == 1 ? 'Phiên đấu giá chưa diễn ra'
                : 'Phiên đấu giá đã kết thúc'),
            content:
            Text(type == 1 ? 'Hãy quay lại khi phiên đấu giá bắt đầu'
                : 'Rất tiếc. Hãy tham khảo sản phẩm khác của chúng tôi'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Đã hiểu')),
            ],
          );
        });
  }
}
