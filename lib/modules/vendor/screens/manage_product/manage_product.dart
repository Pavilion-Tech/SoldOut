import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/manage_product_widgets/suffix_product.dart';
import '../../widgets/manage_product_widgets/vendor_product_item.dart';

class VendorManageProductList extends StatelessWidget {
  const VendorManageProductList({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('manage_products'),
                isArrowBack: true
            ),
            MyContainer(
              noSize: true,
                Column(
                  children: [
                    defaultTextField(
                        controller: TextEditingController(),
                        hint: tr('search_by_product'),
                        suffix:SuffixProduct()),
                    GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: 1 / 1.02,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      children: List.generate(
                        6, (index) => VProductItem(
                        title: 'Mac Book Pro Max Fax Dax Rax',
                        price: 10000000000000,
                        id: '2',
                        rate: 4,
                      ),
                      ),
                    ),
                    SizedBox(height: 40,),
                    defaultButton(onTap: (){
                      Navigator.pop(context);
                      VendorCubit.get(context).changeIndex(2);
                    }, text: tr('add_new'))
                  ],
                )),
          ],
        ),
      ),
    );
  }


}

