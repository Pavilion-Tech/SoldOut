import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../widgets/notification/notification_list.dart';

class VendorNotificationHomeScreen extends StatelessWidget {
  const VendorNotificationHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(context: context, title: tr('notification')),
          MyContainer(NotificationList(),noSize: true),
        ],
      ),
    );
  }
}
