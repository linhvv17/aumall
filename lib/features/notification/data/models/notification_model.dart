import 'package:aumall/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {required super.id, required super.title, required super.thumbnail, required super.description, required super.status, required super.publishAt, required super.createdAt, required super.createdAtFormat, required super.isReaded});


  factory NotificationModel.fromJson(Map<String, dynamic> json){
    print("NotificationModel.fromJson $json");
    print("NotificationModel.fromJson ${json['id']}");
    print("NotificationModel.fromJson ${json['title']}");
    print("NotificationModel.fromJson ${json['thumbnail']}");
    print("NotificationModel.fromJson ${json['description']}");
    print("NotificationModel.fromJson ${json['status']}");
    print("NotificationModel.fromJson ${json['publish_at']}");
    print("NotificationModel.fromJson ${json['created_at']}");
    print("NotificationModel.fromJson ${json['created_at_format']}");
    print("NotificationModel.fromJson ${json['is_readed']}");

    return NotificationModel(
        id : json['id'],
        title : json['title'].toString(),
        thumbnail : json['thumbnail'].toString(),
    description : json['description'].toString(),
    status : json['status'],
    publishAt : json['publish_at'].toString(),
    createdAt : json['created_at'].toString(),
    createdAtFormat : json['created_at_format'] ?? "",
    isReaded : json['is_readed'] ?? true,
    );
  }

}