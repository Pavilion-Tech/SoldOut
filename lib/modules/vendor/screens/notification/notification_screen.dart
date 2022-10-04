import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../layout/vendor_layout/cubit/vendor_cubit.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/loadings/notification_loading/notification_loading.dart';
import '../../../widgets/notification/notification_list.dart';

class VendorNotificationHomeScreen extends StatelessWidget {
  const VendorNotificationHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VendorCubit.get(context).getNotifications();
    return SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(context: context, title: tr('notification')),
          BlocConsumer<VendorCubit, VendorStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = VendorCubit.get(context);
              return MyContainer(
                  ConditionalBuilder(
                      condition:cubit.notificationModel!=null,
                      fallback:(context)=>NotificationListLoading(),
                      builder:(context) {
                        if(cubit.notificationModel!.data!.isNotEmpty)
                        {
                          return NotificationList(
                              notificationModel:cubit.notificationModel!
                          );
                        }else
                        {
                          return Column(
                            children: [
                              SizedBox(height: size!.height*.4,),
                              Text(tr('no_notification'))
                            ],
                          );
                        }
                      }
                  ),
                  noSize: true
              );
            },
          ),
        ],
      ),
    );
  }
}
