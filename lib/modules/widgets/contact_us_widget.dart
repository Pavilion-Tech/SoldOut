import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_cubit.dart';
import 'package:soldout/modules/buyer/screens/settings/settings_cubit/settings_states.dart';
import 'package:soldout/modules/vendor/screens/settings/vendor_setting_cubit/vendor_setting_cubit.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';
import '../buyer/auth/auth_cubit/auth_cubit.dart';

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
    if(VSettingCubit.get(context).nameC.text.isNotEmpty){
      nameC.text = VSettingCubit.get(context).nameC.text;
      emilC.text = VSettingCubit.get(context).emailC.text;
      phoneC.text = VSettingCubit.get(context).phoneC.text;
    }else if (AuthCubit.get(context).getProfileModel!=null){
      nameC.text = AuthCubit.get(context).getProfileModel!.data!.name??'';
      phoneC.text = AuthCubit.get(context).getProfileModel!.data!.phone??'';
    }
    return BlocConsumer<SettingsCubit, SettingsStates>(
      listener: (context, state) {
        if(state is ContactUsSuccessState){
          messageC.text = '';
          subjectC.text = '';
        }
      },
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
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
                        if(value!.isEmpty)
                        {
                          return tr('name_empty');
                        }

                      }
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: defaultTextField(
                          controller: emilC,
                          hint: tr('email_address_one'),
                          type: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                              return tr('email_empty');
                            }
                          }
                      ),
                    ),
                    defaultTextField(
                        controller: phoneC,
                        hint: tr('phone'),
                        type: TextInputType.phone,
                        validator: (value){
                          if(value!.isEmpty)
                          {
                            return tr('phone_empty');
                          }
                        }
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: defaultTextField(
                          controller: subjectC,
                          validator: (value){
                            if(value!.isEmpty)
                            {
                             return tr('subject_empty');
                            }
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
                          if(value!.isEmpty)
                          {
                            return tr('message_empty');
                          }
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
                      padding:const EdgeInsetsDirectional.only(top:15,bottom:50),
                      child:state is! ContactUsLoadingState ?  defaultButton(
                          onTap: () {
                            if(formKey.currentState!.validate()){
                              cubit.contactUs(
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
              if(cubit.settingsModel!=null)
              Container(
                height: 60,
                width: double.infinity,
                color: defaultColorTwo,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: (){
                          final Uri params = Uri(
                            scheme: 'mailto',
                            path: cubit.settingsModel!.data!.email!,
                          );
                          final url = params.toString();
                          launch(url);
                        },
                        child: socialIcon(BuyerImages.gmail)),
                    InkWell(
                        onTap: ()=> openUrl(cubit.settingsModel!.data!.instagram!),
                        child: socialIcon(BuyerImages.instagram)),
                    InkWell(
                        onTap: ()=> openUrl(cubit.settingsModel!.data!.facebook!),
                        child: socialIcon(BuyerImages.fb)),
                    InkWell(
                        onTap: ()async{
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: cubit.settingsModel!.data!.phone!,
                          );
                          print(launchUri);
                          if (await canLaunch(launchUri.toString())) {
                            await launch(launchUri.toString());
                          } else {
                            print('we have error' + launchUri.toString());
                          }
                        },
                        child: socialIcon(BuyerImages.phone)),
                    InkWell(
                        onTap: ()=> openUrl(cubit.settingsModel!.data!.twitter!),
                        child: socialIcon(BuyerImages.twitter)),
                    InkWell(
                        onTap: (){
                          String url() {
                            if (Platform.isAndroid) {
                              return "https://wa.me/${cubit.settingsModel!.data!.whatsapp}/?text=hello"; // new line
                            } else {
                              return "https://api.whatsapp.com/send?phone=${cubit.settingsModel!.data!.whatsapp}"; // new line
                            }
                          }
                          String waUrl = url();
                          openUrl(waUrl);
                        },
                        child: socialIcon(BuyerImages.whatsapp)),
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
