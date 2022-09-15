import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/shared/components/components.dart';

class FilterWidget extends StatelessWidget {

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();

  int? checkNum(TextEditingController controller,int index){
    String num = controller.text.split('/')[index];
    return num.length ==2 ? null: 0;
  }

  String changeFormat(TextEditingController controller){
    return'${controller.text.trim().split('/')[2]}-${checkNum(controller,1)??''}${controller.text.trim().split('/')[1]}-${checkNum(controller,0)??''}${controller.text.trim().split('/')[0]}';

  }


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
                        fromDateController.text =
                            DateFormat(null,'en').add_yMd().format(value!)
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
                      if(fromDateController.text.isNotEmpty){
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.parse("2020-11-11"),
                          lastDate: DateTime.parse("2050-11-29"),
                        ).then((value) {
                          toDateController.text = DateFormat(null,'en')
                              .add_yMd().format(value!)
                              .toString();
                          String startDate = changeFormat(fromDateController);
                          String lastDate = changeFormat(toDateController);

                          VendorCubit.get(context).getStatistic(
                            startDate: startDate,
                            lastDate: lastDate,
                            context: context
                          );
                        });
                      }else{
                        showToast(msg: 'Choose From Date First',toastState: true);
                      }
                    }
                )
            ),
          ],
        ),
      ],
    );
  }
}
