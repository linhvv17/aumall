import 'package:aumall/app/widgets/skeleton.dart';
import 'package:aumall/features/shopping/presentation/widgets/loading_shopping_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utilities/mediaquery.dart';

class LoadingShoppingScreen extends StatelessWidget {
  const LoadingShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(children: [
              const SizedBox(height: 30,),
              const Center(child: Skeleton(100, 30,)),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Skeleton(40, 40,),
                  Skeleton(kWidth(context)*2/3, 40,),
                  const Skeleton(40, 40,),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Skeleton(kWidth(context)/4.5, 45,),
                  Skeleton(kWidth(context)/4.5, 45,),
                  Skeleton(kWidth(context)/4.5, 45,),
                  Skeleton(kWidth(context)/4.5, 45,),
                ],
              ),
              //new
              const LoadingShoppingProduct(),
            ]),
          ),
          // const Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       CupertinoActivityIndicator(
          //         radius: 20.0,
          //         color: CupertinoColors.activeBlue,
          //       ),
          //       SizedBox(height: 10,),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
