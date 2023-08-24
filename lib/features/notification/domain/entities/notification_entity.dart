import 'package:equatable/equatable.dart';

class NotificationEntity  extends Equatable{
  const NotificationEntity({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
    required this.status,
    required this.publishAt,
    required this.createdAt,
    required this.createdAtFormat,
    required this.isReaded,
  });
   final int id;
   final String title;
   final String thumbnail;
   final String description;
   final int status;
   final String publishAt;
   final String createdAt;
   final String createdAtFormat;
   final bool isReaded;

  @override
  
  List<Object?> get props => [
    
  ];


}
