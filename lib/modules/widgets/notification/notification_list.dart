import 'package:flutter/material.dart';

import '../../../models/notification_model.dart';
import 'notification_item.dart';

class NotificationList extends StatelessWidget {

  NotificationList({required this.notificationModel});

  NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index)=>NotificationItem(
          notificationModel:notificationModel.data![index]
      ),
      separatorBuilder: (context,index)=>const SizedBox(height: 20,),
      itemCount: notificationModel.data!.length,
      shrinkWrap: true,
    );
  }
}
