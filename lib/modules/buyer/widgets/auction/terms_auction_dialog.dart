import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/network/local/cache_helper.dart';
import 'package:soldout/shared/styles/colors.dart';

class TermsAuctionDialog extends StatefulWidget {
  TermsAuctionDialog({this.id});

  int? id;

  @override
  State<TermsAuctionDialog> createState() => _TermsAuctionDialogState();
}

class _TermsAuctionDialogState extends State<TermsAuctionDialog> {

  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: size!.height*.9,
        width: size!.width*.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  SettingsCubit.get(context).settingsModel?.data?.auctionTerms??''
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Checkbox(
                    value: value,
                    activeColor: defaultColor,
                    onChanged: (val){
                      setState(() {
                        value = !value;
                      });
                    }
                ),
                Expanded(
                  child: Text(
                    'accept_auction_terms'.tr()
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: defaultButton(
                    onTap: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    buttonColor: Colors.white,
                    textColor: defaultColor,
                    text: 'cancel'.tr(),
                )),
                const SizedBox(width:20),
                Expanded(child: defaultButton(
                    onTap: (){
                      if(!value){
                        showToast(msg: 'confirm_auction_terms'.tr());
                      }else{
                        CacheHelper.saveData(key: widget.id.toString(), value: true);
                        Navigator.pop(context);
                      }
                    },
                    text: 'accept'.tr())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
