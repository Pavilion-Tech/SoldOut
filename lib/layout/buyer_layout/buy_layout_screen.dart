import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_states.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_states.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import '../../modules/widgets/wrong_screens/maintance_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'cubit/buyer_cubit.dart';
import 'nav_screen.dart';

class BuyerLayout extends StatelessWidget {
  Color selectColor = defaultColorTwo;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero,(){
      BuyerCubit.get(context).dynamicLink();
      BuyerCubit.get(context).checkUpdate(context);
    });
    return BlocConsumer<BuyerCubit, BuyerStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
        if(SettingsCubit.get(context).settingsModel!=null){
          if(SettingsCubit.get(context).settingsModel!.data!.maintenance!){
            navigateAndFinish(context, MaintanceScreen());
          }
        }
      },
      builder: (context, state) {
        var cubit = BuyerCubit.get(context);
        return Scaffold(
          extendBody: true,
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
                'icon':cartItem(HexColor('#A0AEC0')),
                'activeIcon': cartItem(selectColor),
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

  Widget cartItem(Color color)
  {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
      },
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Icon(Icons.shopping_cart, size: 30,color:color),
            if(cubit.getCartModel!= null && cubit.getCartModel!.data!.isNotEmpty)
              Positioned(
               bottom: 12,
                left: 12,
                child: Container(
                    height: 18,
                    width: 18,
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(30),
                        color: Colors.red
                    ),
                    child: Text(
                      '${cubit.getCartModel!.data!.length}',
                      style:const TextStyle(color: Colors.white,height: 1.3,fontSize: 10),)
                ),
              )
          ],
        );
      },
    );
  }
}
