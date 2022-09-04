import 'package:flutter/material.dart';

import '../../../../../shared/components/constants.dart';
import '../../../../../shared/styles/colors.dart';

class VPurchasesDetailsItem extends StatelessWidget {
  const VPurchasesDetailsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            '2015356',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900
            ),
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(
                Icons.person_outline_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: size!.width*.7,
                  child: Text(
                    'User Name',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(
                Icons.phone_android,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: size!.width*.7,
                  child: Text(
                    '01223364710',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                  width: size!.width*.7,
                  child: Text(
                    '18658 Tillman Plain, North Glennatown, Nevada, Peru',
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                  ))
            ],
          ),
          Spacer(),
          Row(
            children: [
              Text(
                'New Order',
                style: TextStyle(color: defaultColor,fontWeight: FontWeight.w900),
              ),
              Spacer(),
              Text(
                'Date: 20 Jun 2019',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
