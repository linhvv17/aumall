import 'package:aumall/app/widgets/skeleton.dart';
import 'package:aumall/features/shopping/presentation/widgets/loading_shopping_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/item_product_loading.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../home/widgets/customGridView.dart';

class LoadingAuctionScreen extends StatelessWidget {
  const LoadingAuctionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics()),
        itemCount: 6,
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
    );
  }
}
