import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

class FilterWidget extends StatelessWidget {

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('filter_your_statistics'),
          style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
                child: defaultTextField(
                    controller: fromDateController,
                    hint: tr('from_date'),
                    readOnly: true,
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse("2020-11-11"),
                        lastDate: DateTime.parse("2050-11-29"),
                      ).then((value) {
                        fromDateController.text = DateFormat.yMMMd()
                            .format(value!)
                            .toString();
                      });
                    }
                )
            ),
            const SizedBox(width: 10,),
            Expanded(
                child: defaultTextField(
                    controller: toDateController,
                    hint: tr('to_date'),
                    readOnly: true,
                    onTap: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.parse("2020-11-11"),
                        lastDate: DateTime.parse("2050-11-29"),
                      ).then((value) {
                        toDateController.text = DateFormat.yMMMd()
                            .format(value!)
                            .toString();
                      });
                    }
                )
            ),
          ],
        ),
      ],
    );
  }
}
