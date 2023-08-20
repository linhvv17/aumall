import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../home/widgets/product_item.dart';
import '../../../shop/domain/entities/products_entity.dart';

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
              return const Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Dang tai du lieu .....")
                ],
              ));
            } else if (state is FavouriteDataLoaded) {
              List<ProductAuMallEntity> listFavorite =
                  state.listFavoriteEntity.listFavorite;
              return PageStorage(
                bucket: PageStorageBucket(),
                child: Column(
                  children: [
                    Expanded(
                        child: listFavorite.isEmpty
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
                                child: GridView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  itemCount: listFavorite.length,
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
                                                      listFavorite[index],
                                                  index: index,
                                                ),
                                              ));
                                        },
                                        child:
                                            // Container()
                                            ProductItemAuMall(
                                                productFavoriteEntity:
                                                    listFavorite[index],
                                                isAuctionProduct: false));
                                  },
                                ),
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
