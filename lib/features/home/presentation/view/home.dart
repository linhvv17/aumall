import 'package:aumall/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/home_bloc/home_event.dart';
import 'package:aumall/features/home/widgets/bannerads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/home/presentation/view/product_details.dart';
import '../../../../generated/l10n.dart';
import '../../../shop/presentation/bloc/products_bloc.dart';
import '../../widgets/customGridView.dart';
import '../../widgets/product_item_new.dart';
import '../bloc/bottom_nav/bottomNavigationBar_bloc.dart';
import '../bloc/home_bloc/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeView>{
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetBannerData());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<HomeBloc, HomeLoadState>(
              builder: (context, state){
                if(state is HomeStateDataLoaded){
                  print('HomeStateDataLoaded HomeStateDataLoaded HomeStateDataLoaded');
                  print('HomeStateDataLoaded ${state.bannerEntity.images}');
                  return  BannerAds(
                    images: [
                      state.bannerEntity.images
                    ],
                  );
                } else if(state is HomeErrorState){
                  return Text(state.message);
                } else {
                  return Container();
                }
              }
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.recentlyAddedProducts.toUpperCase(),
                  style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<BottomNavigationBarBloc>(context)
                        .add(LoadShop());
                    BlocProvider.of<ProductsBloc>(context).add(
                        GetSpecificProduct(
                            BlocProvider.of<ProductsBloc>(context).categories[0],
                            '0',
                            '100000',
                            '-1',
                            ''
                        )
                    );
                  },
                  child: Text(
                    S.current.allProducts,
                    style: const TextStyle(color: Colors.grey),
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
                return SizedBox(
                    height: kHeight(context) / 3,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          height: kWidth(context)/2, crossAxisCount: 1),
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
                return state.message == S.current.noInternetError
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.comingSoonProducts.toUpperCase(),
                  style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<BottomNavigationBarBloc>(context)
                        .add(LoadShop());
                    BlocProvider.of<ProductsBloc>(context).add(
                        GetSpecificProduct(
                            BlocProvider.of<ProductsBloc>(context).categories[0],
                            '0',
                            '100000',
                            '-1',
                            ''
                        )
                    );
                  },
                  child: Text(
                    S.current.allProducts,
                    style: const TextStyle(color: Colors.grey),
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
                return SizedBox(
                    height: kHeight(context) / 3,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: 10,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          height: kWidth(context)/2, crossAxisCount: 1),
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
                return state.message == S.current.noInternetError
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.current.todaySuggestProducts.toUpperCase(),
                  style: const TextStyle(color: Colors.deepOrangeAccent, fontSize: 20),
                ),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<BottomNavigationBarBloc>(context)
                        .add(LoadShop());
                    BlocProvider.of<ProductsBloc>(context).add(
                        GetSpecificProduct(
                            BlocProvider.of<ProductsBloc>(context).categories[0],
                            '0',
                            '100000',
                            '-1',
                            ''
                        )
                    );
                  },
                  child: Text(
                    S.current.allProducts,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kHeight(context)*0.8,
            child: BlocBuilder<ProductsBloc, ProductsState>(
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
                  return GridView.builder(
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
                  );
                } else if (state is AllProductsErrorState) {
                  return state.message == S.current.noInternetError
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
          ),
        ],
      ),
    );
  }
}
