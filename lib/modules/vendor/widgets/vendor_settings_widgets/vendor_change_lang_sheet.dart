import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';

import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../../../layout/vendor_layout/cubit/vendor_cubit.dart';
import '../../../../layout/vendor_layout/vendor_layout_screen.dart';
import '../../../../shared/network/local/cache_helper.dart';

class VChangeLangBottomSheet extends StatelessWidget {
  const VChangeLangBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size!.height > 600 ? size!.height * .24:size!.height * .4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding:  EdgeInsetsDirectional.all(size!.height > 600 ?20:15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tr('change_lang'),
            style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          Text(
            tr('change_lang_sure'),
            style:const TextStyle(
              height: 2,
              fontWeight: FontWeight.bold,fontSize: 16
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              defaultButton(
                onTap: () {
                  Navigator.pop(context);
                },
                text:tr('discard'),
                textColor: defaultColor,
                buttonColor: defaultColorTwo,
              ),
              SizedBox(
                width: size!.height * .008,
              ),
              defaultButton(
                  onTap: () {
                    navigateAndFinish(context, VendorLayout());
                    if(context.locale.languageCode == 'ar')
                    {
                      context.setLocale(const Locale('en'));
                      VendorCubit.get(context).changeIndex(4);
                      CacheHelper.saveData(key: 'locale', value: context.locale.languageCode);
                      myLocale = context.locale.languageCode;
                      VSettingCubit.get(context).changeLang(myLocale!);
                    }
                    else
                    {
                      context.setLocale(const Locale('ar'));
                      VendorCubit.get(context).changeIndex(4);
                      CacheHelper.saveData(key: 'locale', value: context.locale.languageCode);
                      myLocale = context.locale.languageCode;
                      VSettingCubit.get(context).changeLang(myLocale!);
                    }
                  },
                  text:tr('apply') ),
            ],
          )
        ],
      ),
    );
  }
}
