import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/favorite/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../bloc/favourite_bloc.dart';

class ItemProductFavorite extends StatefulWidget {
  final ProductEntity productEntity;
  const ItemProductFavorite(
      {super.key, required this.productEntity});

  @override
  State<StatefulWidget> createState() => _ItemProductFavoriteState();
}

class _ItemProductFavoriteState extends State<ItemProductFavorite> {
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
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Image.network(
                  widget.productEntity.thumbnailUrl!,
                  width: kWidth(context)/3,
                  height: kWidth(context)/3,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                    .copyWith(color: Colors.deepOrange),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6.0),
                      ],
                    ),
                  ),

                  Container(
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
                                    widget.productEntity.isFavorite!
                                        ? RemoveFavoriteProduct(
                                        widget.productEntity.id!)
                                        : AddToFavorite(
                                      productId:
                                      widget.productEntity.id!,
                                      isFavourite: widget
                                          .productEntity
                                          .isFavorite!,
                                    ));
                                setState(() {
                                  widget.productEntity.isFavorite =
                                  !widget
                                      .productEntity.isFavorite!;
                                });
                              },
                              child: widget.productEntity.isFavorite!
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
