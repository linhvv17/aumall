import 'package:aumall/features/auction/presentation/views/auction.dart';
import 'package:aumall/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/features/cart/presentation/bloc/cart_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../auction/presentation/bloc/auction_bloc.dart';
import '../../../cart/presentation/bloc/location_bloc.dart';
import '../../../cart/presentation/views/cart.dart';
import '../../../favorite/presentation/views/favorite.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../../profile/presentation/views/profile.dart';
import '../../../shop/presentation/bloc/products_bloc.dart';
import '../../../shop/presentation/views/shop.dart';
import '../bloc/bottom_nav/bottomNavigationBar_bloc.dart';
import '../bloc/home_bloc/home_bloc.dart';
import '../bloc/home_bloc/home_event.dart';
import 'home.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  void initState() {
    // BlocProvider.of<ProductsBloc>(context).add(GetAllProducts());
    BlocProvider.of<LocationBloc>(context).add(CheckPermission(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            // type: BottomNavigationBarType.fixed,
            backgroundColor: ColorManager.white,
            selectedItemColor: ColorManager.orangeLight,
            unselectedItemColor: ColorManager.grey,
            currentIndex: state.index,
            onTap: (index) {
              switch (index) {
                case 0:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadHome());
                  // BlocProvider.of<ProductsBloc>(context).add(GetAllProducts());
                  BlocProvider.of<HomeBloc>(context).add(GetDataHome());
                  // BlocProvider.of<ProfileBloc>(context).add(GetProfile());
                  break;
                case 1:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadShop());
                  BlocProvider.of<ProductsBloc>(context).add(
                      GetSpecificProduct(
                          BlocProvider.of<ProductsBloc>(context).categoriesEntity[0].name,
                          '0',
                          '100000',
                          '-1',
                          ''
                      )
                  );
                  break;
                case 2:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadAuction());
                  BlocProvider.of<AuctionBloc>(context).add(const GetListAuctionProduct(2));
                  break;
                case 3:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadBag());
                  BlocProvider.of<CartBloc>(context).add(CartStarted());
                  break;
                case 4:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadFavorite());
                  break;
                case 5:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadProfile());
                  BlocProvider.of<ProfileBloc>(context).add(GetProfile());
                  break;
                default:
                  BlocProvider.of<BottomNavigationBarBloc>(context)
                      .add(LoadHome());
              }
            },
            items:  [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: S.current.home,
                  activeIcon: const Icon(Icons.home)),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: S.current.shop,
                  activeIcon: const Icon(Icons.shopping_cart)),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.price_change_outlined),
                  label: S.current.auction,
                  activeIcon: const Icon(Icons.price_change)),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: S.current.mybag,
                  activeIcon: const Icon(Icons.shopping_bag)),
              BottomNavigationBarItem(
                icon: const Icon(Icons.favorite_border_outlined),
                label: S.current.favorite,
                activeIcon: const Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  label: S.current.myProfile,
                  activeIcon: const Icon(Icons.person)),
            ],
          ),
          body: BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
            builder: (context, state) {
              if (state is HomeState) {
                return const HomeView();
              } else if (state is ShopState) {
                return const ShopView();
              } else if (state is AuctionSelectState) {
                return const AuctionView();
              }else if (state is BagState) {
                return const CartView(isFromBottomBar: true,);
              } else if (state is FavoriteState) {
                return const FavoriteView();
              } else if (state is ProfilePageState) {
                return const ProfileView();
              } else {
                return const SizedBox();
              }
            },
          ),
        );
      },
    );
  }
}
