import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/models/buyer_model/settings_model.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import '../../../../models/buyer_model/home_model/new_auctions_model.dart';
import '../../../../shared/components/constants.dart';


class CategoryListViewAutions extends StatelessWidget {

  CategoryListViewAutions({required this.newAuctions});

  List<AuctionModel> newAuctions;



  @override
  Widget build(BuildContext context) {
    var cubit = SettingsCubit.get(context);

    return SizedBox(
      height: size!.height * .046,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            categoryListView(cubit.settingsModel!.data!.categories![index],context),
        separatorBuilder: (context, index) =>
            SizedBox(width: size!.height * .016,),
        itemCount: cubit.settingsModel!.data!.categories!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget categoryListView(Categories model,context) {
    return InkWell(
      onTap: (){
        AuctionCubit.get(context).currentCategory(newAuctions, model.id!);
      },
      child: Container(
        alignment: AlignmentDirectional.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
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
