import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../models/vendor_model/vendor_order_model.dart';
import '../../../../../shared/components/constants.dart';

class VPurchasesDetailsItem extends StatelessWidget {
  VPurchasesDetailsItem({required this.model});

  VendorOrderData model;
  late String time;

  @override
  Widget build(BuildContext context) {
    time =  DateFormat('',myLocale == 'ar'?'ar':'en')
        .add_yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(model.createdAt!));
    return Container(
      height: size!.height * .21,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(
          color: Colors.grey.shade300.withOpacity(.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.id}',
            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w900
            ),
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              const Icon(Icons.person_outline_outlined, color: Colors.blue,),
              const SizedBox(width: 10,),
              SizedBox(
                  width: size!.width*.7,
                  child: Text(
                    model.user!.name!,
                    style:const TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              const Icon(Icons.phone_android, color: Colors.blue,),
              const SizedBox(width: 10,),
              SizedBox(
                  width: size!.width*.7,
                  child: Text(
                    model.user!.phone!,
                    style:const TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
            ],
          ),
          const SizedBox(height: 5,),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, color: Colors.blue,),
              const SizedBox(width: 10,),
              SizedBox(
                  width: size!.width*.7,
                  child: Text(
                    model.shippingAddress!,
                    style:const  TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              Text(
                time,
                style:const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
