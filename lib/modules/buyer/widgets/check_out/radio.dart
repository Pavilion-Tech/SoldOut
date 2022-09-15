import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/styles/colors.dart';

class CustomRadio extends StatefulWidget {
  CustomRadio({Key? key,required this.radioValue}) : super(key: key);

  int radioValue;
  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {


  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        RadioListTile(
          value: 0,
          groupValue: widget.radioValue,
          selected: isSelected,
          onChanged: (int? value) {
            setState(() {
              widget.radioValue = value!;
              isSelected = !isSelected;
            });
          },
          toggleable: true,
          activeColor: defaultColor,
          title: Text(tr('cash_on_delivery')),
        ),
        RadioListTile(
          value: 1,
          groupValue: widget.radioValue,
          selected: !isSelected,
          toggleable: true,
          onChanged: (int? value) {
            setState(() {
              widget.radioValue = value!;
              isSelected = !isSelected;
            });
          },
          activeColor: defaultColor,
          title: Text(tr('credit_card'),
        ),
        ),
      ],
    );
  }
}
