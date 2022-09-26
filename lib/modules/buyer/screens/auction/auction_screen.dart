import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/widgets/auction/dialog.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../../shared/styles/colors.dart';
import '../../widgets/auction/auction_details.dart';
import '../../widgets/auction/hint.dart';
import '../../widgets/items_shared/indicator.dart';
import '../../widgets/items_shared/page_veiw.dart';
import '../../widgets/prodect/row_in_top.dart';

class AuctionScreen extends StatelessWidget {
  AuctionScreen({Key? key}) : super(key: key);

  PageController pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BuyerCubit, BuyerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BuyerCubit.get(context);
          return Stack(
            children: [
              MPageView(pageController: pageController,images:cubit.homeModel!.data!.newProducts![0].images!),
              RowInTop(isProduct: false),
              MIndicator(pageController: pageController,lengthPageView: cubit.homeModel!.data!.newProducts![0].images!.length),
              AuctionDetails(),
              if(showAuctionHint==null)
               const HintWidget(),
              if(showAuctionHint==null)
                joinAuction(context),
              addCoins(),
            ],
          );
        },
      ),
    );
  }

  Widget joinAuction(context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) =>const AuctionDialog(),
          );
        },
        child: Container(
          height: size!.height * .06,
          width: size!.width * .7,
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          padding:const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tr('join_auction'),
                style:const TextStyle(
                    color: defaultColorTwo,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Spacer(),
              Image.asset(BuyerImages.points, height: 30, width: 30,)
            ],
          ),
        ),
      ),
    );
  }

  Widget addCoins()
  {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 10,bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tr('bid'),
              style:const TextStyle(
                color: defaultColor,
                fontWeight: FontWeight.w900,
                fontSize: 22
              ),
            ),
            SizedBox(
              height: 70,
              width: 70,
              child: ClipPolygon(
                sides: 4,
                borderRadius: 15,
                child: Container(
                    padding: const EdgeInsets.all(5),
                    color: defaultColor,
                    child: const Icon(
                      Icons.add, color: defaultColorTwo, size: 35,)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
