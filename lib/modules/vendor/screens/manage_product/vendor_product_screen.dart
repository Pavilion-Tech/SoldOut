import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/widgets/manage_product_widgets/delet_dialog.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../layout/vendor_layout/cubit/vendor_cubit.dart';
import '../../../../layout/vendor_layout/cubit/vendor_states.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../widgets/product_screen_widgets/vendor_indicator.dart';
import '../../widgets/product_screen_widgets/vendor_page_veiw.dart';
import '../../widgets/product_screen_widgets/vendor_product_details.dart';
import '../../widgets/product_screen_widgets/vendor_row_in_top.dart';
import 'edit_product.dart';

class VProductScreen extends StatelessWidget {

  PageController pageController = PageController();

  VProductScreen({
    required this.productModel,
  });

  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VendorCubit, VendorStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              VPageView(
                  pageController: pageController, images: productModel.images!),
              VRowInTop(),
              VIndicator(pageController: pageController,
                  lengthPageView: productModel.images!.length),
              VProductDetails(productModel: productModel),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Padding(
                  padding:  EdgeInsetsDirectional.all(size!.height > 670 ?20:15),
                  child: Row(
                    children: [
                      defaultButton(
                        onTap: () {
                          showDialog(context: context, builder: (context) {
                            return DeletDialog(id: productModel.id!,);
                          });
                        },
                        text: tr('delete_product'),
                        radiusColor: Colors.red,
                        buttonColor: Colors.red,
                      ),
                      const SizedBox(width: 5,),
                      defaultButton(
                          onTap: () {
                            navigateTo(context, EditProduct(),
                            );
                          },
                          text: tr('edit_product'))
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}
