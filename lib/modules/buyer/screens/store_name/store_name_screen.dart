import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/buy_layout_screen.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/my_container.dart';
import '../../widgets/items_shared/grid_view.dart';
import '../../widgets/sort/suffix.dart';

class StoreNameScreen extends StatelessWidget {
  StoreNameScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  Suffix? suffix;

  @override
  Widget build(BuildContext context) {
    suffix = Suffix(apply:(){
      print(suffix!.sort!.sortValue);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            myAppBar(
              context: context,
              isArrowBack: true,
              title: 'Store Name',
              isLastIcon: true,
              lastIcon: Icons.shopping_cart,
              lastButtonTap: () {
                BuyerCubit.get(context).currentIndex = 2 ;
                navigateAndFinish(context, BuyerLayout());
              },
            ),
            MyContainer(
              noSize: true,
              Column(
                children: [
                  defaultTextField(
                      controller: searchController,
                      hint: tr('search_by_product'),
                      suffix:suffix
                  ),
                  GridViewWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
