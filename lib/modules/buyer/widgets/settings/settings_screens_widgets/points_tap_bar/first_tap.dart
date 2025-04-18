import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/get_points.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../../../../shared/components/constants.dart';


class FirstTap extends StatelessWidget {

  FirstTap({required this.model,this.fromAuction = false});

  Packages model;
  bool fromAuction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        SettingsCubit.get(context).buyPoints(id: model.id!, context: context,fromAuction: fromAuction);
        //navigateTo(context, PointsCheckOutScreen())
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        child: Container(
          height: size!.height>670? size!.height*.13:size!.height*.2,
          width: double.infinity,
          padding: const EdgeInsetsDirectional.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: Colors.grey.shade300)
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text(
                    model.name!,
                    style:const TextStyle(color: Colors.grey,fontSize: 12,),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    '${model.price} ${tr('sar')} | ${model.coinsNum} ${tr('coin')}',
                    style:const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                  width: 40,
                  child: Image.asset(BuyerImages.points,height: 40,width: 40,))
            ],
          ),
        ),
      ),
    );
  }
}
