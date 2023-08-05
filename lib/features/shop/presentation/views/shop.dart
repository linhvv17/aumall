import 'package:aumall/features/shop/domain/entities/categories_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/utilities/mediaquery.dart';

import '../../../../generated/l10n.dart';
import '../../../favorite/presentation/views/product_item_aumall.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../home/widgets/customGridView.dart';
import '../../domain/entities/products_entity.dart';
import '../bloc/products_bloc.dart';
import '../widgets/filter.dart';
import '../widgets/search.dart';
import '../widgets/sort_by.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<StatefulWidget> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> sortBys = [
    {'id': 0, 'name': 'Phổ biến nhất', 'isSelected': true, 'key': 'is_featured'},
    {'id': 0, 'name': 'Flash Sale', 'isSelected': true, 'key': 'flash_sale'},
    // {'id': 1, 'name': 'Mới nhất', 'isSelected': false, 'key': ''},
    // {'id': 2, 'name': 'Đánh giá của khách hàng', 'isSelected': false, 'key': ''},
    // {'id': 3, 'name': 'Giá: Từ thấp đến cao', 'isSelected': false, 'key': ''},
    // {'id': 4, 'name': 'Giá: Từ cao đến thấp', 'isSelected': false, 'key': ''},
  ];

  @override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).add(const GetShopDataDefault());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int current = 0;

    TabController tabController;

    return BlocBuilder<ProductsBloc, ProductsState>(
        builder: (oldState, newState) {
      if (newState is ProductsStateDataLoaded) {
        CategoriesEntity categoriesEntity = newState.categoriesEntity;
        final List<String> categoryNames = categoriesEntity.categories
            .map((categoryEntity) => categoryEntity.name)
            .toList();
        current = BlocProvider.of<ProductsBloc>(context).current;
        tabController = TabController(
            initialIndex: current, length: categoryNames.length, vsync: this);
        tabController.addListener(() {
          BlocProvider.of<ProductsBloc>(context).add(ChangeCategory(
              tabController.index,
              categoriesEntity.categories[tabController.index].id));
        });

        return DefaultTabController(
          length: categoriesEntity.categories.length,
          child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: SafeArea(
                    child: AppBar(
                      title: Text(
                        S.current.shop,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      automaticallyImplyLeading: false,
                    ),
                  )),
              body: newState.listProductAuMall.listProductAuMall.isEmpty
                  ? Column(
                children: [
                  Row(
                    children: [
                      SortProduct(
                        sortBys: sortBys,
                      ),
                      const Expanded(child: SearchWidget()),
                      const FilterProduct(),
                    ],
                  ),
                  const Center(child: Text("Không có sản phầm nào!!!!!!!!!!!!!!!"))
                ],
              )
                  : Column(
                      children: [
                        Row(
                          children: [
                            SortProduct(
                              sortBys: sortBys,
                            ),
                            const Expanded(child: SearchWidget()),
                            const FilterProduct(),
                          ],
                        ),
                        TabBar(
                          indicatorColor: Colors.grey.shade800,
                          indicatorWeight: 3,
                          unselectedLabelColor: Colors.grey,
                          labelColor: Colors.black,
                          // controller: tabController,
                          tabs: categoryNames
                              .map((tabName) => Tab(child: Text(tabName)))
                              .toList(),
                          onTap: (tabIndex) {
                            BlocProvider.of<ProductsBloc>(context).add(ChangeCategory(
                                tabController.index,
                                categoriesEntity.categories[tabIndex].id));
                          },
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: newState
                                .listProductAuMall.listProductAuMall.length,
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
                                            productSimpleEntity: newState
                                                .listProductAuMall
                                                .listProductAuMall[index],
                                            index: index,
                                            isFromAuction: false,
                                          ),
                                        ));
                                  },
                                  child: Hero(
                                      tag: '$index',
                                      child: ProductItemAuMall(
                                        productFavoriteEntity: newState
                                            .listProductAuMall
                                            .listProductAuMall[index],
                                        isAuctionProduct: false,
                                      )
                                  ));
                            },
                          ),
                        ),
                      ],
                    )
          ),
        );
      }
      if (newState is ProductsSearchStateDataLoaded) {
        return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: SafeArea(
                  child: AppBar(
                    title: Text(
                      S.current.shop,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    // elevation: 0,
                    // primary: false,
                    // automaticallyImplyLeading: false,
                    // backgroundColor: Colors.transparent,
                    // titleSpacing: 10,
                    // bottom: TabBar(
                    //   indicatorColor: Colors.grey.shade800,
                    //   indicatorWeight: 3,
                    //   unselectedLabelColor: Colors.grey,
                    //   labelColor: Colors.black,
                    //   controller: tabController,
                    //   tabs: categoryNames
                    //       .map((tabName) => Tab(child: Text(tabName)))
                    //       .toList(),
                    // ),
                  ),
                )),
            body: newState.listProductAuMall.listProductAuMall.isEmpty
                ? Column(
              children: [
                // Text(
                //   S.current.shop,
                //   style: Theme.of(context).textTheme.headline5,
                // ),
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
                const Center(child: Text("Không có sản phầm nào!!!!!!!!!!!!!!!"))
              ],
            )
                : Column(
                    children: [
                      // Text(
                      //   S.current.shop,
                      //   style: Theme.of(context).textTheme.headline5,
                      // ),
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

                      Expanded(
                        child:
                            newState is ProductsLoadingState ? const Center(child: CircularProgressIndicator()) :
                        GridView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: newState
                              .listProductAuMall.listProductAuMall.length,
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
                                          productSimpleEntity: newState
                                              .listProductAuMall
                                              .listProductAuMall[index],
                                          index: index,
                                        ),
                                      ));
                                },
                                child: Hero(
                                    tag: '$index',
                                    child: ProductItemAuMall(
                                      productFavoriteEntity: newState
                                          .listProductAuMall
                                          .listProductAuMall[index],
                                      isAuctionProduct: false,
                                    )));
                          },
                        ),
                      ),
                    ],
                  )
        );
      }
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: kHeight(context) / 3,
            ),
            const CircularProgressIndicator(),
            const Text("Đang tải dữ liệu ...")
          ],
        ),
      );
    });
  }
}
