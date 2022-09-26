import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/models/buyer_model/get_address_model.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/state.dart';
import 'package:soldout/modules/widgets/loadings/address&order_loading/address&order_loading.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../../../screens/settings/setting_screens/my_account/addresses/add_address.dart';

class ManageAddressWidget extends StatelessWidget {
  const  ManageAddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressCubit, AddressStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        var cubit = AddressCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.getAddressModel != null,
          fallback: (context) =>const AddressAndOrderLoading(),
          builder: (context) {
            if (cubit.getAddressModel!.data!.isEmpty) {
              return Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    tr('dont_have_address'),
                    textAlign: TextAlign.center,
                    style:const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  defaultButton(
                      onTap: () {
                        navigateTo(context, AddAddress());
                      },
                      text: tr('add_new_address'))
                ],
              );
            } else {
              return Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.swipe_left_outlined,
                        color: HexColor('#A0AEC0'),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        tr('swipe_to_remove'),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                  ),
                  ListView.separated(
                    itemBuilder: (context, index) =>
                        address(cubit.getAddressModel!.data![index], context),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 20,
                    ),
                    itemCount: cubit.getAddressModel!.data!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultButton(
                      onTap: () {
                        navigateTo(context, AddAddress());
                      },
                      text: tr('add_new_address'),
                      buttonColor: HexColor('#A0AEC0'),
                      radiusColor: HexColor('#A0AEC0'))
                ],
              );
            }
          },
        );
      },
    );
  }

  Widget address(GetAddressData model, context) {
    return Slidable(
      direction: Axis.horizontal,
      endActionPane: ActionPane(
        extentRatio: 0.35,
        motion: InkWell(
          onTap: () {
            AddressCubit.get(context).removeAddress(model.id!);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10), bottomEnd: Radius.circular(10)),
              color: HexColor('#FF0000'),
            ),
            child: const Icon(
              Icons.delete_forever,
              color: defaultColorTwo,
              size: 50,
            ),
          ),
        ),
        children: [],
      ),
      child: Container(
        height: size!.height * .1,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            color: Colors.grey.shade300.withOpacity(.5),
          ),
        ),
        padding: const EdgeInsetsDirectional.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  model.title!,
                  style: const TextStyle(
                      color: defaultColor, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,
                        AddAddress(
                          isEdit: true,
                          addressId: model.id!,
                        ));
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.blue),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: size!.width * .75,
                    height: size!.height * .015,
                    child: Text(
                      model.fullAddress!,
                      style: const TextStyle(fontSize: 13, height: 1),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget fallBack() {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [CircularProgressIndicator()],
      ),
    );
  }
}
