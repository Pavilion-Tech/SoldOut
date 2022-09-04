import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: defaultTextField(
          controller: TextEditingController(),
          hint: tr('enter_discount'),
          suffix:suffixWidget()),
    );
  }

  Widget suffixWidget(){
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
        TextButton(onPressed: (){}, child: Text(tr('apply'))
        )
      ],
    );
  }
}
