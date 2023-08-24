import 'package:aumall/features/notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import '../../../../core/colors/colors.dart';
import '../../../../core/theme/theme_data.dart';
import '../../../../core/utilities/enums.dart';
import '../../../../core/utilities/mediaquery.dart';
import '../../../../core/utilities/routes.dart';
import '../../../../core/utilities/utils.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/view/product_details.dart';
import '../../../login/presentation/widgets/alert_snackbar.dart';
import '../../../shop/domain/entities/products_entity.dart';
import '../bloc/notification_bloc.dart';

class NotificationItem extends StatefulWidget {
  final NotificationEntity notificationEntity;
  const NotificationItem(
      {super.key, required this.notificationEntity});

  @override
  State<StatefulWidget> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        child: Row(
          children: [
            Image.network(
              widget.notificationEntity.thumbnail,
              width: 30,
              height: 30,
            ),
            Column(
              children: [
                Text(widget.notificationEntity.title),
                Text(widget.notificationEntity.description),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
