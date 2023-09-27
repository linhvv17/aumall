import 'package:aumall/app/widgets/skeleton.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors/colors.dart';
import '../../core/theme/bloc/theme_bloc.dart';
import '../../core/theme/theme_data.dart';
import '../../core/utilities/enums.dart';

class ItemProductLoading extends StatelessWidget {
  const ItemProductLoading({super.key});

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
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Skeleton(kWidth(context)/2, kHeight(context)/8)
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Skeleton(60.00, 25.00),
                      Skeleton(60.00, 25.00)
                    ],
                  ),
                  SizedBox(height: 2.0),
                  //tittle
                  Skeleton(80.00, 20.00),
                  SizedBox(height: 2.0),
                  //name
                  Skeleton(60.00, 20.00),
                  SizedBox(height: 2.0),
                  //price
                  Skeleton(100.00, 20.00),
                  SizedBox(height: 2.0),
                  //rating
                  Skeleton(120.00, 20.00),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}