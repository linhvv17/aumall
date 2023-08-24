import 'package:aumall/features/favorite/domain/entities/list_favorite_entity.dart';

import '../../../shop/data/models/products_model.dart';
import '../../domain/entities/list_notification_entity.dart';
import 'notification_model.dart';

class ListNotificationModel extends ListNotificationEntity {
  const ListNotificationModel(super.listNotification);

  factory ListNotificationModel.fromJson(Map<String, dynamic> json) {
    print("ListNotificationModel.fromJson json${json}");
    print("ListNotificationModel.fromJson json data ${json['data']}");

    List<NotificationModel> list = List<NotificationModel>.from(
        json['data']['data'].map((x) => NotificationModel.fromJson(x)));

    print(
        "ListNotificationModel.fromJson json data List<ProductNotificationModel> ${list}");
    print(
        "ListNotificationModel.fromJson json data List<ProductNotificationModel> ${list.length}");
    return ListNotificationModel(list);
  }
}
