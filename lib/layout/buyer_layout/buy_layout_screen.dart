import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';
import 'cubit/buyer_cubit.dart';
import 'nav_screen.dart';

class BuyerLayout extends StatelessWidget {
  Color selectColor = defaultColorTwo;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BuyerCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: NavBar(
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
                Icon(Icons.notifications, size: 30,color:selectColor),

              },
              {
                'icon':
                Icon(Icons.shopping_cart, size: 25,color: HexColor('#A0AEC0')),
                'activeIcon':
                Icon(Icons.shopping_cart, size: 30,color:selectColor),
              },
              {
                'icon':
                Icon(Icons.menu, size: 25,color: HexColor('#A0AEC0')),

                'activeIcon':
                Icon(Icons.menu, size: 30,color:selectColor),
              }
            ],
          ),
        );
      },
    );
  }
}
