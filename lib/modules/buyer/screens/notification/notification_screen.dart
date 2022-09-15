import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/auth/sign_in/sign_in_screen.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/my_container.dart';
import '../../../widgets/notification/notification_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: token != null,
      fallback: (context)=>SignInScreen(isNoty: true),
      builder: (context)=>SingleChildScrollView(
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
      ),
    );
  }
}
