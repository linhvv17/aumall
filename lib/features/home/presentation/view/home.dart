import 'package:aumall/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/home_bloc/home_event.dart';
import 'package:aumall/features/home/presentation/view/product_details.dart';
import 'package:aumall/features/home/widgets/bannerads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
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

class _HomeState extends State<HomeView> {
  @override
  void initState() {
    // BlocProvider.of<HomeBloc>(context).add(GetBannerData());
    // BlocProvider.of<HomeBloc>(context).add(GetListProductHomeData());
    BlocProvider.of<HomeBloc>(context).add(GetDataHome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocListener<HomeBloc, HomeLoadState>(
        listener: (context, state) {
          // do stuff here based on BlocA's state
          if (state is HomeErrorState) {
            //show popup direct to login
            if(state.message == S.current.unauthorizedError){
              showAlertDialogUnauthorizedError();
            }
          }
        },
        child: BlocBuilder<HomeBloc, HomeLoadState>(builder: (context, state) {
          if (state is HomeStateLoading) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const CircularProgressIndicator(),
                  Text(S.current.dataLoading)
                ],
              ),
            );
          } else if (state is HomeStateGetDataSuccess) {
            final newProducts =
                state.listProductHomeEntity!.listProductHomeData.newProducts;

            final comingSoonProducts = state
                .listProductHomeEntity!.listProductHomeData.comingSoonProducts;

            final suggestionProducts = state
                .listProductHomeEntity!.listProductHomeData.suggestionProducts;

            return ListView(children: [
              BannerAds(
                images: [state.bannerEntity!.images],
              ),
              //new
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.recentlyAddedProducts.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.deepOrangeAccent, fontSize: 18),
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
                  height: kHeight(context) *2 / 3,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: newProducts?.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            height: kWidth(context) / 2, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  productSimpleEntity: newProducts[index],
                                  index: index,
                                  isFromAuction: false,
                                ),
                              ));
                        },
                        child: Hero(
                          tag: '$index',
                          child: NewProductItem(
                            product: newProducts![index],
                          ),
                        ),
                      );
                    },
                  )),

              //coming soon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.comingSoonProducts.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.deepOrangeAccent, fontSize: 20),
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
                  height: kHeight(context) / 3,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: comingSoonProducts?.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            height: kWidth(context) / 2, crossAxisCount: 1),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  productSimpleEntity:
                                      comingSoonProducts![index],
                                  index: index,
                                ),
                              ));
                        },
                        child: Hero(
                          tag: '$index',
                          child: NewProductItem(
                            product: newProducts![index],
                          ),
                        ),
                      );
                    },
                  )),

              //suggest
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.current.todaySuggestProducts.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.deepOrangeAccent, fontSize: 20),
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
                  height: kHeight(context) / 3,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: suggestionProducts?.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            height: kWidth(context) / 2, crossAxisCount: 1),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                  productSimpleEntity:
                                      suggestionProducts![index],
                                  index: index,
                                ),
                              ));
                        },
                        child: Hero(
                          tag: '$index',
                          child: NewProductItem(
                            product: newProducts![index],
                          ),
                        ),
                      );
                    },
                  ))
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
            content:  Text("${S.current.unauthorizedError} \nHãy đăng nhập lại để tiếp tục sử dụng"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
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
