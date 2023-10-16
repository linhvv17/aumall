import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/features/favorite/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:aumall/features/favorite/presentation/views/item_shop_and_product.dart';
import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../core/colors/colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../home/widgets/product_item.dart';
import '../../../shopping/domain/entities/products_entity.dart';
import 'loading_favorite_screen.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    BlocProvider.of<FavouriteBloc>(context).add(GetListFavoriteProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final favouriteList = BlocProvider.of<FavouriteBloc>(context).favouriteList;
    final favouriteBloc = BlocProvider.of<FavouriteBloc>(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              S.current.favorite,
              style: Theme.of(context).textTheme.headline6,
            )),
        body: BlocListener<FavouriteBloc, FavouriteState>(
          listenWhen: (previous, current) {
            // return true/false to determine whether or not
            // to invoke listener with state
            return current is RemoveFavoriteSuccess;
          },
          listener: (context, state) {
            // do stuff here based on BlocA's state
            if (state is RemoveFavoriteSuccess) {
              if (state.isSuccess) {
                favouriteBloc.add(GetListFavoriteProduct());
              }
            }
          },
          child: BlocBuilder<FavouriteBloc, FavouriteState>(
              builder: (context, state) {
            if (state is FavouriteDataLoading) {
              return const LoadingFavoriteScreen();
            } else if (state is FavouriteDataLoaded) {
              // List<ProductAuMallEntity> listFavorite =
              //     state.listFavoriteEntity.listFavorite;

              List<ProductsOrderByShopEntity> listProductShopEntity =
                  state.listProductShopEntity;
              return PageStorage(
                bucket: PageStorageBucket(),
                child: Column(
                  children: [
                    Expanded(
                        child: listProductShopEntity.isEmpty
                            ? Column(
                                children: [
                                  Expanded(
                                    child: Center(
                                        child: LottieBuilder.asset(
                                            'assets/images/empty.json')),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      S.current.notfavorite,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  )
                                ],
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  favouriteBloc.add(GetListFavoriteProduct());
                                },
                                child: NestedScrollView(
                                  headerSliverBuilder: (BuildContext context,
                                      bool innerBoxIsScrolled) {
                                    return <Widget>[
                                      const SliverAppBar(
                                        pinned: true,
                                        title: Text('Flutter Demo'),
                                      ),
                                    ];
                                  },
                                  body: Column(
                                    children: <Widget>[
                                      const FlutterLogo(
                                        size: 100.0,
                                      ),
                                      SizedBox(
                                        height: 300.0,
                                        child: ListView.builder(
                                          itemCount: 60,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Text('Item $index');
                                          },
                                        ),
                                      ),
                                      const FlutterLogo(
                                        size: 100.0,
                                      ),
                                    ],
                                  ),
                                )

                                // ListView.builder(
                                //     shrinkWrap: true,
                                //     itemCount: listProductShopEntity.length,
                                //     itemBuilder: (BuildContext context, int index) {
                                //       return Column(
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: <Widget>[
                                //           // Text('Parent'),
                                //           ListView.builder(
                                //
                                //               physics: const ClampingScrollPhysics(),
                                //               shrinkWrap: true,
                                //               itemBuilder: (BuildContext context, int index) {
                                //                 return ItemShopAndProduct(
                                //                   shop: listProductShopEntity[index]
                                //                       .shopEntity,
                                //                   productEntities:
                                //                   listProductShopEntity[index]
                                //                       .products,
                                //                 );
                                //               }),
                                //         ],
                                //       );
                                //     }),

                                // ListView.builder(
                                //     itemCount: listProductShopEntity.length,
                                //     itemBuilder: (context, index) {
                                //       return ItemShopAndProduct(
                                //         shop: listProductShopEntity[index]
                                //             .shopEntity,
                                //         productEntities:
                                //             listProductShopEntity[index]
                                //                 .products,
                                //       );
                                //     }),

                                ))
                  ],
                ),
              );
            } else if (state is FavouriteDataErrorState) {
              return Text(state.message);
            } else {
              return Container();
            }
          }),
        ));
  }
}
