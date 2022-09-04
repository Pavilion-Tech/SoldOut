import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class Sort extends StatefulWidget {

  Sort({required this.apply});

  int sortValue = 0;
  bool isSelected = true;
  VoidCallback apply;

  @override
  State<Sort> createState() => _SortState();
}

class _SortState extends State<Sort> {
  @override
  Widget build(BuildContext context) {
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
            style:const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size!.height * .0125,),
          RadioListTile(
            value: 0,
            groupValue: widget.sortValue,
            selected: widget.isSelected,
            onChanged: (int? value) {
              setState(() {
                widget.sortValue = value!;
                widget.isSelected = !widget.isSelected;
              });
            },
            activeColor: defaultColor,
            title: Text(tr('price_high_to_low')),
          ),
          RadioListTile(
            value: 1,
            groupValue: widget.sortValue,
            selected: !widget.isSelected,
            onChanged: (int? value) {
              setState(() {
                widget.sortValue = value!;
                widget.isSelected = !widget.isSelected;
              });
            },
            activeColor: defaultColor,
            title: Text(tr('price_low_to_high')),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultButton(
                  onTap: ()=>Navigator.pop(context),
                  text: tr('discard'),
                  textColor: defaultColor,
                  buttonColor: defaultColorTwo,
                ),
                SizedBox(
                  width: size!.height * .008,
                ),
                defaultButton( onTap: widget.apply, text: tr('apply')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
