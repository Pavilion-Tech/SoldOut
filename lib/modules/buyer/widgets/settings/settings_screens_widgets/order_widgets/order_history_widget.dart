import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../models/buyer_model/order_model.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../screens/settings/setting_screens/my_account/order/purchases_details.dart';
import '../../../../screens/settings/settings_cubit/settings_cubit.dart';

class OrderHistoryWidget extends StatelessWidget {
  const OrderHistoryWidget({Key? key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SettingsCubit.get(context);
    return Column(
      children: [
        if(cubit.orderModel!.data!.isNotEmpty)
          defaultTextField(
          controller: cubit.searchController,
          hint: tr('search_by_order'),
            type: TextInputType.number,
            onChanged: (value)
            {
              if(value.isNotEmpty)
              {
                cubit.searchOrder(int.parse(cubit.searchController.text.trim()));
                if(cubit.searchOrderModel== null)
                {
                  showToast(msg: tr('order_not_found'));
                }
              }else
                {
                  cubit.nullSearch();
                }
            }
        ),
        if(cubit.orderModel!.data!.isNotEmpty)
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index)=>orderItem(
              context: context,
              model: cubit.searchOrderModel != null
                  ? cubit.searchOrderModel!
                  :  cubit.orderModel!.data![index],
            ),
            separatorBuilder: (context,index)=>const SizedBox(height: 10,),
            itemCount: cubit.searchOrderModel != null
                ? 1
                :cubit.orderModel!.data!.length,
          ),
        if(cubit.orderModel!.data!.isEmpty)
          Center(child: Text(tr('no_order'))),

      ],
    );
  }

  Widget orderItem({
    required BuildContext context,
    required OrderData model,
  }) {
    String time =  DateFormat('',myLocale == 'ar'?'ar':'en')
        .add_yMMMMEEEEd()
        .format(DateTime.fromMillisecondsSinceEpoch(model.createdAt!));
    return InkWell(
      onTap: (){
        navigateTo(context, PurchasesDetails(model: model,));
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
            Text(
              '${tr('orderHistory')}${model.id!}',
              style:const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            const Spacer(),
            Text(
              time,
              style:const TextStyle(color: Colors.grey,fontSize: 12),),
          ],
        ),
      ),
    );
  }

}

