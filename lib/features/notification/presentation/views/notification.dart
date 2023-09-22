import 'package:aumall/features/favorite/presentation/views/product_item_aumall.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import 'package:aumall/features/home/widgets/customGridView.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../../domain/entities/notification_entity.dart';
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
        body: BlocListener<NotificationBloc, NotificationState>(
          listenWhen: (previous, current) {
            return true;
          },
          listener: (context, state) {
            if (state is NotificationDetailDataLoaded) {
              //show dialog detail notification
              _showAlertDialog(state.notificationEntity);
            }
          },
          child: BlocBuilder<NotificationBloc, NotificationState>(
              buildWhen: (previous, current) =>
                  previous != current && current is NotificationDataLoaded,
              builder: (context, state) {
                if (state is NotificationDataLoading) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // The loading indicator
                      const CupertinoActivityIndicator(
                        radius: 20.0,
                        color: CupertinoColors.activeGreen,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(S.current.dataLoading)
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
                                      notificationBloc
                                          .add(GetListNotification());
                                    },
                                    child: ListView.builder(
                                      itemCount: listNotification.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                            onTap: () {
                                              BlocProvider.of<NotificationBloc>(
                                                      context)
                                                  .add(GetDetailNotification(
                                                      id: listNotification[
                                                              index]
                                                          .id));
                                            },
                                            child: NotificationItem(
                                              notificationEntity:
                                                  listNotification[index],
                                            ));
                                      },
                                    )))
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

  Future<void> _showAlertDialog(NotificationEntity notificationEntity) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          title: Text(S.current.notification),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  notificationEntity.title,
                  style: const TextStyle(color: Colors.blue, fontSize: 16),
                ),
                Text(notificationEntity.description),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.current.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
