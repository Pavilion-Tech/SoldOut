import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class ContactUsWidget extends StatelessWidget {

  TextEditingController nameC = TextEditingController();
  TextEditingController emilC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController subjectC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    defaultTextField(
                      controller: nameC,
                      hint: tr('full_name'),
                      validator: (value){
                        if(value!.isEmpty)tr('name_empty');

                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: defaultTextField(
                          controller: emilC,
                          hint: tr('email_address_one'),
                          type: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty)tr('email_empty');
                          }
                      ),
                    ),
                    defaultTextField(
                        controller: phoneC,
                        hint: tr('phone'),
                        type: TextInputType.phone,
                        validator: (value){
                          if(value!.isEmpty)tr('phone_empty');
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: defaultTextField(
                          controller: subjectC,
                          validator: (value){
                            if(value!.isEmpty)tr('subject_empty');
                          },
                          hint: tr('subject')),
                    ),
                    Container(
                      height: size!.height * .15,
                      decoration: BoxDecoration(
                        color: defaultColorTwo,
                        borderRadius: BorderRadiusDirectional.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      alignment: AlignmentDirectional.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: TextFormField(
                        controller: messageC,
                        validator:  (value){
                          if(value!.isEmpty)tr('message_empty');

                          },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: tr('message'),
                          hintStyle: const TextStyle(
                              color: Colors.grey, fontSize: 13, height: 5),
                        ),
                        maxLines: 5,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 15, bottom: 50),
                      child:state is! ContactUsLoadingState ?  defaultButton(
                          onTap: () {
                            if(formKey.currentState!.validate()){
                              SettingsCubit.get(context).contactUs(
                                  name: nameC.text,
                                  email: emilC.text,
                                  phone: phoneC.text,
                                  subject: subjectC.text,
                                  message: messageC.text
                              );
                            }
                          },
                          text: tr('send')
                      ):const CircularProgressIndicator(),
                    ),
                    Text(
                      tr('or_contact_us'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: defaultColorTwo,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialIcon(BuyerImages.gmail),
                    socialIcon(BuyerImages.instagram),
                    socialIcon(BuyerImages.fb),
                    socialIcon(BuyerImages.phone),
                    socialIcon(BuyerImages.twitter),
                    socialIcon(BuyerImages.whatsapp),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget socialIcon(String path)
  {
    return SizedBox(
      height: 50,
      width: 50,
      child: Image.asset(
        path,
        height: 50,
        width: 50,
      ),
    );
  }
}
