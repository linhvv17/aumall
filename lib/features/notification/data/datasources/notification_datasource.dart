import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../models/list_notification_model.dart';
import '../models/notification_model.dart';

abstract class NotificationDatasource {
  Future<ListNotificationModel> getListNotification();
  Future<NotificationModel> getDetailNotification(int id);

}

class NotificationDatasourceImpl implements NotificationDatasource {
  final APIProvider apiProvider;
  NotificationDatasourceImpl(this.apiProvider);
  @override
  Future<ListNotificationModel> getListNotification() async {
    final response = await apiProvider.get(
        endPoint: notificationAuMall,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return ListNotificationModel.fromJson(response.data);
  }

  @override
  Future<NotificationModel> getDetailNotification(int id) async {
    final response = await apiProvider.get(
        endPoint: "$notificationAuMall/$id",
        token:
        PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return NotificationModel.fromJson(response.data['data']);
  }


}
