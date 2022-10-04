import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../layout/buyer_layout/cubit/buyer_states.dart';
import '../../../../shared/components/components.dart';
import '../../../widgets/my_container.dart';

class Payment extends StatefulWidget {
  Payment({required this.url,this.isPoints = false});
  String url;
  bool isPoints;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            myAppBar(
              context: context,
              isArrowBack: true,
              title: tr('payment'),
              arrowTap: () {
                if(widget.isPoints)SettingsCubit.get(context).getAllPoints();
                Navigator.pop(context);
              },
            ),
            Stack(
              children: [
                MyContainer(
                  WebView(
                    onPageFinished: (String? val)
                    {
                      setState(()=>isLoading = false);
                    },
                    initialUrl: widget.url,
                    onWebResourceError: (error) {
                      Navigator.pop(context);
                      error.toString();
                    },
                  ),
                ),
                if(isLoading)
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: size!.height*.4,),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
