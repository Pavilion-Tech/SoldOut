import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/modules/widgets/loadings/address&order_loading/address&order_loading.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../widgets/my_container.dart';
import '../../../../../widgets/settings/settings_screens_widgets/order_widgets/order_history_widget.dart';


class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('my_order_history'),
                isArrowBack: true,
                isLastIcon: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: () {
                  BuyerCubit.get(context).changeIndex(2);
                  navigateAndFinish(context, BuyerLayout());
                }
            ),
            BlocConsumer<SettingsCubit, SettingsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = SettingsCubit.get(context);
                return MyContainer(
                  noSize: cubit.orderModel!= null,
                  ConditionalBuilder(
                    condition:cubit.orderModel!= null,
                    fallback: (context) => const AddressAndOrderLoading(),
                    builder: (context) => OrderHistoryWidget(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
