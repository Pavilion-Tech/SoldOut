import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_states.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_screen.dart';
import 'package:soldout/modules/buyer/widgets/check_out/delivery_address.dart';
import 'package:soldout/modules/buyer/widgets/check_out/discount.dart';
import 'package:soldout/modules/buyer/widgets/check_out/invoice.dart';
import 'package:soldout/modules/widgets/loadings/purchases_loading/purchases_loading.dart';
import 'package:soldout/shared/components/components.dart';
import '../../widgets/check_out/dialog.dart';
import '../../widgets/check_out/list_stoe.dart';
import '../../widgets/check_out/radio.dart';
import '../../../widgets/my_container.dart';

class CheckOutScreen extends StatelessWidget {


  CustomRadio customRadio = CustomRadio(radioValue: 1,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
                context: context,
                title: tr('checkout'),
                isLastIcon: true,
                lastIcon: Icons.shopping_cart,
                isArrowBack: true,
                lastButtonTap: () {}
            ),
            MyContainer(
              end: 0,
              start: 0,
              noSize: true,
              BlocConsumer<CartCubit, CartStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = CartCubit.get(context);
                  return ConditionalBuilder(
                    condition: cubit.getCheckOutModel != null,
                    fallback: (context)=> PurchasesDetailsLoading(),
                    builder:(context)=>  Column(
                      children: [
                        ListStore(),
                        select(tr('select_payment_method')),
                        customRadio,
                        select(tr('select_delivery_address')),
                        const DeliveryAddress(),
                        select(tr('have_discount')),
                        const DiscountWidget(),
                        InvoiceWidget(
                          isBuyPoints: false,
                          subTotal: cubit.getCheckOutModel!.data!.subTotal!,
                          shippingCharges: cubit.getCheckOutModel!.data!.totalShippingCharges!,
                          orderTotal: cubit.getCheckOutModel!.data!.totalCartPrice!,
                        ),
                        defaultButton(onTap: () {
                          print(customRadio.radioValue);
                          // showDialog(
                          //     context: context,
                          //     builder: (context)=>CheckOutDialog()
                          // );
                        }, text: tr('pay_now')),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget select(String text) {
    return Container(
      width: double.infinity,
      height: 45,
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsetsDirectional.only(start: 20),
      color: Colors.blue.shade100.withOpacity(.4),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),),
    );
  }

}



