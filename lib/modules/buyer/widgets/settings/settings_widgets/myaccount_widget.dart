import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../../screens/settings/setting_screens/my_account/addresses/manage_address.dart';
import '../../../screens/settings/setting_screens/my_account/edit_profile.dart';
import '../../../screens/settings/setting_screens/my_account/favorites.dart';
import '../../../screens/settings/setting_screens/my_account/my_auctions.dart';
import '../../../screens/settings/setting_screens/my_account/order/order_history.dart';
import '../../../screens/settings/setting_screens/my_account/points.dart';
import 'change_lang_sheet.dart';

class MyAccountWidget extends StatelessWidget {
  const MyAccountWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: size!.height*.4,
        padding: const EdgeInsetsDirectional.all(5),
        decoration: BoxDecoration(
          color: Colors.blue.shade100.withOpacity(.1),
          borderRadius: BorderRadiusDirectional.circular(10)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            accountItem(tr('edit_profile'),(){
              AuthCubit.get(context).getProfile();
              navigateTo(context, EditProfile());
            }),
            accountItem(tr('manage_address'),(){
              AddressCubit.get(context).getAddress();
              navigateTo(context, ManageAddress());
            }),
            accountItem(tr('my_fav'),(){
              BuyerCubit.get(context).getFav();
              navigateTo(context, Favorites());
            }),
            accountItem(tr('my_order_history'),(){
              navigateTo(context, OrderHistory());
            }),
            accountItem(tr('my_auctions'),(){
              navigateTo(context, MyAuctions());
            }),
            accountItem(tr('points'),(){
              navigateTo(context, PointsScreen());
            }),
            InkWell(
              onTap: (){
                showModalBottomSheet(
                  context: context,
                  backgroundColor: defaultColorTwo,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(15),
                        topEnd: Radius.circular(15),
                      )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  builder: (context) => const ChangeLangBottomSheet(),
                );
              },
              child:Text(tr('change_lang')),
            ),
            InkWell(
              onTap: (){},
              child:Text(tr('share_app')),
            ),

          ],
        ),
      ),
    );
  }

  Widget accountItem(String title, VoidCallback callback){
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Text(title),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,size: 14,),
        ],
      ),
    );
  }
}
