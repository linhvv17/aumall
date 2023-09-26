import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../core/colors/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shopping/domain/entities/products_entity.dart';

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
              BlocBuilder<AuctionBloc, AuctionState>(builder: (context, state) {
                if (state is AuctionDataLoading) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // The loading indicator
                      const CupertinoActivityIndicator(
                        radius: 20.0,
                        color: ColorManager.colorApp,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(S.current.dataLoading)
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
                                      auctionBloc
                                          .add(const GetListAuctionProduct(2));
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
                                                              productEntityId:
                                                              listAuction[
                                                                  index].id!,
                                                          index: index,
                                                          isFromAuction: true,
                                                              priceStep:  listAuction[
                                                              index].priceStep,
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
                                                ProductItemAuMall(
                                              productFavoriteEntity:
                                                  listAuction[index],
                                              isAuctionProduct: true,
                                              typeProduct: 1,
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
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // The loading indicator
                      const CupertinoActivityIndicator(
                        radius: 20.0,
                        color: ColorManager.colorApp,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(S.current.dataLoading)
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
                                      auctionBloc
                                          .add(const GetListAuctionProduct(2));
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
                                                              productEntityId:
                                                              listAuction[
                                                                  index].id!,
                                                          index: index,
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
                                                ProductItemAuMall(
                                              productFavoriteEntity:
                                                  listAuction[index],
                                              isAuctionProduct: true,
                                              typeProduct: 2,
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
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // The loading indicator
                      const CupertinoActivityIndicator(
                        radius: 20.0,
                        color: ColorManager.colorApp,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(S.current.dataLoading)
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
                                      auctionBloc
                                          .add(const GetListAuctionProduct(3));
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
                                                              productEntityId:
                                                              listAuction[
                                                                  index].id!,
                                                          index: index,
                                                          isFromAuction: true,
                                                              priceStep:  listAuction[
                                                              index].priceStep,
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
                                                ProductItemAuMall(
                                              productFavoriteEntity:
                                                  listAuction[index],
                                              isAuctionProduct: true,
                                              typeProduct: 3,
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
