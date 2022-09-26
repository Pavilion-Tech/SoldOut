import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/models/buyer_model/product_model/product_model.dart';
import 'package:soldout/modules/vendor/widgets/add_product/add_product_widget.dart';

import '../../../../shared/components/components.dart';
import '../../../widgets/my_container.dart';

class EditProduct extends StatelessWidget {
  EditProduct({this.productModel});


  ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
              context: context,
              arrowTap: (){
                productModel = null;
                VendorCubit.get(context).nullingData();
                Navigator.pop(context);
              },
              title: tr('edit_product'),
                isArrowBack: true
            ),
            MyContainer(
              noSize: true,
                AddOrEditProductWidget(
                  isEdit: true,
                    productModel:productModel
                ),
            ),
          ],
        ),
      )
    );
  }
}
