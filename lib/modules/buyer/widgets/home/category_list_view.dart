import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/models/buyer_model/home_model/category_model.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';
import '../../screens/categories/categories_screen.dart';


class CategoryListView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var cubit = BuyerCubit.get(context);

    return SizedBox(
      height: size!.height * .046,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            categoryListView(cubit.homeModel!.data!.categories![index],context),
        separatorBuilder: (context, index) =>
            SizedBox(width: size!.height * .016,),
        itemCount: cubit.homeModel!.data!.categories!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget categoryListView(CategoryModel model,context) {
    return InkWell(
      onTap: (){
        navigateTo(context, CategoriesScreen(
          products: model.products!,
          name: model.name!,
        ));
      },
      child: Container(
        width: size!.width * .225,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(12),
          color: HexColor(model.hexColor!),
          //HexColor(model.hexColor!)
        ),
        child: Text(
          model.name!,
          style:const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
