import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_cubit.dart';
import 'package:soldout/modules/buyer/screens/cart/cart_cubit/cart_states.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'package:soldout/modules/buyer/widgets/check_out/delivery_address.dart';
import 'package:soldout/modules/buyer/widgets/check_out/discount.dart';
import 'package:soldout/modules/buyer/widgets/check_out/invoice.dart';
import 'package:soldout/modules/widgets/loadings/purchases_loading/purchases_loading.dart';
import 'package:soldout/shared/components/components.dart';
import '../../widgets/check_out/list_store.dart';
import '../../widgets/check_out/radio.dart';
import '../../../widgets/my_container.dart';
import '../settings/setting_screens/my_account/addresses/address_cubit/state.dart';

class CheckOutScreen extends StatelessWidget {
  CustomRadio customRadio = CustomRadio(
    radioValue: 0,
  );
  late DeliveryAddress deliveryAddress;
  DiscountWidget  discountWidget = DiscountWidget(true);

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
                lastButtonTap: () {}),
            MyContainer(
              end: 0,
              start: 0,
              noSize: true,
              BlocConsumer<CartCubit, CartStates>(
                listener: (context, state2) {},
                builder: (context, state2) {
                  var cubit = CartCubit.get(context);
                  return BlocConsumer<AddressCubit, AddressStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      var addressCubit = AddressCubit.get(context);
                      return ConditionalBuilder(
                          condition: cubit.getCheckOutModel != null &&
                              addressCubit.getAddressModel != null,
                          fallback: (context) => PurchasesDetailsLoading(),
                          builder: (context) {
                            deliveryAddress = DeliveryAddress(
                              getAddressModel: addressCubit.getAddressModel,
                              addressId:
                                  addressCubit.getAddressModel!.data![0].id,
                            );
                            return Column(
                              children: [
                                ListStore(),
                                select(tr('select_payment_method')),
                                customRadio,
                                select(tr('select_delivery_address')),
                                deliveryAddress,
                                select(tr('have_discount')),
                                state is! CheckCouponLoadingState
                                    ? discountWidget
                                    : const LinearProgressIndicator(),
                                if (cubit.discountModel == null)
                                  InvoiceWidget(
                                    isBuyPoints: false,
                                    subTotal:
                                        cubit.getCheckOutModel!.data!.subTotal!,
                                    shippingCharges: cubit.getCheckOutModel!
                                        .data!.totalShippingCharges!,
                                    orderTotal: cubit.getCheckOutModel!.data!
                                        .totalCartPrice!,
                                  ),
                                if (cubit.discountModel != null)
                                  InvoiceWidget(
                                    isBuyPoints: false,
                                    subTotal:
                                        cubit.discountModel!.data!.subTotal!,
                                    shippingCharges: cubit.discountModel!.data!
                                        .totalShippingCharges!,
                                    orderTotal: cubit
                                        .discountModel!.data!.totalCartPrice!,
                                  ),
                                state2 is! CheckOutLoadingState
                                    ? defaultButton(
                                        onTap: () => submit(context),
                                        text: tr('pay_now'))
                                    : const CircularProgressIndicator(),
                              ],
                            );
                          });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    if (deliveryAddress.addressId != null
        || deliveryAddress.addressController.text.isNotEmpty
            && deliveryAddress.cityDropDownIndex != null
            && deliveryAddress.neighborhoodsDropDownIndex != null
    ) {
      CartCubit.get(context).checkOut(
          context: context,
          payMethod: customRadio.radioValue,
          neighborhoodId: deliveryAddress.neighborhoodsDropDownIndex,
          cityId: deliveryAddress.cityDropDownIndex,
          address: deliveryAddress.addressController.text,
          couponCode: discountWidget.couponController.text,
          userAddressId: deliveryAddress.addressId);
    } else {
      showToast(msg: tr('select_address'));
    }
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
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
