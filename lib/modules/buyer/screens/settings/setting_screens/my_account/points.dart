import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../widgets/settings/settings_screens_widgets/points_tap_bar/first_tap.dart';
import '../../../../widgets/settings/settings_screens_widgets/points_tap_bar/second_tap.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({Key? key}) : super(key: key);

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;


  @override
  void initState() {
    super.initState();
    _controller =  TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('points'),
                isLastIcon: true,
                isArrowBack: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: (){
                  BuyerCubit.get(context).changeIndex(2);
                  navigateAndFinish(context, BuyerLayout());
                }
            ),
            MyContainer(
              noSize: true,
                Column(
                  children: [
                    TabBar(
                      controller: _controller,
                      tabs: [
                        Tab(
                          text: tr('points_package'),
                        ),
                        Tab(
                          text: tr('my_points'),
                        ),
                      ],
                      unselectedLabelColor: Colors.black,
                      labelColor: defaultColor,
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: size!.height,
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          ListView.separated(
                            itemBuilder: (context,index)=>FirstTap(),
                            separatorBuilder: (context,index)=>SizedBox(height: 15,),
                            itemCount: 1,
                          ),
                          SecondTap(),
                        ],
                      ),
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
