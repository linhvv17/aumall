import 'package:aumall/features/auction/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/auction/presentation/views/widgets/item_shop_and_product.dart';
import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shopping/domain/entities/products_entity.dart';
import 'loading_auction_screen.dart';

class AuctionView extends StatefulWidget {
  const AuctionView({super.key});

  @override
  State<AuctionView> createState() => _AuctionViewState();
}

class _AuctionViewState extends State<AuctionView> {
  @override
  void initState() {
    BlocProvider.of<AuctionBloc>(context).add(const GetListAuctionProduct(2));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auctionBloc = BlocProvider.of<AuctionBloc>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              S.current.auction,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            bottom: TabBar(
              onTap: (tabIndex) {
                switch (tabIndex) {
                  // Recent
                  case 0:
                    BlocProvider.of<AuctionBloc>(context)
                        .add(const GetListAuctionProduct(2));
                    break;

                  // Upcoming
                  case 1:
                    BlocProvider.of<AuctionBloc>(context)
                        .add(const GetListAuctionProduct(1));
                    break;

                  // Finished
                  case 2:
                    BlocProvider.of<AuctionBloc>(context)
                        .add(const GetListAuctionProduct(3));
                    break;
                }
              },
              tabs: [
                Tab(text: S.current.now),
                Tab(text: S.current.upcoming),
                Tab(text: S.current.end),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ///now
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return const LoadingAuctionScreen();
                } else if (state is AuctionDataLoaded) {
                  List<ProductsOrderByShopEntity> listProductShopEntity =
                      state.listProductShopEntity;
                  // List<ProductAuMallEntity> listAuction =
                  //     state.listAuctionEntity.listAuction;
                  return PageStorage(
                    bucket: PageStorageBucket(),
                    child: Column(
                      children: [
                        Expanded(
                            child: listProductShopEntity.isEmpty
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
                                      auctionBloc
                                          .add(const GetListAuctionProduct(2));
                                    },
                                    child: ListView.builder(
                                        itemCount: listProductShopEntity.length,
                                        itemBuilder: (context, index) {
                                          return ItemShopAndProduct(
                                            shop: listProductShopEntity[index]
                                                .shopEntity,
                                            productEntities:
                                                listProductShopEntity[index]
                                                    .products,
                                            typeProduct: 2,
                                          );
                                        })
                                    ))
                      ],
                    ),
                  );
                } else if (state is AuctionDataErrorState) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),

              ///upcoming
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return const LoadingAuctionScreen();
                } else if (state is AuctionDataLoaded) {
                  List<ProductsOrderByShopEntity> listProductShopEntity =
                      state.listProductShopEntity;
                  return PageStorage(
                    bucket: PageStorageBucket(),
                    child: Column(
                      children: [
                        Expanded(
                            child: listProductShopEntity.isEmpty
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
                                      auctionBloc
                                          .add(const GetListAuctionProduct(1));
                                    },
                                    child: ListView.builder(
                                        itemCount: listProductShopEntity.length,
                                        itemBuilder: (context, index) {
                                          return ItemShopAndProduct(
                                            shop: listProductShopEntity[index]
                                                .shopEntity,
                                            productEntities:
                                                listProductShopEntity[index]
                                                    .products,
                                            typeProduct: 1,
                                          );
                                        })
                                    ))
                      ],
                    ),
                  );
                } else if (state is AuctionDataErrorState) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),

              ///end
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return const LoadingAuctionScreen();
                } else if (state is AuctionDataLoaded) {
                  List<ProductsOrderByShopEntity> listProductShopEntity =
                      state.listProductShopEntity;
                  return PageStorage(
                    bucket: PageStorageBucket(),
                    child: Column(
                      children: [
                        Expanded(
                            child: listProductShopEntity.isEmpty
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
                                      auctionBloc
                                          .add(const GetListAuctionProduct(3));
                                    },
                                    child:
                                    ListView.builder(
                                        itemCount: listProductShopEntity.length,
                                        itemBuilder: (context, index) {
                                          return ItemShopAndProduct(
                                            shop: listProductShopEntity[index]
                                                .shopEntity,
                                            productEntities:
                                            listProductShopEntity[index]
                                                .products,
                                            typeProduct: 3,
                                          );
                                        })
                                  ))
                      ],
                    ),
                  );
                } else if (state is AuctionDataErrorState) {
                  return Text(state.message);
                } else {
                  return Container();
                }
              }),
            ],
          )),
    );
  }
}
