import 'package:aumall/app/widgets/item_product_loading.dart';
import 'package:aumall/app/widgets/skeleton.dart';
import 'package:flutter/material.dart';

import '../../../../core/utilities/mediaquery.dart';
import '../../../home/widgets/customGridView.dart';

class LoadingShoppingProduct extends StatelessWidget {
  const LoadingShoppingProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),

          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                child: const Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Skeleton(50.00, 50.00)
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Skeleton(60.00, 18.00)
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                Skeleton(54.00, 18.00),
                                SizedBox(
                                  width: 10,
                                ),
                                Skeleton(108.00, 18.00)
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                height: 300,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 2,
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
            ],
          ),
        ),
      ),
    );
  }
}
