import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../../../shared/styles/colors.dart';
import '../../../../screens/settings/setting_screens/my_account/order/purchases_details.dart';

class OrderHistoryWidget extends StatefulWidget {

  @override
  State<OrderHistoryWidget> createState() => _OrderHistoryWidgetState();
}

class _OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        defaultTextField(
            controller: TextEditingController(),
            hint: tr('search_by_order'),
            suffix:suffixWidget(context)),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context,index)=>orderItem(),
          separatorBuilder: (context,index)=>SizedBox(height: 10,),
          itemCount: 6,
        ),
      ],
    );
  }

  Widget orderItem() {
    return InkWell(
      onTap: (){
        navigateTo(context, PurchasesDetails());
      },
      child: Container(
        height: size!.height * .09,
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
            Text('Order #2015356',style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            Spacer(),
            Row(
              children: [
                Text('Date: 20 Jun 2019',style:const TextStyle(color: Colors.grey,fontSize: 12),),
                Spacer(),
                Text(tr('new_order'),style:const TextStyle(color: Colors.blue,fontSize: 12,fontWeight: FontWeight.bold),),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget suffixWidget(context){
    return  Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: size!.height * .03,
          width: 1,
          color: Colors.grey.shade200,
        ),
        SizedBox(
          width: size!.width * .05,
        ),
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: defaultColorTwo,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(15),
                    topEnd: Radius.circular(15),
                  )),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              builder: (context) => StatefulBuilder(
                  builder: (context, setStateSB) =>
                      sortSheet(setStateSB)),
            );
          },
          child: Icon(
            Icons.filter_alt_outlined,
            size: 30,
            color: Colors.grey.shade400,
          ),
        )
      ],
    );
  }

  Widget sortSheet(setState) {
    return Container(
      height: size!.height * .40,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text(
            tr('order_status'),
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          SizedBox(
            height: size!.height * .0125,
          ),
          RadioListTile(
            value: 1,
            groupValue: _value,
            selected: _value == 1,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
                print(_value);
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('canceled'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 2,
            groupValue: _value,
            selected: _value == 2,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('new_order'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 3,
            groupValue: _value,
            selected: _value == 3,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('delivery'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 4,
            groupValue: _value,
            selected: _value == 4,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('delivered'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultButton(
                  onTap: () {},
                  text: tr('discard'),
                  textColor: defaultColor,
                  buttonColor: defaultColorTwo,
                ),
                SizedBox(
                  width: size!.height * .008,
                ),
                defaultButton( onTap: () {}, text: tr('apply')),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
