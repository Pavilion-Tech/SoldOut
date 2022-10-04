import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/auth/sign_in/sign_in_screen.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/loadings/notification_loading/notification_loading.dart';
import '../../../widgets/my_container.dart';
import '../../../widgets/notification/notification_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuyerCubit.get(context).getNotifications();
    return ConditionalBuilder(
      condition: token != null,
      fallback: (context) => SignInScreen(isNoty: true),
      builder: (context) =>
          SingleChildScrollView(
            child: Stack(
              children: [
                myAppBar(
                  context: context,
                  title: tr('notification'),
                ),
                BlocConsumer<BuyerCubit, BuyerStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = BuyerCubit.get(context);
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
          ),
    );
  }
}
