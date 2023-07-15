import 'package:aumall/features/shop/domain/entities/categories_entity.dart';
import 'package:aumall/features/shop/domain/repositories/product_repository.dart';
import 'package:aumall/features/shop/presentation/widgets/sort_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import '../../../../core/colors/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../favorite/presentation/views/product_item_favorite.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../home/widgets/customGridView.dart';
import '../../../home/widgets/product_item.dart';
import '../../domain/entities/products_entity.dart';
import '../bloc/products_bloc.dart';
import '../widgets/filter.dart';
import '../widgets/search.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});
  @override
  State<StatefulWidget> createState()  => _ShopViewState();
}


class _ShopViewState extends State<ShopView> {

  final List<Map<String, dynamic>> sortBys = [
    {'id': 0, 'name': 'Phổ biến nhất', 'isSelected': true},
    {'id': 1, 'name': 'Mới nhất', 'isSelected': false},
    {'id': 2, 'name': 'Đánh giá của khách hàng', 'isSelected': false},
    {'id': 3, 'name': 'Giá: Từ thấp đến cao', 'isSelected': false},
    {'id': 4, 'name': 'Giá: Từ cao đến thấp', 'isSelected': false},
  ];

  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(GetShopDataDefault(
      // GetShopDataDefaultParams(
      //     "1",
      //     "minPrice",
      //     "maxPrice",
      //     "rate",
      //     ""
      // )
    ));

