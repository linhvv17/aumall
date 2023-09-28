import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:aumall/features/shop_profile/domain/entities/shop_profile_entity.dart';
import 'package:aumall/features/shop_profile/presentation/bloc/shop_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../core/colors/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shopping/domain/entities/products_entity.dart';
import 'loading_auction_screen.dart';

class ShopProfileView extends StatefulWidget {
  const ShopProfileView({super.key});

  @override
  State<ShopProfileView> createState() => _ShopProfileViewState();
}

class _ShopProfileViewState extends State<ShopProfileView> {
  int currentTab = 0;

  @override
  void initState() {
    BlocProvider.of<ShopProfileBloc>(context).add(const GetShopProfile(40));
    BlocProvider.of<AuctionBloc>(context).add(const GetListAuctionProduct(2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auctionBloc = BlocProvider.of<AuctionBloc>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: Container(
        decoration: currentTab == 1
            ? const BoxDecoration(color: Colors.deepOrangeAccent)
            : const BoxDecoration(
                color: ColorManager.white,
              ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                currentTab == 1
                    ? Container()
                    : Image.network(
                        "https://timelinecovers.pro/facebook-cover/download/tron_lamborghini_aventador-facebook-cover.jpg",
                        height: 270,
                        fit: BoxFit.fitHeight,
                      )
              ],
            ),
            Column(
              children: [
                _buildAppBar(),
                _buildInfoShopHeaderWidget(),
                const SizedBox(height: 10,),
                _buildTabBar(),
                const Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // ///trang chủ
                      // _buildTabTopContent(auctionBloc),
                      //
                      // ///hot
                      // _buildTabHotContent(auctionBloc),
                      //
                      // ///new
                      // _buildTabNewContent(auctionBloc),

                      Text("HOME", style: TextStyle(color: Colors.black),),
                      Text("HOT", style: TextStyle(color: Colors.black),),
                      Text("NEW", style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }



  Widget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: currentTab == 1
          ? Colors.deepOrangeAccent
          : Colors.transparent,
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
            ShopProfileEntity shopProfileEntity =
                state.shopProfileEntity;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        // border: Border.all(color: Colors.white),
                        color: Colors.grey.shade200.withOpacity(0.5)),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
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
                                        width: 50,
                                        height: 50,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0.50, color: Color(0xFFD9D9D9)),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  color: Colors.deepOrangeAccent),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFD9D9D9)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white.withOpacity(0.9)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                // border: Border.all(color: Colors.white),
                color: Colors.grey.shade200.withOpacity(0.5)),
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                                "https://149369349.v2.pressablecdn.com/wp-content/uploads/2012/10/twitter-cover.jpg",
                                width: 50,
                                height: 50,
                                fit: BoxFit.fill,
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  "LinhVV97 Auto",
                                  style: TextStyle(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.50, color: Color(0xFFD9D9D9)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.deepOrangeAccent),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          width: 0.50, color: Color(0xFFD9D9D9)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white.withOpacity(0.9)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
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
  }

  Widget _buildTabBar() {
    return TabBar(
      labelColor: currentTab == 1 ? Colors.white : Colors.black,
      //<-- selected text color
      unselectedLabelColor:
      currentTab == 1 ? Colors.white : Colors.grey,
      //<-- Unselected text color
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
            width: 2.0,
            color: currentTab == 1 ? Colors.white : Colors.black),
        insets: EdgeInsets.symmetric(
            horizontal: kWidth(context) / 10, vertical: 10),
      ),
      onTap: (tabIndex) {
        switch (tabIndex) {
        // Recent
          case 0:
            setState(() {
              currentTab = 0;
            });
            BlocProvider.of<AuctionBloc>(context)
                .add(const GetListAuctionProduct(2));
            break;

        // Upcoming
          case 1:
            setState(() {
              currentTab = 1;
            });
            BlocProvider.of<AuctionBloc>(context)
                .add(const GetListAuctionProduct(1));
            break;

        // Finished
          case 2:
            setState(() {
              currentTab = 2;
            });
            BlocProvider.of<AuctionBloc>(context)
                .add(const GetListAuctionProduct(3));
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
                padding: EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 2.0),
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

  Widget _buildTabTopContent(AuctionBloc auctionBloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
        builder: (context, state) {
          if (state is AuctionDataLoading) {
            return const LoadingAuctionScreen();
          } else if (state is AuctionDataLoaded) {
            List<ProductAuMallEntity> listAuction =
                state.listAuctionEntity.listAuction;
            return Container(
              decoration:
              BoxDecoration(color: Colors.grey.shade300),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: listAuction.isEmpty
                                ? Center(
                              child: Text(
                                S.current.notauction,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            )
                                : RefreshIndicator(
                              onRefresh: () async {
                                auctionBloc.add(
                                    const GetListAuctionProduct(
                                        2));
                              },
                              child: GridView.builder(
                                physics:
                                const AlwaysScrollableScrollPhysics(
                                    parent:
                                    BouncingScrollPhysics()),
                                itemCount:
                                listAuction.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                    crossAxisCount: 2,
                                    height: 330),
                                itemBuilder:
                                    (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  ProductDetails(
                                                    productEntityId:
                                                    listAuction[index].id!,
                                                    index:
                                                    index,
                                                    isFromAuction:
                                                    true,
                                                    priceStep:
                                                    listAuction[index].priceStep,
                                                  ),
                                            ))
                                            .then(
                                                (value) => {
                                              BlocProvider.of<AuctionBloc>(context)
                                                  .add(const GetListAuctionProduct(2))
                                            });
                                      },
                                      child:
                                      // Container()
                                      ProductItemAuMall(
                                        productFavoriteEntity:
                                        listAuction[
                                        index],
                                        isAuctionProduct:
                                        true,
                                        typeProduct: 1,
                                      ));
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is AuctionDataErrorState) {
            return Text(state.message);
          } else {
            return Container();
          }
        });
  }

  Widget _buildTabHotContent(AuctionBloc auctionBloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
        builder: (context, state) {
          if (state is AuctionDataLoading) {
            return const LoadingAuctionScreen();
          } else if (state is AuctionDataLoaded) {
            List<ProductAuMallEntity> listAuction =
                state.listAuctionEntity.listAuction;
            return Container(
              decoration:
              const BoxDecoration(color: Colors.deepOrange),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: Column(
                    children: [
                      Expanded(
                          child: listAuction.isEmpty
                              ? Center(
                            child: Text(
                              S.current.notauction,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium,
                            ),
                          )
                              : RefreshIndicator(
                            onRefresh: () async {
                              auctionBloc.add(
                                  const GetListAuctionProduct(
                                      2));
                            },
                            child: GridView.builder(
                              physics:
                              const AlwaysScrollableScrollPhysics(
                                  parent:
                                  BouncingScrollPhysics()),
                              itemCount: listAuction.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                  crossAxisCount: 2,
                                  height: 330),
                              itemBuilder:
                                  (context, index) {
                                return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                ProductDetails(
                                                  productEntityId:
                                                  listAuction[index]
                                                      .id!,
                                                  index:
                                                  index,
                                                ),
                                          ))
                                          .then(
                                              (value) => {
                                            BlocProvider.of<AuctionBloc>(context)
                                                .add(const GetListAuctionProduct(2))
                                          });
                                    },
                                    child:
                                    // Container()
                                    ProductItemAuMall(
                                      productFavoriteEntity:
                                      listAuction[
                                      index],
                                      isAuctionProduct:
                                      true,
                                      typeProduct: 2,
                                    ));
                              },
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            );
          } else if (state is AuctionDataErrorState) {
            return Text(state.message);
          } else {
            return Container();
          }
        });
  }

  Widget _buildTabNewContent(AuctionBloc auctionBloc) {
    return BlocBuilder<AuctionBloc, AuctionState>(
        builder: (context, state) {
          if (state is AuctionDataLoading) {
            return const LoadingAuctionScreen();
          } else if (state is AuctionDataLoaded) {
            List<ProductAuMallEntity> listAuction =
                state.listAuctionEntity.listAuction;
            return Container(
              decoration:
              BoxDecoration(color: Colors.grey.shade300),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: PageStorage(
                  bucket: PageStorageBucket(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: listAuction.isEmpty
                                ? Center(
                              child: Text(
                                S.current.notauction,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium,
                              ),
                            )
                                : RefreshIndicator(
                              onRefresh: () async {
                                auctionBloc.add(
                                    const GetListAuctionProduct(
                                        3));
                              },
                              child: GridView.builder(
                                physics:
                                const AlwaysScrollableScrollPhysics(
                                    parent:
                                    BouncingScrollPhysics()),
                                itemCount:
                                listAuction.length,
                                gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                    crossAxisCount: 2,
                                    height: 330),
                                itemBuilder:
                                    (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                  ProductDetails(
                                                    productEntityId:
                                                    listAuction[index].id!,
                                                    index:
                                                    index,
                                                    isFromAuction:
                                                    true,
                                                    priceStep:
                                                    listAuction[index].priceStep,
                                                  ),
                                            ))
                                            .then(
                                                (value) => {
                                              BlocProvider.of<AuctionBloc>(context)
                                                  .add(const GetListAuctionProduct(2))
                                            });
                                      },
                                      child:
                                      // Container()
                                      ProductItemAuMall(
                                        productFavoriteEntity:
                                        listAuction[
                                        index],
                                        isAuctionProduct:
                                        true,
                                        typeProduct: 3,
                                      ));
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is AuctionDataErrorState) {
            return Text(state.message);
          } else {
            return Container();
          }
        });
  }
}
