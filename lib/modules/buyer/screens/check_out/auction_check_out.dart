import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/state.dart';
import 'package:soldout/modules/buyer/widgets/check_out/delivery_address.dart';
import 'package:soldout/modules/buyer/widgets/check_out/discount.dart';
import 'package:soldout/modules/buyer/widgets/check_out/invoice.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../widgets/loadings/purchases_loading/purchases_loading.dart';
import '../../widgets/auction/auction_checkout_item.dart';
import '../../widgets/check_out/radio.dart';
import '../../../widgets/my_container.dart';
import '../auction/auction_cubit/auction_states.dart';
import '../settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';

class AuctionCheckOutScreen extends StatelessWidget {
  CustomRadio customRadio = CustomRadio(
    radioValue: 0,
  );

  late DeliveryAddress deliveryAddress;
  DiscountWidget discountWidget = DiscountWidget(false);

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
                BlocConsumer<AddressCubit, AddressStates>(
                  listener: (context, state1) {},
                  builder: (context, state1) {
                    var cubit = AddressCubit.get(context);
                    return BlocConsumer<AuctionCubit, AuctionStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        var cubit2 = AuctionCubit.get(context);
                        return ConditionalBuilder(
                          condition: cubit.getAddressModel != null &&
                              cubit2.checkOutAuctionModel != null,
                          fallback: (context) => PurchasesDetailsLoading(),
                          builder: (context) {
                            deliveryAddress = DeliveryAddress(
                              getAddressModel: cubit.getAddressModel,
                              addressId: cubit.getAddressModel!.data![0].id,
                            );
                            return Column(
                              children: [
                                AuctionCheckOutItem(
                                    cubit2.checkOutAuctionModel!.data!.productName!,
                                    cubit2.checkOutAuctionModel!.data!.auctionName!,
                                    cubit2.checkOutAuctionModel!.data!.firstImage!,
                                ),
                                select(tr('select_delivery_address')),
                                deliveryAddress,
                                select(tr('have_discount')),
                                discountWidget,
                                InvoiceWidget(
                                    subTotal: cubit2
                                        .checkOutAuctionModel!.data!.subTotal,
                                    shippingCharges: cubit2
                                        .checkOutAuctionModel!
                                        .data!
                                        .shippingCharges,
                                    orderTotal: cubit2
                                        .checkOutAuctionModel!.data!.totalPrice,
                                    isBuyPoints: false),
                                state is! CheckOutAuctionLoading
                                    ? defaultButton(
                                        onTap: ()=>submit(context),
                                        text: tr('pay_now'))
                                    : const CircularProgressIndicator(),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    if (deliveryAddress.addressId != null ||
        deliveryAddress.addressController.text.isNotEmpty &&
            deliveryAddress.cityDropDownIndex != null &&
            deliveryAddress.neighborhoodsDropDownIndex != null) {
      AuctionCubit.get(context).checkOut(
          neighborhoodId: deliveryAddress.neighborhoodsDropDownIndex,
          cityId: deliveryAddress.cityDropDownIndex,
          address: deliveryAddress.addressController.text,
          couponCode: discountWidget.couponController.text,
          userAddressId: deliveryAddress.addressId,
          context: context);
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
