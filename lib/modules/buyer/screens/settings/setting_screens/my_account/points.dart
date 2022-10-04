import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/modules/widgets/my_container.dart';
import 'package:soldout/shared/components/constants.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../../../layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../../../shared/components/components.dart';
import '../../../../widgets/settings/settings_screens_widgets/points_tap_bar/first_tap.dart';
import '../../../../widgets/settings/settings_screens_widgets/points_tap_bar/second_tap.dart';
import '../../../../widgets/shimmers/points_loading/first_points_loading.dart';
import '../../../../widgets/shimmers/points_loading/second_points_loading.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({Key? key}) : super(key: key);

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;


  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    SettingsCubit.get(context).getAllPoints();
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('points'),
                isLastIcon: true,
                isArrowBack: true,
                lastIcon: Icons.shopping_cart,
                lastButtonTap: () {
                  BuyerCubit.get(context).changeIndex(2);
                  navigateAndFinish(context, BuyerLayout());
                }
            ),
            BlocConsumer<SettingsCubit, SettingsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = SettingsCubit.get(context);
                return MyContainer(
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
                      SizedBox(
                        height: size!.height,
                        child: TabBarView(
                          controller: _controller,
                          children: [
                            ConditionalBuilder(
                              condition:cubit.getPointsModel!= null,
                              fallback: (context)=>ListView.separated(
                                itemBuilder: (context, index)=>
                                const PointsLoading(),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 15,),
                                itemCount: 5,
                              ),
                              builder: (context)
                              {
                                if(cubit.getPointsModel!.data!.packages!.isNotEmpty)
                                {
                                  return ListView.separated(
                                    itemBuilder: (context, index) =>
                                        FirstTap(model:cubit.getPointsModel!.data!.packages![index]),
                                    separatorBuilder: (context, index) =>
                                    const SizedBox(height: 15,),
                                    itemCount: cubit.getPointsModel!.data!.packages!.length,
                                  );
                                }else
                                  {
                                    return Center(child: Text(tr('no_item')),);
                                  }
                              }
                            ),
                            ConditionalBuilder(
                              condition: cubit.getPointsModel!= null,
                              fallback: (context)=>SecondPointsLoading(),
                              builder: (context)=>const SecondTap(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
