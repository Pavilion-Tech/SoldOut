import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class SuffixProduct extends StatefulWidget {
  const SuffixProduct({Key? key}) : super(key: key);

  @override
  _SuffixProductState createState() => _SuffixProductState();
}

class _SuffixProductState extends State<SuffixProduct> {

  int _value = 1;
  bool isSelected = true;


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
            bottomSheet();
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

  Future bottomSheet(){
    return showModalBottomSheet(
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
  }

  Widget sortSheet(setState) {
    return Container(
      height: size!.height * .28,
      decoration: const BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(10),
          topEnd: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsetsDirectional.only(top: 20,bottom: 20),
      child: Column(
        children: [
          Text(
            tr('sorting_by'),
            style:const TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: size!.height * .0125,
          ),
          RadioListTile(
            value: 1,
            groupValue: _value,
            selected: isSelected,
            dense: !isSelected,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
                isSelected = !isSelected;
              });
            },
            activeColor: defaultColor,
            title: Text(tr('price_high_to_low')),
          ),
          RadioListTile(
            value: 2,
            groupValue: _value,
            selected: !isSelected,
            dense: isSelected,
            onChanged: (int? value) {
              setState(() {
                _value = value!;
                isSelected = !isSelected;
              });
            },
            activeColor: defaultColor,
            title: Text(tr('price_low_to_high')),
          ),
          Spacer(),
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
                defaultButton( onTap: () {}, text:tr('apply')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
