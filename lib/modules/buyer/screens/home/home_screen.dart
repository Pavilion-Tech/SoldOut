import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/widgets/home/list_auctions.dart';
import 'package:soldout/modules/buyer/widgets/home/list_proucts.dart';
import 'package:soldout/modules/buyer/widgets/shimmers/home_loading/home_loading.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../layout/buyer_layout/cubit/buyer_states.dart';
import '../../../../shared/components/constants.dart';
import '../../widgets/home/carousel_slider.dart';
import '../../widgets/home/category_list_view.dart';
import '../auction/auction_list_screen.dart';
import '../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          myAppBar(
              context: context,
              title: tr('welcome'),
              isLastIcon: true,
              lastIcon: Icons.search,
              lastButtonTap: () {
                BuyerCubit.get(context).search();
                navigateTo(context, SearchScreen());
              },
              height: size!.height * .20
          ),
          //HomeLoading(),
          BlocConsumer<BuyerCubit, BuyerStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = BuyerCubit.get(context);
              return ConditionalBuilder(
                condition:state is! GetHomeDataLoadingState&&cubit.homeModel != null,
                fallback: (context)=>HomeLoading(),
                builder:(context)=> Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: size!.height * .11,
                        right: size!.width * .05,
                        left: size!.width * .05,
                        bottom: size!.height * .003,
                      ),
                      child: Column(
                        children: [
                          CarouselSliderWidget(),
                          CategoryListView(),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        seeMore(tr('new_arrivals'), () {}),
                        Container(
                            height: size!.height * .197,
                            alignment: AlignmentDirectional.centerStart,
                            padding:
                            EdgeInsetsDirectional.only(start: size!.width * .050),
                            child: ListProducts()
                        ),
                        seeMore(tr('new_auctions'), () {
                          navigateTo(context, AuctionsListScreen());
                        }),
                        Container(
                            height: size!.height * .20,
                            alignment: AlignmentDirectional.centerStart,
                            padding:
                            EdgeInsetsDirectional.only(start: size!.width * .050),
                            child: ListAuctions()),
                        SizedBox(height: size!.height * .02),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget seeMore(String text, VoidCallback callback) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size!.width * .05,
          vertical: size!.height * .005),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          IconButton(
            onPressed: callback,
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }

}
