import 'package:aumall/features/shopping/domain/entities/categories_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/product/products_order_by_shop_entity.dart';
import '../bloc/categories/categories_bloc.dart';
import '../bloc/products_bloc.dart';
import '../widgets/filter.dart';
import '../widgets/item_shop_and_product.dart';
import '../widgets/loading_shopping_product.dart';
import '../widgets/loading_shopping_screen.dart';
import '../widgets/search.dart';
import '../widgets/sort_by.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<StatefulWidget> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> sortBys = [
    {
      'id': 0,
      'name': 'Phổ biến nhất',
      'isSelected': true,
      'key': 'is_featured'
    },
    {'id': 0, 'name': 'Flash Sale', 'isSelected': true, 'key': 'flash_sale'},
    // {'id': 1, 'name': 'Mới nhất', 'isSelected': false, 'key': ''},
    // {'id': 2, 'name': 'Đánh giá của khách hàng', 'isSelected': false, 'key': ''},
    // {'id': 3, 'name': 'Giá: Từ thấp đến cao', 'isSelected': false, 'key': ''},
    // {'id': 4, 'name': 'Giá: Từ cao đến thấp', 'isSelected': false, 'key': ''},
  ];

  @override
  void initState() {
    BlocProvider.of<CategoriesBloc>(context).add(const GetCategories());
    // BlocProvider.of<ProductsBloc>(context).add(const GetShopDataDefault());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int current = 0;
    TabController tabController;

    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (oldState, newState) {
      if (newState is CategoriesLoadingState) {
        return const LoadingShoppingScreen();
      }

      if (newState is ShopLoadingData) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // The loading indicator
              const CupertinoActivityIndicator(
                radius: 20.0,
                color: CupertinoColors.activeBlue,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(S.current.dataLoading)
            ],
          ),
        );
      }

      if (newState is CategoriesLoadedState) {
        CategoriesEntity categoriesEntity = newState.categoriesEntity;
        final listCategory = categoriesEntity.categories;
        BlocProvider.of<ProductsBloc>(context)
            .add(GetListProductOfCategory(listCategory[0].id));
        return DefaultTabController(
            length: listCategory.length,
            child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                    title: Text(
                      S.current.shop,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(100),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // SortProduct(
                              //   sortBys: sortBys,
                              // ),
                              const Expanded(child: SearchWidget()),
                              // const FilterProduct(),
                            ],
                          ),
                          Material(
                            color: Colors.deepOrange,
                            child: TabBar(
                              labelColor: Colors.white ,
                              unselectedLabelColor: Colors.white,
                              indicator: UnderlineTabIndicator(
                                borderSide: const BorderSide(
                                    width: 2.0,
                                    color: Colors.white),
                                insets: EdgeInsets.symmetric(
                                    horizontal: kWidth(context) / 10, vertical: 10),
                              ),
                              onTap: (tabIndex) {
                                BlocProvider.of<ProductsBloc>(context).add(
                                    GetListProductOfCategory(
                                        listCategory[tabIndex].id));
                              },
                              isScrollable: true,
                              tabs: listCategory
                                  .map((e) => Tab(
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    )),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: listCategory
                      .map(
                        (category) => BlocBuilder<ProductsBloc, ProductsState>(
                            builder: (context, state) {
                          if (state is ShopLoadingDataProducts) {
                            return const LoadingShoppingProduct();
                          }
                          if (state is ShopLoadDataErrorState) {
                            return Text(state.message);
                          }
                          if (state is ShopLoadProductsSuccessWithFilter) {
                            List<ProductsOrderByShopEntity> listProductShopEntity =
                                state.listProductShopEntity;
                            return PageStorage(
                              bucket: PageStorageBucket(),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: listProductShopEntity
                                              .isEmpty
                                          ? Center(
                                              child: Text(
                                                S.current.noProducts,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            )
                                          : RefreshIndicator(
                                              onRefresh: () async {
                                                BlocProvider.of<ProductsBloc>(
                                                        context)
                                                    .add(
                                                        GetListProductOfCategory(
                                                            category.id));
                                              },
                                              child:
                                                  ListView.builder(
                                                      itemCount:
                                                          listProductShopEntity
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ItemShopAndProduct(
                                                          shop:
                                                              listProductShopEntity
                                                                  [index].shopEntity,
                                                          productEntities:
                                                              listProductShopEntity
                                                              [index].products,
                                                        );
                                                      })

                                              ))
                                ],
                              ),
                            );
                          }
                          return Container();
                        }),
                      )
                      .toList(),
                )));
      }

      return Container();
    });
  }
}
