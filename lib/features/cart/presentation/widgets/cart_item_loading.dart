import 'package:aumall/app/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/mediaquery.dart';

class CartItemLoading extends StatelessWidget {
  const CartItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Container(
        clipBehavior: Clip.antiAlias,
        width: kWidth(context),
        height: kHeight(context) / 6,
        decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: kElevationToShadow[3]
        ),
        child: Row(
          children: [
            const Skeleton(100, 100),
            Expanded(
                child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: kWidth(context) * 0.5,
                          child: const Skeleton(100, 20)
                        ),
                        const Skeleton(100, 16)
                      ],
                    ),
                    const Skeleton(20, 20)
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: kWidth(context) * .33,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Skeleton(20, 20),
                            Skeleton(20, 20),
                            Skeleton(20, 20),
                          ],
                        ),
                      ),
                      const Skeleton(100, 20),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
