import 'package:aumall/features/notification/domain/entities/notification_entity.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        color: widget.notificationEntity.isReaded ? Colors.white : Colors.grey.shade400,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                widget.notificationEntity.thumbnail,
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.notificationEntity.title,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16
                    ),
                  ),
                  Text(
                      widget.notificationEntity.description,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
