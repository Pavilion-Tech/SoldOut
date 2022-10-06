import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../models/buyer_model/product_model/product_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../widgets/loadings/edit_loading/edit_loading.dart';
import '../manage_product_widgets/delet_dialog.dart';

class AddOrEditProductWidget extends StatelessWidget {
  AddOrEditProductWidget({required this.isEdit, this.productModel});

  var formKey = GlobalKey<FormState>();

  bool isEdit;

  ProductModel? productModel;

  int isCompleted = 0;

  @override
  Widget build(BuildContext context) {
    var cubit = VendorCubit.get(context);
    if (productModel != null &&
        productModel!.images!.length != cubit.imagesId.length &&
        isCompleted == 0) {
      cubit.nameC.text = productModel!.name!;
      cubit.descC.text = productModel!.desc!;
      cubit.descC.text = productModel!.desc!;
      cubit.dropDownId = productModel!.categoryId;
      cubit.qnt.text = productModel!.stock!.toString();
      cubit.weight.text = productModel!.weight!.toString();
      cubit.price.text = productModel!.regularPrice!.toString();
      cubit.priceAfterDiscount.text = productModel!.salePrice!.toString();

      for (var cate
          in SettingsCubit.get(context).settingsModel!.data!.categories!) {
        if (cate.id == productModel!.categoryId) {
          cubit.dropDownValue = cate.name;
        }
      }
      for (var image in productModel!.images!) {
        cubit.addImageToList(image.image!);
        cubit.imagesId.add(image.id!);
      }
      isCompleted++;
    }
    return BlocConsumer<VendorCubit, VendorStates>(
      listener: (context, state) {
        if (isEdit) {
          if (state is ProductSuccessState) {
            productModel = null;
            Navigator.pop(context);
          }
        }
      },
      builder: (context, state) {
        var cubit = VendorCubit.get(context);
        return ConditionalBuilder(
          condition: productModel !=null ? cubit.imageFileList.isNotEmpty:true,
          fallback: (context) => const EditLoading(),
          builder: (context) => Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr('determine'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 5,),
                Text(
                  tr('indicates'),
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15,),
                defaultTextField(
                  controller: cubit.nameC,
                  hint: tr('product_name'),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(48),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return tr('product_empty');
                    }
                  },
                  onChanged: (value) => formKey.currentState!.validate(),
                ),
                const SizedBox(height: 15,),
                Container(
                  height: size!.height * .2,
                  decoration: BoxDecoration(
                    color: defaultColorTwo,
                    borderRadius: BorderRadiusDirectional.circular(15),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  alignment: AlignmentDirectional.center,
                  padding:const EdgeInsets.symmetric(vertical:10,horizontal:15),
                  child: TextFormField(
                      onChanged: (value) => formKey.currentState!.validate(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: tr('Description'),
                        hintStyle: TextStyle(
                            color: HexColor('#A0AEC0'),
                            fontSize: 16,
                            height: 2),
                      ),
                      maxLines: 5,
                      controller: cubit.descC,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return tr('description_empty');
                        }
                      }),
                ),
                const SizedBox(height: 15,),
                Stack(children: [
                  Container(
                    height: size!.height * .06,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: defaultColorTwo,
                      borderRadius: BorderRadiusDirectional.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                  ),
                  if (SettingsCubit.get(context).settingsModel != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 15
                      ),
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        validator:(value)=>value==null?tr('field_required'):null,
                        decoration:const InputDecoration(border:InputBorder.none),
                        borderRadius:BorderRadius.circular(10),
                        value:cubit.dropDownValue,
                        icon:const Icon(Icons.keyboard_arrow_down),
                        items:SettingsCubit.get(context).settingsModel!.data!.categories!.map((items) {
                          return DropdownMenuItem(
                            value: items.name,
                            child: SizedBox(
                                height: 60, width: double.infinity,
                                child: Text(items.name!,style: TextStyle(fontSize: 13),)
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          formKey.currentState!.validate();
                          cubit.dropDownValue = newValue;
                          for (var cate in SettingsCubit.get(context)
                              .settingsModel!.data!.categories!) {
                            if (newValue == cate.name) {
                              cubit.dropDownId = cate.id;
                            }
                          }
                        },
                        hint: Text(
                          tr('choose_cate'),
                          style: TextStyle(color: HexColor('#A0AEC0')),
                        ),
                      ),
                    ),
                ]),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: defaultTextField(
                          type: TextInputType.number,
                          controller: cubit.qnt,
                          onChanged:(value)=>formKey.currentState!.validate(),
                          hint: tr('quantity'),
                          validator: (value){
                            if (value!.isEmpty) {
                              return tr('field_required');
                            }
                          }),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: defaultTextField(
                          type: TextInputType.number,
                          controller: cubit.weight,
                          onChanged:(value)=>formKey.currentState!.validate(),
                          hint: tr('weight'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return tr('field_required');
                            }
                          }),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Expanded(
                      child: defaultTextField(
                          type: TextInputType.number,
                          controller: cubit.price,
                          onChanged:(value)=>formKey.currentState!.validate(),
                          hint: tr('price'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return tr('field_required');
                            }
                          }),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: defaultTextField(
                          type: TextInputType.number,
                          controller: cubit.priceAfterDiscount,
                          hint: tr('price_after_discount'),
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 15,),
                InkWell(
                  onTap: ()=>cubit.selectImages(),
                  child: Container(
                    height: size!.height * .06,
                    decoration: BoxDecoration(
                      color: defaultColorTwo,
                      borderRadius: BorderRadiusDirectional.circular(15),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    alignment: AlignmentDirectional.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo, color: HexColor('#A0AEC0'),),
                        const SizedBox(width: 10,),
                        Text(
                          tr('upload_image'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                if (cubit.imageFileList.isNotEmpty)
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: GridView.builder(
                        itemCount: cubit.imageFileList.length,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Image.file(
                                  File(cubit.imageFileList[index].path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.imageFileList
                                          .remove(cubit.imageFileList[index]);
                                      if (cubit.imagesId.isNotEmpty
                                      &&cubit.imagesId.any((element)=>element==index)){
                                        cubit.imagesId
                                            .remove(cubit.imagesId[index]);
                                      }
                                      cubit.justEmit();
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ]);
                        }),
                  ),
                const SizedBox(height: 15,),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: state is! ProductLoadingState
                      ? defaultButton(
                          text: isEdit ? tr('edit_product') : tr('add_product'),
                          onTap: () => submit(cubit),
                        )
                      : const CircularProgressIndicator(),
                ),
                if (isEdit)
                  const SizedBox(height: 15,),
                if (isEdit)
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DeletDialog(
                                  id: productModel!.id!,
                                );
                              });
                        },
                        child: Text(
                          tr('delete_product'),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      )),
              ],
            ),
          ),
        );
      },
    );
  }

  void submit(VendorCubit cubit) {
    if (formKey.currentState!.validate()) {
      if (cubit.imageFileList.isNotEmpty) {
        if (isEdit) {
          cubit.product(
            isEdit: true,
            productId: productModel!.id,
            cateId: cubit.dropDownId,
          );
        } else {
          cubit.product(
            isEdit: false,
            cateId: cubit.dropDownId,
          );
        }
      } else {
        showToast(msg: tr('images_required'), toastState: true);
      }
    }
  }
}
