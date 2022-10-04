import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../screens/manage_product/manage_product.dart';
import '../../screens/settings/vendor_change_password.dart';
import '../../screens/settings/vendor_edit_profile.dart';
import 'vendor_change_lang_sheet.dart';

class VMyAccountWidget extends StatelessWidget {
  const VMyAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: size!.height*.27,
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
              navigateTo(context, VEditProfile());
            }),
            accountItem(tr('change_password'),(){
              navigateTo(context, VChangePassword());
            }),
            accountItem(tr('manage_products'),(){
              VendorCubit.get(context).pageProduct = 1;
              VendorCubit.get(context).getProducts();
              navigateTo(context, VendorManageProductList());
            }),
            InkWell(
              onTap: (){
                bottomSheet(context);
              },
              child:  Text(
                  tr('change_lang'),
                  style:const TextStyle(fontWeight: FontWeight.bold)
              ),
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
          Text(title,style:const TextStyle(fontWeight: FontWeight.bold),),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,size: 14,),
        ],
      ),
    );
  }

  Future bottomSheet(context){
    return showModalBottomSheet(
      context: context,
      backgroundColor: defaultColorTwo,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(15),
            topEnd: Radius.circular(15),
          )),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => const VChangeLangBottomSheet(),
    );
  }
}
