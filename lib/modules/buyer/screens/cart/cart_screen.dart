import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/images/images.dart';
import '../../../widgets/my_container.dart';
import '../../auth/sign_in/sign_in_screen.dart';
import '../../widgets/cart/cart_item.dart';
import '../../widgets/shimmers/cart_loading/cart_loading.dart';
import '../check_out/cart_check_out.dart';
import '../settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'cart_cubit/cart_cubit.dart';
import 'cart_cubit/cart_states.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        return SingleChildScrollView(
          child: Stack(
            children: [
              myAppBar(
                context: context,
                title: tr('shopping_cart'),
              ),
              MyContainer(
                noSize: true,
                ConditionalBuilder(
                  condition: cubit.getCartModel != null,
                  fallback: (context)=>const CartLoading(),
                  builder: (context){
                    if(cubit.getCartModel!.data!.isNotEmpty){
                      return Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.swipe_left_outlined,
                                color: HexColor('#A0AEC0'),),
                              const SizedBox(width: 5,),
                              Text(
                                tr('swipe'),
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                          ),
                          ListView.separated(
                            itemBuilder: (context, index) =>
                              CartItem(model:cubit.getCartModel!.data![index]),
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 15,),
                            itemCount: cubit.getCartModel!.data!.length,
                            shrinkWrap: true,
                            physics:const NeverScrollableScrollPhysics(),
                          ),
                          const SizedBox(height: 20,),
                          defaultButton(onTap: () {
                            if(token != null)
                            {
                              CartCubit.get(context).getCheckOut();
                              AddressCubit.get(context).getAddress();
                              navigateTo(context, CheckOutScreen());
                            }else{
                              navigateTo(context, SignInScreen());
                            }

                          }, text: tr('checkout'))
                        ],
                      );
                    }else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 150,),
                          SizedBox(
                            height: 150,
                              width: 150,
                              child: Image.asset(BuyerImages.logo)),
                          Text(tr('no_items')),
                        ],
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
