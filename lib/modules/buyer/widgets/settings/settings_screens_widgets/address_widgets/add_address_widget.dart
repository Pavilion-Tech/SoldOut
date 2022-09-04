import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/state.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';

import '../../../../../../layout/buyer_layout/cubit/buyer_states.dart';
import '../../../../../../models/buyer_model/settings_model.dart';
import '../../../../../../shared/components/constants.dart';

class AddAddressWidget extends StatefulWidget {
  AddAddressWidget({Key? key,this.isEdit = false,this.addressId}) : super(key: key);

  bool isEdit;
  int? addressId;

  @override
  State<AddAddressWidget> createState() => _AddAddressWidgetState();
}

class _AddAddressWidgetState extends State<AddAddressWidget> {


  String? cityDropDownValue;
  String? neighborhoodsDropDownValue;
  int? cityDropDownIndex;
  int? neighborhoodsDropDownIndex;
  List<Neighborhoods>? neighborhoods;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  var formKey = GlobalKey<FormState>();


  TextEditingController addressTitleController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            defaultTextField(
              controller: addressTitleController,
              hint: tr('address_title'),
              validator: (value) {
                if(value!.isEmpty){
                  return ' Address Title Must Be Empty';
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            defaultTextField(
              controller: addressController,
              hint: tr('address'),
              validator: (value) {
                if(value!.isEmpty){
                  return ' Address Must Be Empty';
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<BuyerCubit, BuyerStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = BuyerCubit.get(context);
                return Column(
                  children: [
                    dropDown(
                      title: 'city',
                      focusNode: focusNode,
                      value: cityDropDownValue,
                      list: cubit.settingsModel!.data!.cities!,
                      isCity: true
                    ),
                    const SizedBox(height: 20,),
                    if(neighborhoods != null)
                      dropDown(
                        title: 'city',
                        focusNode: focusNode2,
                        value: neighborhoodsDropDownValue,
                        list: neighborhoods!,
                        isCity: false
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20,),
            BlocConsumer<AddressCubit, AddressStates>(
              listener: (context, state) {
                if(state is AddAddressSuccessState)Navigator.pop(context);
              },
              builder: (context, state) {
                var cubit = AddressCubit.get(context);
                return state is AddAddressLoadingState
                ? const CircularProgressIndicator()
                : defaultButton(
                  onTap:()=>submit(cubit),
                  text: tr('save'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDown({
  required FocusNode focusNode,
  required List<dynamic> list,
  required String title,
  required bool isCity,
  String? value,
}){
    return Stack(
      children: [
        Container(
          height: size!.height * .06,
          width: double.infinity,
          decoration: BoxDecoration(
            color: defaultColorTwo,
            borderRadius: BorderRadiusDirectional.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 3, horizontal: 15),
          child: DropdownButtonFormField(
            isExpanded: true,
            focusNode: focusNode,
            validator: (value) => value == null ? 'field required' : null,
            decoration:const InputDecoration(
                border: InputBorder.none
            ),
            borderRadius: BorderRadius.circular(10),
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: list.map((items) {
              return DropdownMenuItem(
                value: items.name,
                child: InkWell(
                  onTap: () {
                    if(isCity){
                      setState(() {
                        neighborhoodsDropDownValue = null;
                        cityDropDownValue = items.name;
                        neighborhoods = items.neighborhoods!;
                        cityDropDownIndex = items.id;
                        if (!focusNode.hasFocus) Navigator.pop(context);
                      });
                    }else{
                      setState(() {
                        neighborhoodsDropDownValue = items.name;
                        neighborhoodsDropDownIndex = items.id;
                        if (!focusNode2.hasFocus) Navigator.pop(context);
                      });
                    }
                  },
                  child: SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Text(items.name!)
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                value = newValue as String;
              });
            },
            hint: Text(
              tr(title),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }


  void submit(AddressCubit cubit){
    if(formKey.currentState!.validate()){
      if(widget.isEdit){
        cubit.editAddress(
            addressId: widget.addressId!,
            title: addressTitleController.text.trim(),
            address: addressController.text.trim(),
            cityId: cityDropDownIndex!,
            neighborhoodId: neighborhoodsDropDownIndex!
        );
        cubit.getAddress();
        Navigator.pop(context);
      }else{
        cubit.addAddress(
            title: addressTitleController.text.trim(),
            address: addressController.text.trim(),
            cityId: cityDropDownIndex!,
            neighborhoodId: neighborhoodsDropDownIndex!
        );
        Navigator.pop(context);
      }
    }
  }
}
