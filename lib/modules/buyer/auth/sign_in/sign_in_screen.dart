import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../sign_up/sign_up_screen.dart';
import '../../../widgets/sign_widget.dart';
import '../verification/verification_scren.dart';

class SignInScreen extends StatelessWidget {


  SignInScreen({this.isNoty = false});
  bool isNoty;
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if(isConnect!=null)checkNet(context);
          if(state is SignSuccessState){
            navigateTo(context, VerificationScreen(isNoty: isNoty));
          }
        },
        builder: (context, state) {
          var cubit = AuthCubit.get(context);
          return InkWell(
            onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: myAppBar(
                    context: context,
                    title: tr('sign_in'),
                    isArrowBack: isNoty ?false :true,
                    isLastWidget:isNoty ?false :true
                  ),
                ),
                SignWidget(
                  column: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height: size!.height * .01,),
                        defaultTextField(
                            hint: tr('phone_sign_in'),
                            controller: cubit.phoneController,
                            type: TextInputType.phone,
                            digitsOnly: true,
                            textLength: 10,
                            validator: (value){
                              if(value!.isEmpty){
                                return tr('phone_empty');
                              }
                          }
                        ),
                        SizedBox(height: size!.height * .01,),
                        state is SignLoadingState
                            ?const CircularProgressIndicator()
                            :defaultButton(
                            text: tr('sign_in'),
                          onTap: (){
                            FocusManager.instance.primaryFocus!.unfocus();
                            if(formKey.currentState!.validate()){
                              AuthCubit.get(context).sign();
                            }
                          },
                        ),
                        SizedBox(height: size!.height * .01,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('dont_have_account'),
                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                            ),
                            TextButton(
                              onPressed: () => navigateTo(context, SignUpScreen()),
                              child: Text(
                                tr('sign_up'),
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
