import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/vendor/screens/manage_product/vendor_edit_product.dart';
import 'package:soldout/modules/vendor/widgets/manage_product_widgets/delet_dialog.dart';
import 'package:soldout/shared/components/components.dart';

import '../../widgets/product_screen_widgets/vendor_indicator.dart';
import '../../widgets/product_screen_widgets/vendor_page_veiw.dart';
import '../../widgets/product_screen_widgets/vendor_product_details.dart';
import '../../widgets/product_screen_widgets/vendor_row_in_top.dart';

class VProductScreen extends StatelessWidget {

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          VPageView(pageController: pageController,),
          VRowInTop(),
          VIndicator(pageController: pageController),
          VProductDetails(),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding:const EdgeInsetsDirectional.all(20),
              child: Row(
                children: [
                  defaultButton(
                    onTap: (){
                      showDialog(context: context, builder: (context){
                        return DeletDialog();
                      });
                    },
                    text:tr('delete_product'),
                    radiusColor: Colors.red,
                    buttonColor: Colors.red,
                  ),
                  SizedBox(width: 5,),
                  defaultButton(
                      onTap: (){
                        navigateTo(context, VendorEditProductScreen());
                      },
                      text: tr('edit_product'))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
