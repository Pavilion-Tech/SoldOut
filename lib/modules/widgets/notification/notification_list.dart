import 'package:flutter/material.dart';

import 'notification_item.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context,index)=>NotificationItem(),
      separatorBuilder: (context,index)=>SizedBox(height: 20,),
      itemCount: 6,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
