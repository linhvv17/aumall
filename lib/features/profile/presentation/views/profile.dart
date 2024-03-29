import 'package:aumall/features/cart/data/datasource/local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/payment/presentation/bloc/order_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/theme/bloc/theme_bloc.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/theme/theme_service.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../generated/l10n.dart';
import '../bloc/profile_bloc.dart';
import '../widgets/listtile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              late AppTheme currentTheme;
              return IconButton(
                onPressed: () {
                  if (state.themeData == appThemeData[AppTheme.lightTheme]) {
                    currentTheme = AppTheme.values[1];
                    ThemeDatabaseService.putThemeSettings(1);
                  } else {
                    currentTheme = AppTheme.values[0];
                    ThemeDatabaseService.putThemeSettings(0);
                  }

                  context
                      .read<ThemeBloc>()
                      .add(ThemeChanged(theme: currentTheme));
                },
                icon: state.themeData == appThemeData[AppTheme.lightTheme]
                    ? const Icon(Icons.sunny)
                    : const Icon(Icons.mode_night),
              );
            },
          ),
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
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadedState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      state.data.user!.avatar != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  state.data.user!.avatar.toString()),
                            )
                          : const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  'https://e7.pngegg.com/pngimages/799/987/png-clipart-computer-icons-avatar-icon-design-avatar-heroes-computer-wallpaper-thumbnail.png'),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: Column(
                            children: [
                              Text(
                                state.data.user!.name,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                state.data.user!.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(color: ColorManager.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      MYListTile(
                        title: S.current.editPersonalInfo,
                        subtitle: S.current.edit,
                        ontab: () {
                          Navigator.pushNamed(context, AppRoutes.updateProfile,
                                  arguments: state.data.user)
                              .then((value) => {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(GetProfile())
                                  });
                        },
                      ),
                      MYListTile(
                        title: S.current.myOrders,
                        subtitle: S.current.orders,
                        ontab: () {
                          BlocProvider.of<OrderBloc>(context)
                              .add(GetAllOrders());
                          Navigator.pushNamed(context, AppRoutes.orders);
                        },
                      ),
                      MYListTile(
                        title: S.current.shippingAddresses,
                        subtitle: S.current.shippingAddressesDescription,
                        ontab: () {
                          BlocProvider.of<OrderBloc>(context)
                              .add(GetAllOrders());
                          Navigator.pushNamed(context, AppRoutes.addressList)
                              .then((value) => {
                                    BlocProvider.of<ProfileBloc>(context)
                                        .add(GetProfile())
                                  });
                        },
                      ),
                      MYListTile(
                        title: S.current.changePassword,
                        subtitle: S.current.changePasswordsub,
                        ontab: () {
                          Navigator.pushNamed(
                              context, AppRoutes.updatePassword);
                        },
                      ),
                      BlocListener<ProfileBloc, ProfileState>(
                          listener: (context, state) {
                        if (state is LogOutSuccessState) {
                          print("state is LogOutSuccessState");
                          //delete cache data of current user
                          PreferenceHelper.saveDataInSharedPreference(
                              key: 'IsLoggedIn', value: false);
                          PreferenceHelper.removeData(key: 'token');
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        }
                      }, child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                        return ListTile(
                            onTap: () {
                              //call API logout
                              BlocProvider.of<ProfileBloc>(context).add(LogOut());
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
                              Icons.logout,
                              size: 15,
                              color: Colors.red,
                            ));
                      }))
                    ],
                  ),
                );
              } else if (state is ProfileLoadingState) {
                return const Center(child: CircularProgressIndicator());
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
    );
  }
}
