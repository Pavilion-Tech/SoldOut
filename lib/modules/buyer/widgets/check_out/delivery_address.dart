import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/models/buyer_model/get_address_model.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../models/buyer_model/settings_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';

class DeliveryAddress extends StatefulWidget {

    DeliveryAddress({this.getAddressModel,this.addressId});

  GetAddressModel? getAddressModel;
  int? cityDropDownIndex;
  int? neighborhoodsDropDownIndex;
  int? addressId;
  TextEditingController addressController = TextEditingController();

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  String? cityDropDownValue;
  String? neighborhoodsDropDownValue;
  List<Neighborhoods>? neighborhoods;
  FocusNode focusNode = FocusNode();
  FocusNode focusNode2 = FocusNode();
  var formKey = GlobalKey<FormState>();
  int? currentAddress = 0;


  int otherIndex = -1;

  @override
  void initState() {
    if(widget.getAddressModel!.data!.isEmpty)
    {
      currentAddress = otherIndex;
    }else
      {
        int id = widget.getAddressModel!.data![0].id!;
        widget.addressId =  id;
        currentAddress = id;
      }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Column(
        children: [
          ListView.separated(
            itemBuilder: (context, index) =>
                address(widget.getAddressModel!.data![index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: widget.getAddressModel!.data!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
          const SizedBox(
            height: 10,
          ),
          otherAddress(),
        ],
      ),
    );
  }

  Widget address(GetAddressData model) {
    return InkWell(
      onTap: () {
        setState(() {
          currentAddress = model.id!;
          widget.addressId = model.id!;
        });
      },
      child: Container(
        height: size!.height > 670?size!.height*.09:size!.height*.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10),
          border: Border.all(
            color: currentAddress == model.id!
                ? Colors.blue
                : Colors.grey.shade300.withOpacity(.5),
          ),
          color:
          currentAddress == model.id! ? Colors.blue.withOpacity(.5) : null,
        ),
        padding: const EdgeInsetsDirectional.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  model.address!,
                  style:const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (currentAddress == model.id!) const Spacer(),
                if (currentAddress == model.id!)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.blue,
                  ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                    width: size!.height > 670?size!.width*.75:size!.width*.65,
                    height: size!.height * .015,
                    child: Text(
                      model.fullAddress!,
                      style: const TextStyle(fontSize: 13, height: .9),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget otherAddress() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              currentAddress = otherIndex;
              widget.addressId = null;
            });
          },
          child: Column(
            children: [
              Container(
                height: size!.height * .07,
                alignment: AlignmentDirectional.centerStart,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  border: Border.all(
                    color: currentAddress == otherIndex
                        ? Colors.blue
                        : Colors.grey.shade300.withOpacity(.5),
                  ),
                  color: currentAddress == otherIndex
                      ? Colors.blue.withOpacity(.5)
                      : null,
                ),
                padding: const EdgeInsetsDirectional.all(10),
                child: Row(
                  children: [
                    Text(
                      tr('other'),
                      style:const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (currentAddress == otherIndex)const Spacer(),
                    if (currentAddress == otherIndex)
                     const Icon(Icons.check_circle, color: Colors.blue,),
                  ],
                ),
              ),
              if (currentAddress == otherIndex)
                Column(
                  children: [
                    const SizedBox(height: 10,),
                    defaultTextField(
                      controller: widget.addressController,
                      hint: tr('address1'),
                    ),
                    const SizedBox(height: 10,),
                    dropDown(
                        title: tr('city'),
                        value: cityDropDownValue,
                        list: SettingsCubit.get(context)
                            .settingsModel!
                            .data!
                            .cities!,
                        isCity: true
                    ),
                    const SizedBox(height: 20,),
                    if (neighborhoods != null)
                      dropDown(
                          title: tr('neighborhood'),
                          value: neighborhoodsDropDownValue,
                          list: neighborhoods!,
                          isCity: false),
                  ],
                ),
            ],
          ),
        ),
      ],
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
          height: size!.height > 670?size!.height*.06:size!.height*.09,
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
                    widget.cityDropDownIndex = city.id;
                    setState(() {});
                  }
                }
              }
              else
              {
                for(var city in SettingsCubit.get(context).settingsModel!.data!.cities![widget.cityDropDownIndex! - 1].neighborhoods!)
                {
                  if(city.name== newValue){
                    neighborhoodsDropDownValue = newValue as String;
                    widget.neighborhoodsDropDownIndex = city.id;
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
}
