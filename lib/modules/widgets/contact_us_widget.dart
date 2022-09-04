import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/colors.dart';

class ContactUsWidget extends StatelessWidget {
  const ContactUsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              defaultTextField(
                  controller: TextEditingController(),
                  hint: tr('full_name'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: defaultTextField(
                    controller: TextEditingController(),
                    hint: tr('email_address_one')
                ),
              ),
              defaultTextField(
                  controller: TextEditingController(),
                  hint: tr('phone')
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: defaultTextField(
                    controller: TextEditingController(),
                    hint: tr('subject')
                ),
              ),
              Container(
                height: size!.height*.15,
                decoration: BoxDecoration(
                  color: defaultColorTwo,
                  borderRadius: BorderRadiusDirectional.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                alignment: AlignmentDirectional.center,
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                child: TextFormField(
                  decoration:  InputDecoration(
                    border: InputBorder.none,
                    hintText:tr('message'),
                    hintStyle:const TextStyle(color: Colors.grey,fontSize: 13,height: 5),
                  ),
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15,bottom: 50),
                child: defaultButton(onTap: (){}, text: tr('send')),
              ),
              Text(
                tr('or_contact_us'),
                style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
              SizedBox(height: 15,),
            ],
          ),
        ),
        Container(
          height: 60,
          width: double.infinity,
          color: defaultColorTwo,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(BuyerImages.gmail,height: 50,width: 50,),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(BuyerImages.instagram,height: 50,width: 50,),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(BuyerImages.fb,height: 50,width: 50,),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(BuyerImages.phone,height: 50,width: 50,),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(BuyerImages.twitter,height: 50,width: 50,),
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(BuyerImages.whatsapp,height: 50,width: 50,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
