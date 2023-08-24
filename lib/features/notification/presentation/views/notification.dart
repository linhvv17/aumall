import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../bloc/notification_bloc.dart';
import 'notification_item.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    BlocProvider.of<NotificationBloc>(context).add(GetListNotification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final favouriteList = BlocProvider.of<FavouriteBloc>(context).favouriteList;
    final notificationBloc = BlocProvider.of<NotificationBloc>(context);
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              S.current.notification,
              style: Theme.of(context).textTheme.headline6,
            )),
        body: BlocListener<FavouriteBloc, FavouriteState>(
          listenWhen: (previous, current) {
            return true;
          },
          listener: (context, state) {},
          child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
            if (state is NotificationDataLoading) {
              return const Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Dang tai du lieu .....")
                ],
              ));
            } else if (state is NotificationDataLoaded) {
              final listNotification =
                  state.listNotificationEntity.listNotification;
              return PageStorage(
                bucket: PageStorageBucket(),
                child: Column(
                  children: [
                    Expanded(
                        child: listNotification.isEmpty
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
                                      S.current.noNotification,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  )
                                ],
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  notificationBloc.add(GetListNotification());
                                },
                                child: GridView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics()),
                                  itemCount: listNotification.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                          crossAxisCount: 2, height: 330),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           ProductDetails(
                                          //         productSimpleEntity:
                                          //             listNotification[index],
                                          //         index: index,
                                          //             isFromAuction: false,
                                          //       ),
                                          //     ));
                                        },
                                        child:
                                            // Container()
                                            NotificationItem(
                                          notificationEntity:
                                              listNotification[index],
                                        ));
                                  },
                                ),
                              ))
                  ],
                ),
              );
            } else if (state is NotificationDataErrorState) {
              return Text(state.message);
            } else {
              return Container();
            }
          }),
        ));
  }
}
