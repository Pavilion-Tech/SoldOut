import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/components/constants.dart';
import '../../../widgets/my_container.dart';

class VEditProfile extends StatelessWidget {


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            myAppBar(
              context: context,
              title: tr('edit_profile'),
              isArrowBack: true,

            ),
            BlocConsumer<VSettingCubit, VSettingStates>(
              listener: (context, state) {
                if(isConnect!=null)checkNet(context);
                if(state is UpdateProfileSuccessState)Navigator.pop(context);
              },
              builder: (context, state) {
                var cubit = VSettingCubit.get(context);
                return MyContainer(
                  ConditionalBuilder(
                    condition: state is! GetProfileLoadingState,
                    fallback: (context)=>Column(
                      children: [
                        SizedBox(height: size!.height*.4,),
                        const CircularProgressIndicator(),
                      ],
                    ),
                    builder: (context)=> Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultTextField(
                            controller: cubit.nameC,
                            hint: tr('store_name'),
                            validator: (value){
                              if(value!.isEmpty){
                                return tr('store_empty');
                              }
                            }
                          ),
                          const SizedBox(height: 15,),
                          defaultTextField(
                              controller: cubit.phoneC,
                              hint: tr('phone'),
                              type: TextInputType.phone,
                              readOnly: true
                          ),
                          const SizedBox(height: 15,),
                          defaultTextField(
                              controller:cubit.emailC,
                              hint: tr('email_address_two'),
                              readOnly: true
                          ),
                          const SizedBox(height: 15,),
                          defaultTextField(
                              controller: cubit.attachC,
                              hint: tr('attach_register'),
                              readOnly: true,
                              onTap: () {
                                cubit.selectFile();
                              }
                          ),
                          if(cubit.file!=null)
                            SizedBox(
                              height: size!.height * .01,
                            ),
                          if(cubit.file!=null)
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Image.file(
                                File(cubit.file!.path),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (c,o,s)=>const Icon(Icons.info),
                              ),
                            ),
                          if(cubit.file==null)
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: Image.network(
                                cubit.image!,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (c,o,s)=>const Icon(Icons.info),
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 15,),
                          state is! UpdateProfileLoadingState
                          ?defaultButton(
                              onTap: () {
                                if(formKey.currentState!.validate()){
                                  cubit.updateProfile();
                                }
                              },
                              text: tr('save')
                          ):const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  noSize: size!.height > 600 ?false:true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}