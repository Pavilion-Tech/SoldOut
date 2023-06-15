import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/components.dart';

import '../../widgets/add_product/add_product_widget.dart';

class VendorAddProductScreen extends StatelessWidget {
  const VendorAddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit,VendorStates>(
      listener: (context,state){},
      builder: (context,state){
        return  SingleChildScrollView(
          child: InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Stack(
              children: [
                myAppBar(
                  context: context,
                  title: tr('add_product'),
                ),
                MyContainer(
                  noSize: true,
                  AddOrEditProductWidget(isEdit: false),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
