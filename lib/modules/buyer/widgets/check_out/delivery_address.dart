import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({Key? key}) : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {

  String? dropdownvalue;
  var items = [
    'city 1',
    'city 2',
    'city 3',
    'city 4',
    'city 5',
  ];

  int currentAddress = 0;
  int otherIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: Column(
        children: [
          ListView.separated(
              itemBuilder: (context,index)=> address(index),
              separatorBuilder: (context,index)=> SizedBox(height: 20,),
              itemCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          SizedBox(height: 10,),
          otherAddress(),
        ],
      ),
    );
  }

  Widget address (int index){
    return InkWell(
      onTap: (){
        setState(() {
          currentAddress = index;
        });
      },
      child: Container(
        height: size!.height*.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            color:currentAddress == index ? Colors.blue:Colors.grey.shade300.withOpacity(.5) ,
          ),
          color: currentAddress == index ? Colors.blue.withOpacity(.5) : null,
        ),
        padding: const EdgeInsetsDirectional.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('HOME',style: TextStyle(fontWeight: FontWeight.bold),),
                if(currentAddress == index)
                  Spacer(),
                if(currentAddress == index)
                  Icon(Icons.check_circle,color: Colors.blue,),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Icon(Icons.location_on_outlined),
                SizedBox(width: 10,),
                Container(
                  width: size!.width *.75,
                    height: size!.height*.015,
                    child: Text('18658 Tillman Plain, North Glennatown, Nevada, Peru',
                      style: TextStyle(fontSize: 13,height: .9),))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget otherAddress(){
    return Column(
      children: [
        InkWell(
          onTap: (){
            setState(() {
              currentAddress = otherIndex;
            });
          },
          child: Column(
            children: [
              Container(
                height: size!.height*.07,
                alignment: AlignmentDirectional.centerStart,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  border: Border.all(
                    color:currentAddress == otherIndex ? Colors.blue:Colors.grey.shade300.withOpacity(.5) ,
                  ),
                  color: currentAddress == otherIndex ? Colors.blue.withOpacity(.5) : null,
                ),
                padding: const EdgeInsetsDirectional.all(10),
                child: Row(
                  children: [
                    Text(
                      tr('other'),
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    if(currentAddress == otherIndex)
                      Spacer(),
                    if(currentAddress == otherIndex)
                      Icon(Icons.check_circle,color: Colors.blue,),
                  ],
                ),
              ),
              if(currentAddress == otherIndex)
                Column(
                children: [
                  SizedBox(height: 10,),
                  defaultTextField(controller: TextEditingController(), hint: tr('address1'),),
                  SizedBox(height: 10,),
                  defaultTextField(controller: TextEditingController(), hint: tr('address2')),
                  SizedBox(height: 10,),
                  Container(
                    height: size!.height*.06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: defaultColorTwo,
                      borderRadius: BorderRadiusDirectional.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 15),
                    child: DropdownButton(
                      isExpanded: true,
                      underline: SizedBox(),
                      borderRadius: BorderRadius.circular(10),
                      value: dropdownvalue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          dropdownvalue = newValue as String;
                        });
                      },
                      hint: Text(tr('city'),style: TextStyle(color: Colors.grey),),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ],
    );
  }
}
