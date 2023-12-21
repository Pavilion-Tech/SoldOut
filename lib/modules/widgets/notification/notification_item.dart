import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../models/notification_model.dart';
import '../../../shared/components/constants.dart';

class NotificationItem extends StatelessWidget {

  NotificationItem({required this.notificationModel});

  NotificationData notificationModel;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(
        top: 8,
        start: 8,
        bottom: 8,
        end: 16,
      ),
      decoration: BoxDecoration(
        color: defaultColorTwo,
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notificationModel.title!,
            style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              notificationModel.body!,
              maxLines: 3,
              style:const TextStyle(height: 2),
            ),
          ),
          Text(
            notificationModel.createdAt??'',
            style:const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
