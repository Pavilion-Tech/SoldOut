import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class SuffixWidget extends StatefulWidget {

  int value = 1;

  @override
  State<SuffixWidget> createState() => _SuffixWidgetState();
}

class _SuffixWidgetState extends State<SuffixWidget> {

  @override
  Widget build(BuildContext context) {
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
            style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
          SizedBox(
            height: size!.height * .0125,
          ),
          RadioListTile(
            value: 1,
            groupValue: widget.value,
            selected: widget.value == 1,
            onChanged: (int? value) {
              setState(() {
                widget.value = value!;
                print(widget.value);
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('canceled'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 2,
            groupValue: widget.value,
            selected: widget.value == 2,
            onChanged: (int? value) {
              setState(() {
                widget.value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('new_order'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 3,
            groupValue: widget.value,
            selected: widget.value == 3,
            onChanged: (int? value) {
              setState(() {
                widget.value = value!;
              });
            },
            activeColor: defaultColor,
            title: Text(
              tr('delivery'),
              style:const TextStyle(fontWeight: FontWeight.bold),),
          ),
          RadioListTile(
            value: 4,
            groupValue: widget.value,
            selected: widget.value == 4,
            onChanged: (int? value) {
              setState(() {
                widget.value = value!;
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
