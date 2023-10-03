import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/shop_profile/domain/entities/shop_product_entity.dart';
import 'package:aumall/features/shop_profile/domain/entities/shop_profile_entity.dart';
import 'package:aumall/features/shop_profile/presentation/bloc/profile/shop_profile_bloc.dart';
import 'package:aumall/features/shop_profile/presentation/views/product_in_shop_profile_widget.dart';
import 'package:aumall/features/shop_profile/presentation/widgets/item_product_sale.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../domain/entities/list_shop_product_entity.dart';
import '../bloc/product/shop_product_bloc.dart';
import '../bloc/product/shop_product_event.dart';
import '../bloc/product/shop_product_state.dart';
import 'loading_auction_screen.dart';

class ShopProfileView extends StatefulWidget {
  final int shopId;

  const ShopProfileView({super.key, required this.shopId});

  @override
  State<ShopProfileView> createState() => _ShopProfileViewState();
}

class _ShopProfileViewState extends State<ShopProfileView>
    with TickerProviderStateMixin {
  ///
  late TabController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);

    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.index;
      });
      if (kDebugMode) {
        print("Selected Index: ${_controller.index}");
      }
    });

    BlocProvider.of<ShopProfileBloc>(context)
        .add(GetShopProfile(widget.shopId));
    BlocProvider.of<ShopProductBloc>(context)
        .add(GetShopProduct(widget.shopId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final shopProfileBloc = BlocProvider.of<ShopProfileBloc>(context);
    final shopProductBloc = BlocProvider.of<ShopProductBloc>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Container(
            decoration: selectedIndex == 1
                ? const BoxDecoration(color: Colors.deepOrangeAccent)
                : const BoxDecoration(
              color: ColorManager.white,
            ),
            child: BlocBuilder<ShopProfileBloc, ShopProfileState>(
                builder: (context, state) {
                  if (state is ShopProfileDataErrorState) {
                    return Center(child: Text(state.message));
                  } else {
                    return Stack(
                      children: [
                        ///image cover
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            selectedIndex == 1
                                ? Container()
                                : BlocBuilder<ShopProfileBloc, ShopProfileState>(
                                builder: (context, state) {
                                  if (state is ShopProfileDataLoading) {
                                    return Container(
                                      height: kHeight(context) / 3,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.grey.withOpacity(0.5)),
                                    );
                                  } else if (state is ShopProfileDataLoaded) {
                                    ShopProfileEntity shopProfileEntity =
                                        state.shopProfileEntity;
                                    return Image.network(
                                      shopProfileEntity.bannerUrl!,
                                      height: kHeight(context) * 0.35,
                                      fit: BoxFit.fitHeight,
                                    );
                                  } else if (state is ShopProfileDataErrorState) {
                                    return Text(state.message);
                                  } else {
                                    return Container();
                                  }
                                })
                          ],
                        ),

                        ///header info
                        Column(
                          children: [
                            _buildAppBar(),
                            _buildInfoShopHeaderWidget(),
                          ],
                        ),

                        ///tabview product
                        SizedBox.expand(
                          child: DraggableScrollableSheet(
                            maxChildSize: 0.85,
                            initialChildSize: 0.65,
                            minChildSize: 0.65,
                            builder: (context, scrollController) =>
                                DefaultTabController(
                                  length: 3,
                                  child: _buildProductTabView(
                                      scrollController, shopProductBloc),
                                  // child: _buildFlatCustomScrollView(scrollController),
                                  // child: _buildTabsCustomScrollView(scrollController),
                                ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          )),
    );
  }

  NestedScrollView _buildProductTabView(
      ScrollController scrollController, ShopProductBloc shopProductBloc) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              toolbarHeight: 0.0,
              pinned: true,
              primary: false,
              forceElevated: innerBoxIsScrolled,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(kHeight(context) / 16),
                  child: _buildTabBar()),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: [
          ///top
          _buildTabTopContent(shopProductBloc, scrollController),

          ///sale
          _buildTabHotContent(shopProductBloc, scrollController),

          ///new
          _buildTabNewContent(shopProductBloc, scrollController),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor:
          selectedIndex == 1 ? Colors.deepOrangeAccent : Colors.transparent,
      automaticallyImplyLeading: true,
      centerTitle: true,
      title: Text(
        S.current.shop,
        style: const TextStyle(color: Colors.white),
      ),
      shadowColor: Colors.transparent,
      // bottom:
    );
  }

  Widget _buildInfoShopHeaderWidget() {
    return BlocBuilder<ShopProfileBloc, ShopProfileState>(
        builder: (context, state) {
      if (state is ShopProfileDataLoading) {
        return const CircularProgressIndicator();
      } else if (state is ShopProfileDataLoaded) {
        ShopProfileEntity shopProfileEntity = state.shopProfileEntity;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
          child: Column(
            children: [
              Container(
                height: kHeight(context) / 6.8,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // border: Border.all(color: Colors.white),
                    color: Colors.grey.shade200.withOpacity(0.5)),
                padding: EdgeInsets.all(kHeight(context) / 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    shopProfileEntity.imageUrl!,
                                    width: kWidth(context) / 8,
                                    height: kWidth(context) / 8,
                                    fit: BoxFit.fill,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      shopProfileEntity.name!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: kWidth(context) / 4,
                          height: kWidth(context) / 11,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 6),
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50, color: Color(0xFFD9D9D9)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.deepOrangeAccent),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                S.current.follow,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    ///rating
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "98% Đánh giá tích cực",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text(
                                "941 lượt theo dõi",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: SizedBox(
                  width: kWidth(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kWidth(context) / 40,
                        vertical: kWidth(context) / 50),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0.50, color: Color(0xFFD9D9D9)),
                          borderRadius:
                              BorderRadius.circular(kWidth(context) / 20),
                        ),
                        color: Colors.white.withOpacity(0.9)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          " 🏆 TOP 4 | Gian hàng bán chạy ngành hàng Auto",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (state is ShopProfileDataErrorState) {
        return Text(state.message);
      } else {
        return Container();
      }
    });
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _controller,
      labelColor: selectedIndex == 1 ? Colors.white : Colors.black,
      unselectedLabelColor: selectedIndex == 1 ? Colors.grey : Colors.grey,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
            width: 2.0,
            color: selectedIndex == 1 ? Colors.white : Colors.black),
        insets: EdgeInsets.symmetric(
            horizontal: kWidth(context) / 10, vertical: 10),
      ),
      onTap: (tabIndex) {
        switch (tabIndex) {
          // Recent
          case 0:
            setState(() {
              selectedIndex = 0;
            });
            BlocProvider.of<ShopProductBloc>(context)
                .add(GetShopProduct(widget.shopId));
            break;

          // Upcoming
          case 1:
            setState(() {
              selectedIndex = 1;
            });
            BlocProvider.of<ShopProductBloc>(context)
                .add(GetShopProduct(widget.shopId));
            break;

          // Finished
          case 2:
            setState(() {
              selectedIndex = 2;
            });
            BlocProvider.of<ShopProductBloc>(context)
                .add(GetShopProduct(widget.shopId));
            break;
        }
      },
      tabs: [
        Tab(text: S.current.mainProduct),
        Tab(
            child: Container(
          decoration: const BoxDecoration(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
            child: Text(
              "Sale 10-10",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )),
        Tab(text: S.current.newProduct),
      ],
    );
  }

  Widget _buildTabTopContent(
      ShopProductBloc shopProfileBloc, ScrollController scrollController) {
    return BlocBuilder<ShopProductBloc, ShopProductState>(
        builder: (context, state) {
      if (state is ShopProductDataLoading) {
        return const LoadingAuctionScreen();
      } else if (state is ShopProductDataLoaded) {
        List<ListShopProductsEntity> listShopProductEntities =
            state.shopProductEntities;
        List<ShopProductEntity> list =
            listShopProductEntities[0].shopProductEntities;
        return Container(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: PageStorage(
            bucket: PageStorageBucket(),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: list.isEmpty
                          ? Center(
                              child: Text(
                                S.current.notauction,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                // auctionBloc
                                //     .add(const GetListAuctionProduct(2));
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    8.0, 8.0 + kHeight(context) / 16, 8.0, 8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: GridView.builder(
                                    controller: scrollController,
                                    // physics: scrollController,
                                    itemCount: list.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                      crossAxisCount: 2,
                                      height: kWidth(context) / 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetails(
                                                        productEntityId:
                                                            list[index].id!,
                                                        index: index,
                                                        isFromAuction: true,
                                                      ),
                                                    ))
                                                .then((value) => {
                                                      BlocProvider.of<
                                                                  AuctionBloc>(
                                                              context)
                                                          .add(
                                                              const GetListAuctionProduct(
                                                                  2))
                                                    });
                                          },
                                          child:
                                              // Container()
                                              ProductInShopWidget(
                                            shopProductEntity: list[index],
                                          ));
                                    },
                                  ),
                                ),
                              ),
                            ))
                ],
              ),
            ),
          ),
        );
      } else if (state is ShopProductDataErrorState) {
        return Text(state.message);
      } else {
        return Container();
      }
    });
  }

  Widget _buildTabHotContent(
      ShopProductBloc shopProfileBloc, ScrollController scrollController) {
    return BlocBuilder<ShopProductBloc, ShopProductState>(
        builder: (context, state) {
      if (state is ShopProductDataLoading) {
        return const LoadingAuctionScreen();
      } else if (state is ShopProductDataLoaded) {
        List<ListShopProductsEntity> listShopProductEntities =
            state.shopProductEntities;
        List<ShopProductEntity> list =
            listShopProductEntities[0].shopProductEntities;
        return Container(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PageStorage(
              bucket: PageStorageBucket(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: list.isEmpty
                            ? Center(
                                child: Text(
                                  S.current.notauction,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  // shopProfileBloc.add(
                                  //     const GetListAuctionProduct(
                                  //         3));
                                },
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                    productEntityId:
                                                        list[index].id!,
                                                    index: 1,
                                                    isFromAuction: false,
                                                  ),
                                                ));
                                          },
                                          child: ItemProductSale(
                                              shopProductEntity: list[index])),
                                    );
                                  },
                                )))
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is ShopProductDataErrorState) {
        return Text(state.message);
      } else {
        return Container();
      }
    });
  }

  Widget _buildTabNewContent(
      ShopProductBloc shopProfileBloc, ScrollController scrollController) {
    return BlocBuilder<ShopProductBloc, ShopProductState>(
        builder: (context, state) {
      if (state is ShopProductDataLoading) {
        return const LoadingAuctionScreen();
      } else if (state is ShopProductDataLoaded) {
        List<ListShopProductsEntity> listShopProductEntities =
            state.shopProductEntities;
        List<ShopProductEntity> list =
            listShopProductEntities[0].shopProductEntities;
        return Container(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PageStorage(
              bucket: PageStorageBucket(),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: list.isEmpty
                            ? Center(
                                child: Text(
                                  S.current.notauction,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  // shopProfileBloc.add(
                                  //     const GetListAuctionProduct(
                                  //         3));
                                },
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: list.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetails(
                                                    productEntityId:
                                                        list[index].id!,
                                                    index: 1,
                                                    isFromAuction: false,
                                                  ),
                                                ));
                                          },
                                          child:
                                              // Container()
                                              Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  list[index].thumbnailUrl!,
                                                  width: kWidth(context) / 4,
                                                  height: kWidth(context) / 4,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(list[index].title!),
                                                    Text(list[index]
                                                        .description!),
                                                    Text(
                                                      Utils.convertPrice(
                                                          list[index].price!),
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                    );
                                  },
                                )

                                // GridView.builder(
                                //   physics: const AlwaysScrollableScrollPhysics(
                                //       parent: BouncingScrollPhysics()),
                                //   itemCount: list.length,
                                //   gridDelegate:
                                //       const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                //           crossAxisCount: 2, height: 330),
                                //   itemBuilder: (context, index) {
                                //     return InkWell(
                                //         onTap: () {
                                //           // Navigator.push(
                                //           //         context,
                                //           //         MaterialPageRoute(
                                //           //           builder: (context) =>
                                //           //               ProductDetails(
                                //           //             productEntityId:
                                //           //                 listAuction[index]
                                //           //                     .id!,
                                //           //             index: index,
                                //           //             isFromAuction: true,
                                //           //             priceStep:
                                //           //                 listAuction[index]
                                //           //                     .priceStep,
                                //           //           ),
                                //           //         ))
                                //           //     .then((value) => {
                                //           //           BlocProvider.of<
                                //           //                       AuctionBloc>(
                                //           //                   context)
                                //           //               .add(
                                //           //                   const GetListAuctionProduct(
                                //           //                       2))
                                //           //         });
                                //         },
                                //         child:
                                //             // Container()
                                //             Text(list[index].title!)
                                //     );
                                //   },
                                // ),

                                ))
                  ],
                ),
              ),
            ),
          ),
        );
      } else if (state is ShopProductDataErrorState) {
        return Text(state.message);
      } else {
        return Container();
      }
    });
  }
}
