import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/setting_screens/my_account/addresses/address_cubit/state.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../../../../../models/buyer_model/settings_model.dart';
import '../../../../../../shared/components/constants.dart';
import '../../../../screens/settings/settings_cubit/settings_cubit.dart';

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
                  return tr('address_title_empty');
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
                  return tr('address_empty');
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<SettingsCubit, SettingsStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var cubit = SettingsCubit.get(context);
                return Column(
                  children: [
                    dropDown(
                        isCity: true,
                        list: cubit.settingsModel!.data!.cities!,
                        value: cityDropDownValue,
                        title: tr('city')
                    ),
                    const SizedBox(height: 20,),
                    if(neighborhoods != null)
                      dropDown(
                          isCity: false,
                          list: neighborhoods!,
                          value: neighborhoodsDropDownValue,
                          title: tr('neighborhood')
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
    required List<dynamic> list,
    required String title,
    required bool isCity,
    String? value,
  }) {
    return Stack(
      children: [
        Container(
          height: size!.height > 670 ?  size!.height * .06:size!.height * .1,
          width: double.infinity,
          decoration: BoxDecoration(
            color: defaultColorTwo,
            borderRadius: BorderRadiusDirectional.circular(15),
            border: Border.all(color: Colors.grey.shade200),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          child: DropdownButtonFormField(
            isExpanded: true,
            validator: (value) => value == null ? tr('field_required') : null,
            decoration: const InputDecoration(border: InputBorder.none),
            borderRadius: BorderRadius.circular(10),
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: list.map((items) {
              return DropdownMenuItem(
                value: items.name,
                child: Text(items.name!),
              );
            }).toList(),
            onChanged: (newValue) {
              if(isCity)
              {
                neighborhoodsDropDownValue = null;
                neighborhoods = null;
                for(var city in SettingsCubit.get(context).settingsModel!.data!.cities!)
                {
                  if(city.name== newValue){
                    cityDropDownValue = city.name;
                    neighborhoods = city.neighborhoods!;
                    cityDropDownIndex = city.id;
                    setState(() {});
                  }
                }
              }
              else
              {
                for(var city in SettingsCubit.get(context).settingsModel!.data!.cities![cityDropDownIndex! - 1].neighborhoods!)
                {
                  if(city.name== newValue){
                    neighborhoodsDropDownValue = newValue as String;
                    neighborhoodsDropDownIndex = city.id;
                    setState(() {});
                  }
                }
              }

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
            title: addressTitleController.text,
            address: addressController.text,
            cityId: cityDropDownIndex!,
            neighborhoodId: neighborhoodsDropDownIndex!,

        );
        cubit.getAddress();
      }else{
        cubit.addAddress(
            title: addressTitleController.text,
            address: addressController.text,
            cityId: cityDropDownIndex!,
            neighborhoodId: neighborhoodsDropDownIndex!
        );
        Navigator.pop(context);
      }
    }
  }
}
