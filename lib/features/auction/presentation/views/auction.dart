import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shop/domain/entities/products_entity.dart';

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
                    BlocProvider.of<AuctionBloc>(context).add(const GetListAuctionProduct(2));
                    break;

                // Upcoming
                  case 1:
                    BlocProvider.of<AuctionBloc>(context).add(const GetListAuctionProduct(1));
                    break;

                // Finished
                  case 2:
                    BlocProvider.of<AuctionBloc>(context).add(const GetListAuctionProduct(3));
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
            children: [
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return const Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Dang tai du lieu .....")
                    ],
                  ));
                } else if (state is AuctionDataLoaded) {
                  List<ProductAuMallEntity> listAuction =
                      state.listAuctionEntity.listAuction;
                  return PageStorage(
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
                                      auctionBloc.add(const GetListAuctionProduct(2));
                                    },
                                    child: GridView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics()),
                                      itemCount: listAuction.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                              crossAxisCount: 2, height: 330),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetails(
                                                      productSimpleEntity:
                                                          listAuction[index],
                                                      index: index,
                                                    ),
                                                  )).then((value) => {

                                              });
                                            },
                                            child:
                                                // Container()
                                                ProductItemAuMall(
                                                    productFavoriteEntity:
                                                        listAuction[index],
                                                  isAuctionProduct: true,
                                                ));
                                      },
                                    ),
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
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return const Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Dang tai du lieu .....")
                    ],
                  ));
                } else if (state is AuctionDataLoaded) {
                  List<ProductAuMallEntity> listAuction =
                      state.listAuctionEntity.listAuction;
                  return PageStorage(
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
                                      auctionBloc.add(const GetListAuctionProduct(2));
                                    },
                                    child: GridView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics()),
                                      itemCount: listAuction.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                              crossAxisCount: 2, height: 330),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetails(
                                                      productSimpleEntity:
                                                          listAuction[index],
                                                      index: index,
                                                    ),
                                                  ));
                                            },
                                            child:
                                                // Container()
                                                ProductItemAuMall(
                                                    productFavoriteEntity:
                                                        listAuction[index],
                                                    isAuctionProduct: true
                                                ));
                                      },
                                    ),
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
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return const Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Dang tai du lieu .....")
                    ],
                  ));
                } else if (state is AuctionDataLoaded) {
                  List<ProductAuMallEntity> listAuction =
                      state.listAuctionEntity.listAuction;
                  return PageStorage(
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
                                      auctionBloc.add(const GetListAuctionProduct(3));
                                    },
                                    child: GridView.builder(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(
                                              parent: BouncingScrollPhysics()),
                                      itemCount: listAuction.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                              crossAxisCount: 2, height: 330),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetails(
                                                      productSimpleEntity:
                                                          listAuction[index],
                                                      index: index,
                                                    ),
                                                  ));
                                            },
                                            child:
                                                // Container()
                                                ProductItemAuMall(
                                                    productFavoriteEntity:
                                                        listAuction[index],
                                                  isAuctionProduct: true,
                                                ));
                                      },
                                    ),
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
