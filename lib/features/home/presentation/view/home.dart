import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/home_bloc/home_event.dart';
import 'package:aumall/features/home/presentation/view/product_details.dart';
import 'package:aumall/features/home/widgets/bannerads.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../shop_profile/presentation/views/shop_profile.dart';
import '../../../shopping/presentation/bloc/products_bloc.dart';
import '../../widgets/customGridView.dart';
import '../../widgets/item_shop_top.dart';
import '../../widgets/loading_home_screen.dart';
import '../../widgets/product_item_new.dart';
import '../bloc/bottom_nav/bottomNavigationBar_bloc.dart';
import '../bloc/home_bloc/home_state.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetDataHome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
          child: BlocListener<HomeBloc, HomeLoadState>(
            listener: (context, state) {
              // do stuff here based on BlocA's state
              if (state is HomeErrorState) {
                //show popup direct to login
                if (state.message == S.current.unauthorizedError) {
                  showAlertDialogUnauthorizedError();
                }
              }
            },
            child:
                BlocBuilder<HomeBloc, HomeLoadState>(builder: (context, state) {
              if (state is HomeStateLoading) {
                return const LoadingHomeScreen();
              }
              else if (state is HomeStateGetDataSuccess) {
                final newProducts = state
                    .listProductHomeEntity!.listProductHomeData.newProducts;

                final comingSoonProducts = state.listProductHomeEntity!
                    .listProductHomeData.comingSoonProducts;

                final suggestionProducts = state.listProductHomeEntity!
                    .listProductHomeData.suggestionProducts;

                final shops = state.shopEntities;

                return ListView(children: [
                  BannerAds(
                    images: [state.bannerEntity!.images],
                  ),
                  //new
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: kWidth(context)/40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.recentlyAddedProducts.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<BottomNavigationBarBloc>(context)
                                .add(LoadShop());
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetSpecificProduct(
                                    BlocProvider.of<ProductsBloc>(context)
                                        .categoriesEntity[0]
                                        .name,
                                    '0',
                                    '100000',
                                    '-1',
                                    ''));
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
                    height: 550,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10),
                      itemCount:
                          newProducts!.length > 4 ? 4 : newProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              height: 250,
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    productEntityId: newProducts[index].id!,
                                    index: index,
                                    isFromAuction: false,
                                    isFavorite: newProducts[index].isFavorite!,
                                  ),
                                ));
                          },
                          child: NewProductItem(
                            product: newProducts[index],
                            typeProduct: 1,
                          ),
                        );
                      },
                    ),
                  ),

                  //coming soon
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.comingSoonProducts.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<BottomNavigationBarBloc>(context)
                                .add(LoadShop());
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetSpecificProduct(
                                    BlocProvider.of<ProductsBloc>(context)
                                        .categoriesEntity[0]
                                        .name,
                                    '0',
                                    '100000',
                                    '-1',
                                    ''));
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
                      height: comingSoonProducts!.length > 2 ? 550 : 275,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        itemCount: comingSoonProducts.length > 4
                            ? 4
                            : comingSoonProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                height: 250,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      productEntityId:
                                          comingSoonProducts[index].id!,
                                      index: index,
                                      isFromAuction: false,
                                      isFavorite: comingSoonProducts[index].isFavorite!,
                                    ),
                                  ));
                            },
                            child: NewProductItem(
                              product: comingSoonProducts[index],
                              typeProduct: 2,
                            ),
                          );
                        },
                      )),

                  //suggest
                  suggestionProducts!.isEmpty ? Container() : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.todaySuggestProducts.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<BottomNavigationBarBloc>(context)
                                .add(LoadShop());
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetSpecificProduct(
                                    BlocProvider.of<ProductsBloc>(context)
                                        .categoriesEntity[0]
                                        .name,
                                    '0',
                                    '100000',
                                    '-1',
                                    ''));
                          },
                          child: Text(
                            S.current.allProducts,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  suggestionProducts.isEmpty ? Container() : SizedBox(
                      height: suggestionProducts.length > 2 ? 550 : 275,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        itemCount: suggestionProducts.length > 4
                            ? 4
                            : suggestionProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                height: 250,
                                crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                      productEntityId:
                                          suggestionProducts[index].id!,
                                      index: index,
                                      isFromAuction: false,
                                      isFavorite: suggestionProducts[index].isFavorite!,
                                    ),
                                  ));
                            },
                            child: NewProductItem(
                              product: suggestionProducts[index],
                              typeProduct: 3,
                            ),
                          );
                        },
                      )),

                  ///shop mall
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.current.topBrand.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.deepOrangeAccent, fontSize: 17),
                        ),
                        TextButton(
                          onPressed: () {
                            BlocProvider.of<BottomNavigationBarBloc>(context)
                                .add(LoadShop());
                            BlocProvider.of<ProductsBloc>(context).add(
                                GetSpecificProduct(
                                    BlocProvider.of<ProductsBloc>(context)
                                        .categoriesEntity[0]
                                        .name,
                                    '0',
                                    '100000',
                                    '-1',
                                    ''));
                          },
                          child: Text(
                            S.current.seeMore,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      height: shops!.length > 2 ? 550 : 275,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(10),
                        itemCount: shops.length > 4
                            ? 4
                            : shops.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            height: 250,
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ShopProfileView( shopId: shops[index].user_id!,),
                                  ));
                            },
                            child: ItemShopTop(
                              shopEntity: shops[index],
                            ),
                          );
                        },
                      )),

                  const SizedBox(height: 50),
                ]);
              } else if (state is HomeErrorState) {
                return Center(child: Text(state.message));
              } else {
                return Container();
              }
            }),
          ),
        ));
  }

  void showAlertDialogUnauthorizedError() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi xác thực'),
            content: Text(
                "${S.current.unauthorizedError} \nHãy đăng nhập lại để tiếp tục sử dụng"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // Write code to delete item
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.login, ModalRoute.withName('/'));
                  },
                  child: const Text(
                    'Yes',
                  )),
            ],
          );
        });
  }
}
