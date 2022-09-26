import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/layout/buyer_layout/cubit/buyer_cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../shared/firebase_helper/dynamic_links.dart';
import '../../buyer/auth/sign_in/sign_in_screen.dart';
import '../../vendor/auth/vendor_sign_in_screen.dart';


class SelectType extends StatelessWidget {
  const SelectType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DynamicLinksClient.initDynamicLinks((String? value)
    {
      if(value!=null){
        BuyerCubit.get(context).getProduct(id: int.parse(value));
      }
    });

    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.bottomCenter,
        child: Container(
          height: size!.height*.16,
          color: defaultColorTwo,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
              Text(
                tr('select_type'),
                style: const TextStyle(color: defaultColor,fontWeight: FontWeight.bold),),
              Padding(
                padding:  EdgeInsetsDirectional.all(size!.height* .019),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    defaultButton(
                        onTap: (){
                          navigateTo(context,  SignInScreen());
                        },
                        text: tr('buyer')
                    ),
                    SizedBox(width: size!.height* .013,),
                    defaultButton(
                      onTap: (){
                        navigateTo(context,  VSignInScreen());
                      },
                      text: tr('vendor'),
                      textColor: defaultColor,
                      buttonColor: defaultColorTwo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
