import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/vendor_layout/vendor_nav_screen.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'cubit/vendor_cubit.dart';
import 'cubit/vendor_states.dart';

class VendorLayout extends StatelessWidget {
  Color selectColor = defaultColorTwo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit, VendorStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);

      },
      builder: (context, state) {
        var cubit = VendorCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: VendorNavBar(
            items: [
              {
                'icon':
                Image.asset(BuyerImages.home,color:HexColor('#A0AEC0'),height: 25,width: 25,),
                'activeIcon':
                Image.asset(BuyerImages.home,color:selectColor,height: 25,width: 25,),
              },
              {
                'icon':
                Icon(Icons.notifications, size: 25,color: HexColor('#A0AEC0')),
                'activeIcon':
                Icon(Icons.notifications, size: 25,color:selectColor),

              },
              {
                'icon':
                Icon(Icons.add_circle, size: 25,color: HexColor('#A0AEC0')),
                'activeIcon':
                Icon(Icons.add_circle, size: 25,color:selectColor),
              },
              {
                'icon':
                Image.asset(BuyerImages.box,color:HexColor('#A0AEC0'),height: 25,width: 25,),
                'activeIcon':
                Padding(
                  padding: const EdgeInsetsDirectional.all(15),
                  child: Image.asset(BuyerImages.box,color:selectColor),
                )
              },
              {
                'icon':
                Icon(Icons.menu, size: 25,color: HexColor('#A0AEC0')),

                'activeIcon':
                Icon(Icons.menu, size: 25,color:selectColor),
              }
            ],
          ),
        );
      },
    );
  }
}
