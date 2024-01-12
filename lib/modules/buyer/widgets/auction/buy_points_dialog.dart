import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/widgets/auction/points_dialog.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../screens/settings/settings_cubit/settings_cubit.dart';

class BuyPointsDialog extends StatefulWidget {
  BuyPointsDialog({required this.text});

  String text;

  @override
  State<BuyPointsDialog> createState() => _BuyPointsDialogState();
}

class _BuyPointsDialogState extends State<BuyPointsDialog> with SingleTickerProviderStateMixin{


  late Animation<double> animation;
  late AnimationController controller;

  @override
   void initState() {
       super.initState();
       controller =
           AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
       animation = Tween<double>(begin: 0, end: 100).animate(controller)
         ..addListener(() {
           setState(() {
           });
         });
       controller.forward();
     }

  @override
  void dispose() {
      controller.dispose();
      super.dispose();
      }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      content: Container(
        height: size!.height>670? size!.height*.3:size!.height*.4,
        alignment: AlignmentDirectional.center,
        child: Column(
          children:  [
            Container(
              height: 100,
              width: 100,
              alignment: AlignmentDirectional.center,
              child: Icon(
                Icons.dangerous,
                color: Colors.red,
                size: animation.value,
              ),
            ),
            const  Spacer(),
            Text(
              widget.text,
              style:const  TextStyle(fontWeight: FontWeight.bold,)
            ),
            const  Spacer(),
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
                      Navigator.pop(context);
                      SettingsCubit.get(context).linkToAuction = null;
                      SettingsCubit.get(context).getAllPoints(context);
                      showDialog(
                        context: context,
                        builder: (context)=>PointsDialog(),
                      );
                    },
                    text: 'buy_points'.tr())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