    BlocProvider.of<ProductsBloc>(context).add(GetProductsShop(
        GetShopDataDefaultParams(
            "1",
            "minPrice",
            "maxPrice",
            "rate",
            ""
        )
    ));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    int current = 0;
    List<CategoryEntity> categories = [];
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<ProductsBloc>(context).add(GetProductsShop(
              GetShopDataDefaultParams(
                  "1",
                  "minPrice",
                  "maxPrice",
                  "rate",
                  ""
              )
          ));
        },
        child: SafeArea(
          child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                final bloc = BlocProvider.of<ProductsBloc>(context);
                if(state is GetShopDefaultDataLoadedState){
                  print('GetShopDefaultDataLoadedState');
                  print('GetShopDefaultDataLoadedState ${state.categoriesEntity.categories.length}');
                  categories = state.categoriesEntity.categories;
                }
                return Column(
                  children: [
                    Text(
                      S.current.shop,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SortProduct(
                          sortBys: sortBys,
                        ),
                        const Expanded(child: SearchWidget()),
                        const FilterProduct(),
                      ],
                    ),
                    //list categories
                    BlocBuilder<ProductsBloc, ProductsState>(
                      buildWhen:(pre, current) {
                        return (current is GetShopDefaultDataLoadedState);
                      },
                        builder: (context, state) {
                        if(state is GetShopDefaultDataLoadedState){
                          // BlocProvider.of<ProductsBloc>(context).add(GetProductsShop(
                          //     GetShopDataDefaultParams(
                          //         state.categoriesEntity.categories[0].id.toString(),
                          //         "minPrice",
                          //         "maxPrice",
                          //         "rate",
                          //         ""
                          //     )
                          // ));
                        }
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: categories.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, index) {
                                    return Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            print("clickkkkkkkkkkkkk ${categories[index].id}");
                                            bloc.add(ChangeCategory(index));
                                            BlocProvider.of<ProductsBloc>(context).add(GetProductsShop(
                                                GetShopDataDefaultParams(
                                                    categories[index].id.toString(),
                                                    "minPrice",
                                                    "maxPrice",
                                                    "rate",
                                                    ""
                                                )
                                            ));

                                            current = index;
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            margin: const EdgeInsets.all(5),
                                            width: 80,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              color:  Colors.white70,

                                              borderRadius: bloc.current == index
                                                  ? BorderRadius.circular(15)
                                                  : BorderRadius.circular(10),
                                              border: bloc.current == index
                                                  ? Border.all(
                                                  color: ColorManager.orangeLight,
                                                  width: 2)
                                                  : null,
                                            ),
                                            child: Center(
                                              child: FittedBox(
                                                child: Text(
                                                  categories[index].name,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      color: bloc.current == index
                                                          ? Colors.black
                                                          : Colors.grey),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            ),
                          );
                      }
                    ),

                    //list products
                    BlocBuilder<ProductsBloc, ProductsState>(
                      builder: (context, state) {
                        if (state is ProductsLoadingState) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: kHeight(context) / 3,
                              ),
                              const CircularProgressIndicator(),
                            ],
                          );
                        }
                        else if (state is GetProductsShopLoadedState) {
                          final List<ProductAuMallEntity> listProduct = state.listProductShopEntity.listProductAuMall;
                          return listProduct.isEmpty ?
                              const Center(child: Text("Không có sản phầm nào!!!!!!!!!!!!!!!")) :
                            Expanded(child: GridView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.listProductShopEntity.listProductAuMall.length,
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
                                                productSimpleEntity: state.listProductShopEntity.listProductAuMall[index],
                                                index: index,
                                              ),
                                            ));
                                      },
                                      child: Hero(
                                          tag: '$index',
                                          child:
                                          ProductItemAuMall(productFavoriteEntity: state.listProductShopEntity.listProductAuMall[index],)
                                  ));
                                },
                              ));
                        }
                        else if (state is ProductsErrorState ) {
                          return state.message == S.current.noInternetError
                              ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                child: Card(child: LottieBuilder.asset('assets/images/nointernet.json')),
                              ),
                              Card(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(state.message),
                              ))
                            ],
                          )
                              : Center(child: Text(state.message));
                        }
                        // else if (state is FilterProductsLoadedState) {
                        //   final products = state.data.products;
                        //   return Expanded(
                        //       child: GridView.builder(
                        //         padding: EdgeInsets.zero,
                        //         itemCount: state.data.filteredProductsCount,
                        //         gridDelegate:
                        //         const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        //             height: 330, crossAxisCount: 2),
                        //         itemBuilder: (context, index) {
                        //           return InkWell(
                        //               onTap: () {
                        //                 // Navigator.push(
                        //                 //     context,
                        //                 //     MaterialPageRoute(
                        //                 //       builder: (context) => ProductDetails(
                        //                 //         product: products[index],
                        //                 //         products: products,
                        //                 //         index: index,
                        //                 //       ),
                        //                 //     ));
                        //               },
                        //               child: Hero(
                        //                   tag: '$index',
                        //                   child:Container()
                        //                   // ProductItem(product: products[index])
                        //           ));
                        //         },
                        //       ));
                        //
                        // }
                        // else if (state is SpecificProductsLoadedState) {
                        //   final products = state.data.products;
                        //   return Expanded(
                        //       child: GridView.builder(
                        //         padding: EdgeInsets.zero,
                        //         itemCount: state.data.filteredProductsCount,
                        //         gridDelegate:
                        //         const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        //             height: 330, crossAxisCount: 2),
                        //         itemBuilder: (context, index) {
                        //           return InkWell(
                        //               onTap: () {
                        //                 // Navigator.push(
                        //                 //     context,
                        //                     // MaterialPageRoute(
                        //                     //   builder: (context) => ProductDetails(
                        //                     //     product: products[index],
                        //                     //     products: products,
                        //                     //     index: index,
                        //                     //   ),
                        //                     // ));
                        //               },
                        //               child: Hero(
                        //                   tag: '$index',
                        //                   child: Container()
                        //                   // ProductItem(product: products[index])
                        //               ));
                        //         },
                        //       ));
                        // }
                        // else if (state is SpecificProductsErrorState ) {
                        //   return state.message == S.current.noInternetError
                        //       ? Column(
                        //     children: [
                        //       Padding(
                        //
                        //         padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 19),
                        //         child: Card(
                        //             clipBehavior: Clip.antiAlias,
                        //             child: LottieBuilder.asset('assets/images/nointernet.json')),
                        //       ),
                        //       Card(child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Text(state.message),
                        //       ))
                        //     ],
                        //   )
                        //       : Center(child: Text(state.message));
                        // }
                        else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
