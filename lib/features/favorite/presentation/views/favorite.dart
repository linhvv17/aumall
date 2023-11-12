import 'package:aumall/features/favorite/domain/entities/product/products_order_by_shop_entity.dart';
import 'package:aumall/features/favorite/presentation/views/item_shop_and_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import '../../../../generated/l10n.dart';
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
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: listProductShopEntity.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ItemShopAndProduct(
                                        shop: listProductShopEntity[index]
                                            .shopEntity,
                                        productEntities:
                                            listProductShopEntity[index]
                                                .products,
                                      );
                                    }),
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
