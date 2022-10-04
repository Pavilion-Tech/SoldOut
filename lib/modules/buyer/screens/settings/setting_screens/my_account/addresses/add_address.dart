import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/modules/buyer/widgets/settings/settings_screens_widgets/address_widgets/add_address_widget.dart';

import '../../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../../shared/components/components.dart';
import '../../../../../../widgets/my_container.dart';

class AddAddress extends StatelessWidget {
  AddAddress({Key? key,this.isEdit = false,this.addressId}) : super(key: key);
  bool isEdit;
  int? addressId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        myAppBar(
            context: context,
            title: isEdit ? tr('edit_new_address') : tr('add_new_address'),
            isArrowBack: true,
            isLastIcon: true,
            lastIcon: Icons.shopping_cart,
            lastButtonTap: () {
              BuyerCubit.get(context).changeIndex(2);
              navigateAndFinish(context, BuyerLayout());
            }),
        MyContainer(
            BlocConsumer<SettingsCubit, SettingsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return ConditionalBuilder(
                  builder: (context) => AddAddressWidget(isEdit: isEdit,addressId: addressId),
                  fallback: (context) => const CircularProgressIndicator(),
                  condition: SettingsCubit.get(context).settingsModel != null,
                );
              },
            ),
            noSize: true),
      ],
    ));
  }
}
