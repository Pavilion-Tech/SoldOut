import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_states.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/loadings/show_product_loading/show_product_loading.dart';
import '../../widgets/auction/add_coins.dart';
import '../../widgets/auction/auction_details.dart';
import '../../widgets/auction/dialog.dart';
import '../../widgets/auction/hint.dart';
import '../../widgets/auction/join_auction.dart';
import '../../widgets/items_shared/indicator.dart';
import '../../widgets/items_shared/page_veiw.dart';
import '../../widgets/prodect/row_in_top.dart';

class AuctionScreen extends StatelessWidget {
  PageController pageController = PageController();

  int x =0;


  @override
  Widget build(BuildContext context) {
    AuctionCubit.get(context).isUserJoined =
        AuctionCubit.get(context).auctionModel!.isUserJoined!;
    return Scaffold(
      body: BlocConsumer<AuctionCubit, AuctionStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AuctionCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.auctionModel != null,
              fallback: (context) => ProductLoading(),
              builder: (context) {
                if(x==0)
                  Future.delayed(Duration.zero,(){
                  if (AuctionCubit.get(context).auctionModel!.isUserWinner!) {
                    showDialog(
                      //barrierDismissible: false,
                      context: context,
                      builder: (context) => AuctionDialog(cubit.auctionModel!.id!),
                    );
                  }
                });
                x++;
                return Stack(
                  children: [
                    MPageView(
                        pageController: pageController,
                        images: cubit.auctionModel!.images!),
                    RowInTop(
                      isProduct: false,
                      id: cubit.auctionModel!.id,
                      status: cubit.auctionModel!.status,
                    ),
                    MIndicator(
                        pageController: pageController,
                        lengthPageView: cubit.auctionModel!.images!.length),
                    AuctionDetails(cubit.auctionModel!, cubit.duration),
                    if (showAuctionHint == null && cubit.isUserJoined)
                      const HintWidget(),
                    if (!cubit.isUserJoined &&
                        cubit.auctionModel!.status == 'processing')
                      JoinAuction(
                        id: cubit.auctionModel!.id!,
                        coins: cubit.auctionModel!.auctionJoiningCoins!,
                        state: state,
                      ),
                    if (cubit.isUserJoined &&
                        cubit.auctionModel!.status == 'processing')
                      AddCoins(cubit.auctionModel!.id!),
                  ],
                );
              });
        },
      ),
    );
  }
}
