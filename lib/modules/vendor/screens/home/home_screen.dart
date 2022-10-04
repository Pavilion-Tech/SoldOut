import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_states.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../widgets/home/filter_widget.dart';
import '../../widgets/home/home_item_widget.dart';
import '../../widgets/loading/home_loading.dart';

class VendorHomeScreen extends StatelessWidget {
  FilterWidget filterWidget = FilterWidget();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit, VendorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = VendorCubit.get(context);
          return Stack(
            children: [
              BlocConsumer<VSettingCubit, VSettingStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  return myAppBar(
                      context: context,
                      title: VSettingCubit.get(context).nameC.text);
                },
              ),
              MyContainer(
                ConditionalBuilder(
                  condition: cubit.getStatistics != null,
                  fallback: (context) => const VHomeLoading(),
                  builder: (context) => SingleChildScrollView(
                    child: Column(
                      children: [
                        filterWidget,
                        const SizedBox(height: 20,),
                        HomeItemWidget(
                          title: tr('product_count'),
                          count:
                              '${cubit.getStatistics!.data!.productsCount} ${tr('product')}',
                          circleColor: defaultColor,
                        ),
                        const SizedBox(height: 20,),
                        HomeItemWidget(
                          title: tr('order_count'),
                          count:
                              '${cubit.getStatistics!.data!.ordersCount} ${tr('order')}',
                          circleColor: Colors.indigoAccent,
                        ),
                        const SizedBox(height: 20,),
                        HomeItemWidget(
                          title: tr('total_revenue'),
                          count:
                              '${cubit.getStatistics!.data!.totalRevenue} ${tr('sar')}',
                          circleColor: Colors.lightBlueAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
}
