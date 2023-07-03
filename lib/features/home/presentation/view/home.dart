import 'package:aumall/features/home/widgets/banner.dart';
import 'package:aumall/features/shop/domain/entities/products_entity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/home/presentation/view/product_details.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/strings.dart';
import '../../../login/presentation/widgets/mainbutton.dart';
import '../../../shop/presentation/bloc/products_bloc.dart';
import '../../widgets/carousel.dart';
import '../../widgets/customGridView.dart';
import '../../widgets/header.dart';
import '../../widgets/product_item_new.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CarouselSlider(
            items: [
              Stack(children: [
                Container(
                  width: kWidth(context),
                  height: kHeight(context) * 0.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/header.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                    width: kWidth(context),
                    height: kHeight(context) * 0.5,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/opacity.png"),
                            fit: BoxFit.cover))),
                Positioned(
                  bottom: kHeight(context) * 0.05,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.headerTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: ColorManager.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppStrings.headerSuTitle,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorManager.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 200,
                          child: MainButton(
                              text: AppStrings.check, height: 40, ontab: () {}))
                    ],
                  ),
                ),
              ],),
              Stack(children: [
                Container(
                  width: kWidth(context),
                  height: kHeight(context) * 0.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/header.png"),
                          fit: BoxFit.cover)),
                ),
                Container(
                    width: kWidth(context),
                    height: kHeight(context) * 0.5,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/opacity.png"),
                            fit: BoxFit.cover))),
                Positioned(
                  bottom: kHeight(context) * 0.05,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.headerTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: ColorManager.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppStrings.headerSuTitle,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: ColorManager.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: 200,
                          child: MainButton(
                              text: AppStrings.check, height: 40, ontab: () {}))
                    ],
                  ),
                ),
              ])
            ],
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                height: kHeight(context) * 0.4,
            ),
          ),
          // const HomeHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.recentlyAddedProducts,
                ),
                TextButton(
                  onPressed: () {

                  },
                  child: const Text(
                    'All Products >>',
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is AllProductsLoadingState) {
                return const Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    CircularProgressIndicator(),
                  ],
                );
              } else if (state is AllProductsLoadedState) {
                final products = state.data.products.reversed.toList();
                return Expanded(
                    child: GridView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          height: 330, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetails(
                                product: products[index],
                                products: products,
                                index: index,
                              ),
                            ));
                      },
                      child: Hero(
                        tag: '$index',
                        child: NewProductItem(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                ));
              } else if (state is AllProductsErrorState) {
                return state.message == AppStrings.noInternetError
                    ? Expanded(
                      child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: FittedBox(child: Card(
                                clipBehavior: Clip.antiAlias,
                                child: SizedBox(

                                  height: kHeight(context)/4,
                                  child: LottieBuilder.asset('assets/images/nointernet.json')),
                              )),
                            ),
                            Card(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.message),
                            ))
                          ],
                        ),
                    )
                    : Center(child: Text(state.message));
              } else {
                return const SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
