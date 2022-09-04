import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/my_container.dart';
import '../../../widgets/notification/notification_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(
            context: context,
            title: tr('notification'),
          ),
          MyContainer(
            //NotificationListLoading()
              NotificationList(),
              noSize: true
          ),
        ],
      ),
    );
  }
}
