import 'package:aumall/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/payment/presentation/bloc/order_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/listtile.dart';
import '../widgets/loading_profile_screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.notifications);
            },
            icon: const Icon(Icons.notifications_active),
          )
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(S.current.myProfile,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: ColorManager.dark)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is LogOutSuccessState) {
                //delete cache data of current user
                PreferenceHelper.saveDataInSharedPreference(
                    key: 'IsLoggedIn', value: false);
                PreferenceHelper.removeData(key: 'token');
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.login, ModalRoute.withName('/'));
              }
            },
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadedState) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserMainInfo(state.data.user!, context),
                        _buildAuWalletView(context),
                        _buildEKYCView(context),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            MYListTile(
                              title: S.current.editPersonalInfo,
                              subtitle: S.current.edit,
                              ontab: () {
                                Navigator.pushNamed(
                                        context, AppRoutes.updateProfile,
                                        arguments: state.data.user)
                                    .then((value) => {
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(GetProfile())
                                        });
                              },
                              leading: const Icon(
                                Icons.info,
                                color: Colors.red,
                              ),
                            ),
                            MYListTile(
                              title: S.current.myOrders,
                              subtitle: S.current.orders,
                              ontab: () {
                                BlocProvider.of<OrderBloc>(context)
                                    .add(GetAllOrders());
                                Navigator.pushNamed(context, AppRoutes.orders);
                              },
                              leading: const Icon(
                                Icons.local_shipping_rounded,
                                color: Colors.red,
                              ),
                            ),
                            MYListTile(
                              title: S.current.mybag,
                              subtitle: S.current.mybag,
                              ontab: () {
                                BlocProvider.of<CartBloc>(context)
                                    .add(CartStarted());
                                Navigator.pushNamed(context, AppRoutes.cart);
                              },
                              leading: const Icon(
                                Icons.shopping_cart,
                                color: Colors.red,
                              ),
                            ),
                            MYListTile(
                              title: S.current.shippingAddresses,
                              subtitle: S.current.shippingAddressesDescription,
                              ontab: () {
                                BlocProvider.of<OrderBloc>(context)
                                    .add(GetAllOrders());
                                Navigator.pushNamed(
                                        context, AppRoutes.addressList)
                                    .then((value) => {
                                          BlocProvider.of<ProfileBloc>(context)
                                              .add(GetProfile())
                                        });
                              },
                              leading: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                            ),
                            MYListTile(
                              title: S.current.settings,
                              subtitle: S.current.settingsSub,
                              ontab: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.settings);
                              },
                              leading: const Icon(
                                Icons.settings,
                                color: Colors.red,
                              ),
                            ),
                            MYListTile(
                              title: S.current.changePassword,
                              subtitle: S.current.changePasswordsub,
                              ontab: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.updatePassword);
                              },
                              leading: const Icon(
                                Icons.lock,
                                color: Colors.red,
                              ),
                            ),
                            BlocBuilder<ProfileBloc, ProfileState>(
                                builder: (context, state) {
                              return ListTile(
                                  leading: const Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                  onTap: () {
                                    //call API logout
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(LogOut());
                                  },
                                  title: Text(
                                    S.current.logout,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color: Colors.red),
                                  ),
                                  dense: true,
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: Colors.red,
                                  ));
                            })
                          ],
                        ),
                      ],
                    ),
                  );
                } else if (state is ProfileLoadingState) {
                  return const LoadingProfileScreen();
                } else if (state is ProfileErrorState) {
                  return state.message == S.current.noInternetError
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  child: LottieBuilder.asset(
                                      'assets/images/nointernet.json')),
                            ),
                            Card(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(state.message),
                            ))
                          ],
                        )
                      : Center(child: Text(state.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildUserMainInfo(UserEntity userEntity, BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userEntity.avatar != null
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(userEntity.avatar.toString()),
                    )
                  : const CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                userEntity.name,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "0 Đã thích",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorManager.grey, fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      "0 Đang theo dõi",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorManager.grey, fontSize: 12),
                    ),
                  ),
                  Text(
                    "0 Mã giảm giá",
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: ColorManager.grey, fontSize: 12),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Icon(Icons.error),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Text(
                      "Chưa xác thực",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ColorManager.orangeLight),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildAuWalletView(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                Icons.wallet,
                color: Colors.deepOrange,
              ),
              Text("Ví Au")
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.wallet,
                    color: Colors.deepOrange,
                    size: 60,
                  ),
                  Text("Ví Au"),
                  Text(
                    "Sử dụng ngay",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.currency_bitcoin,
                    color: Colors.deepOrange,
                    size: 60,
                  ),
                  Text("Au Xu"),
                  Text(
                    "AuXu hiện tại",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.monetization_on,
                    color: Colors.deepOrange,
                    size: 60,
                  ),
                  Text("Xu Au"),
                  Text(
                    "Nhận xu ngay",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildEKYCView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/ekyc_icon.png',
                  width: 60,
                  height: 60,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Vui lòng xác thực tài khoản để \nsử dụng dịch vụ tin cậy hơn",
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Text("Xác thực ngay",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
