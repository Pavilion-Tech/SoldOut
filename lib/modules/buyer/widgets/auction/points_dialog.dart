import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/styles/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../screens/settings/settings_cubit/settings_states.dart';
import '../paymen/payment_dialog.dart';
import '../settings/settings_screens_widgets/points_tap_bar/first_tap.dart';
import '../shimmers/points_loading/first_points_loading.dart';

class PointsDialog extends StatefulWidget {


  @override
  State<PointsDialog> createState() => _PointsDialogState();
}

class _PointsDialogState extends State<PointsDialog> {




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            height: size!.height*.7,
            width: size!.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(20),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (){
                      if(cubit.linkToAuction!=null){
                        cubit.linkToAuction = null;
                        cubit.emitState();
                      }else{
                        cubit.linkToAuction = null;
                        cubit.emitState();
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.linkToAuction==null,
                    fallback: (context)=>ConditionalBuilder(
                      condition: state is! GetPointsLoadingState,
                      fallback: (context)=>Center(child: const CircularProgressIndicator(),),
                      builder: (context)=> Builder(
                          builder: (context){
                        return Stack(
                          children: [
                            WebViewWidget(controller: cubit.webViewController),
                            if(cubit.webLoading)
                              Center(child: const CircularProgressIndicator(),),
                          ],
                        );
                      }),
                    ),
                    builder: (context)=> ConditionalBuilder(
                        condition: cubit.getPointsModel != null,
                        fallback: (context) =>
                            ListView.separated(
                              itemBuilder: (context, index) => PointsLoading(fromAuction: true),
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 15,),
                              itemCount: 5,
                            ),
                        builder: (context) {
                          if (cubit.getPointsModel!.data!.packages!.isNotEmpty) {
                            return ListView.separated(
                              itemBuilder: (context, index) =>
                                  FirstTap(model: cubit.getPointsModel!.data!
                                      .packages![index],
                                    fromAuction: true,
                                  ),
                              separatorBuilder: (context, index) =>
                              const SizedBox(height: 15,),
                              itemCount: cubit.getPointsModel!.data!.packages!.length,
                            );
                          } else {
                            return Center(child: Text(tr('no_points')),);
                          }
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
