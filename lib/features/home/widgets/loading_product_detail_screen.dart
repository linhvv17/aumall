import 'package:aumall/app/widgets/item_product_loading.dart';
import 'package:aumall/app/widgets/skeleton.dart';
import 'package:flutter/material.dart';
import '../../../core/utilities/mediaquery.dart';
import 'customGridView.dart';

class LoadingProductDetailScreen extends StatelessWidget {
  const LoadingProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Skeleton(kWidth(context), kHeight(context) * 0.3,),
      //new
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Skeleton(kWidth(context)/2, 50,),
            Skeleton(kWidth(context)/3, 50),
          ],
        ),
      ),
      SizedBox(
        height: 550,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(10),
          itemCount:4,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              height: 250,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return const ItemProductLoading();
          },
        ),
      ),
    ]);
  }
}
