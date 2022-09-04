import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../sign_up/sign_up_screen.dart';
import '../../../widgets/sign_widget.dart';
import '../verification/verification_scren.dart';

class SignInScreen extends StatelessWidget {


  var forKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if(state is SignSuccessState){
            navigateTo(context, VerificationScreen());
          }
          if(state is SignErrorState)showToast(msg:state.msg,toastState: false);
        },
        builder: (context, state) {
          return Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: myAppBar(
                  context: context,
                  title: tr('sign_in'),
                  isArrowBack: true,
                ),
              ),
              SignWidget(
                column: Form(
                  key: forKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: size!.height * .01,),
                      defaultTextField(
                          hint: tr('phone_sign_in'),
                          controller: phoneController,
                          type: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        validator: (value){
                            if(value!.isEmpty){
                              return 'Phone Must Be Empty';
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
                          if(forKey.currentState!.validate()){
                            AuthCubit.get(context).sign(phone:phoneController.text.trim());
                          }
                        },
                      ),
                      SizedBox(height: size!.height * .01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr('dont_have_account'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () => navigateTo(context, SignUpScreen()),
                            child: Text(
                              tr('sign_up'),
                              style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold
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
          );
        },
      ),
    );
  }
}
