import 'package:aumall/features/notification/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel(
      {required super.id, required super.title, required super.thumbnail, required super.description, required super.status, required super.publishAt, required super.createdAt, required super.createdAtFormat, required super.isReaded});


  factory NotificationModel.fromJson(Map<String, dynamic> json){
    return NotificationModel(
        id : json['id'],
        title : json['title'],
        thumbnail : json['thumbnail'],
    description : json['description'],
    status : json['status'],
    publishAt : json['publish_at'],
    createdAt : json['created_at'],
    createdAtFormat : json['created_at_format'],
    isReaded : json['is_readed'],
    );
  }

}