import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../layout/buyer_layout/cubit/buyer_states.dart';
import '../../../../shared/components/components.dart';
import '../../../widgets/my_container.dart';

class Payment extends StatelessWidget {
  Payment({required this.url});
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.get(context);
          return SingleChildScrollView(
            controller: BuyerCubit.get(context).scrollControllerForSearch,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                myAppBar(
                  context: context,
                  isArrowBack: true,
                  title: tr('payment'),
                  arrowTap: () {
                    Navigator.pop(context);
                  },
                ),
                MyContainer(
                  WebView(
                    initialUrl: url,
                    onWebResourceError: (error) {
                      Navigator.pop(context);
                      error.toString();
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
