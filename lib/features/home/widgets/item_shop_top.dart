import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/home/domain/entities/shop_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/colors/colors.dart';
import '../../../core/theme/bloc/theme_bloc.dart';
import '../../../core/theme/theme_data.dart';
import '../../../core/utilities/enums.dart';

class ItemShopTop extends StatefulWidget {
  const ItemShopTop(
      {super.key, required this.shopEntity,});

  final ShopEntity shopEntity;

  @override
  State<StatefulWidget> createState() => _ItemShopTopState();
}

class _ItemShopTopState extends State<ItemShopTop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 250,
        decoration: BoxDecoration(
            color: BlocProvider.of<ThemeBloc>(context).themeData ==
                    appThemeData[AppTheme.lightTheme]
                ? ColorManager.white
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[3]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Stack(
              children: [
                Center(
                  child: Image.network(
                    widget.shopEntity.image_url!,
                    height: kHeight(context)/5,
                    width: kHeight(context)/5,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.deepOrange),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text("AuMall"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.green),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.shopEntity.name!,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
