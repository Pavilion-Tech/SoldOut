import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../../models/buyer_model/get_address_model.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../../../screens/settings/setting_screens/my_account/addresses/add_address.dart';
import '../../../../screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';

class AddressItem extends StatelessWidget {
  AddressItem(this.model);

  GetAddressData model;

  @override
  Widget build(BuildContext context) {
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
        height:size!.height > 670 ? size!.height * .1: size!.height * .13,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    navigateTo(
                        context,AddAddress(isEdit: true, addressId: model.id!,)
                    );
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
                const SizedBox(width: 10,),
                SizedBox(
                    width: size!.height > 670 ?size!.width * .75:size!.width*.65,
                    height: size!.height * .015,
                    child: Text(
                      model.fullAddress!,
                      style: const TextStyle(fontSize: 13, height: 1),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
