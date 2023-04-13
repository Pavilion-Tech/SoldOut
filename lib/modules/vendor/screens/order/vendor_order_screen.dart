import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/loadings/address&order_loading/address&order_loading.dart';
import '../../widgets/order/vendor_order_item_widget.dart';

class VendorOrderScreen extends StatelessWidget {
  const VendorOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          myAppBar(context: context, title: tr('my_orders')),
          BlocConsumer<VendorCubit, VendorStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = VendorCubit.get(context);
              return MyContainer(
                noSize: cubit.vendorOrderModel!=null,
                  ConditionalBuilder(
                    condition: cubit.vendorOrderModel!=null,
                    fallback: (context) => const AddressAndOrderLoading(),
                    builder: (context) =>  Column(
                      children: [
                        defaultTextField(
                            controller: cubit.searchController,
                            hint: tr('search_by_order'),
                            type: TextInputType.number,
                            onChanged: (value)
                            {
                              if(value.isNotEmpty)
                              {
                                cubit.searchOrder(int.parse(cubit.searchController.text.trim()));
                                if(cubit.searchModel== null)
                                {
                                  showToast(msg: tr('order_not_found'));
                                }
                              }else
                                {
                                  cubit.nullSearch();
                                }
                            }
                        ),
                        if(cubit.vendorOrderModel!.data!.isNotEmpty)
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => OrderItem(
                            model:cubit.searchModel!= null
                                ?cubit.searchModel!
                                : cubit.vendorOrderModel!.data![index],
                          ),
                          separatorBuilder: (context, index) =>
                             const SizedBox(height: 10,),
                          itemCount:cubit.searchModel!= null
                              ? 1
                              : cubit.vendorOrderModel!.data!.length,
                        ),
                        if(cubit.vendorOrderModel!.data!.isEmpty)
                          Center(child: Column(
                            children: [
                              Text(tr(tr('no_order'))),
                              const SizedBox(height: 150,),
                            ],
                          ),)
                      ],
                    ),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
