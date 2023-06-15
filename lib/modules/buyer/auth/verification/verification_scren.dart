import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_cubit.dart';
import 'package:soldout/modules/buyer/auth/auth_cubit/auth_state.dart';
import 'package:soldout/shared/styles/colors.dart';
import '../../../../layout/buyer_layout/buy_layout_screen.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/sign_widget.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({this.isNoty = false});
  bool isNoty;

  @override
  _State createState() => _State();
}

class _State extends State<VerificationScreen> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();

  int _start = 60;

  bool timerFinished = false;

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  bool checkCode() {
    print(code);
    print(myLocale);
    String codeFromOtp = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text +
        otpController5.text +
        otpController6.text;
    print(codeFromOtp);
    return int.parse(myLocale == 'en'
        ? codeFromOtp
        : String.fromCharCodes(codeFromOtp.runes.toList().reversed)) ==
        code;
  }

  bool checkOTP() {
    if(
    otpController1.text.isEmpty || otpController2.text.isEmpty||
        otpController3.text.isEmpty||otpController4.text.isEmpty||
        otpController5.text.isEmpty||otpController6.text.isEmpty
    ){
      return false;
    }else{
      return true;
    }
  }

  void submit(BuildContext context){
    if (checkOTP()) {
      if (checkCode()) {
        AuthCubit.get(context).logIn(context,widget.isNoty);
      } else {
        showToast(msg: tr('code_invalid'), toastState: true);
      }
    } else {
      showToast(msg: tr('code_empty'), toastState: true);
    }
  }

  @override
  void initState() {
    showToast(msg: '${tr('code_is')} $code');
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if(state is LoginSuccessState)navigateAndFinish(context, BuyerLayout());
        },
        builder: (context, state) {
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
                      title: tr('verification_code'),
                      isArrowBack: true,
                      arrowTap: () {
                        Navigator.pop(context);
                      }
                  ),
                ),
                SignWidget(
                  column: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: size!.height * .05,),
                      otpForm(),
                      SizedBox(height: size!.height * .01,),
                      state is! LoginLoadingState
                          ? defaultButton(
                          onTap: ()=>submit(context),
                          text: tr('verify')
                      ):const CircularProgressIndicator(),
                      SizedBox(height: size!.height * .02,),
                      if(!timerFinished)
                        Text(
                          '00:$_start',
                          style: const TextStyle(color: defaultColor),),
                      if(timerFinished)
                        TextButton(
                          onPressed: () {
                            AuthCubit.get(context).getCode();
                            timer;
                            _start = 60;
                            timerFinished = false;
                            startTimer();
                            showToast(msg: '${tr('code_is')} $code');
                            },
                          child: Text(
                            tr('reset'),
                            style: const TextStyle(color: defaultColor),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget otpForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        otpField(otpController1,    onFinished: () {
          if (checkOTP() && myLocale != 'en') {
            submit(context);
          }
        },),
        otpField(otpController2),
        otpField(otpController3),
        otpField(otpController4),
        otpField(otpController5),
        otpField(otpController6,    onFinished: () {
          if (checkOTP() && myLocale != 'ar') {
            submit(context);
          }
        },),
      ],
    );
  }

  Widget otpField(TextEditingController controller,{VoidCallback? onFinished}) {
    return SizedBox(
      height: 50,
      width: size!.width*.135,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: '*',
          hintStyle: TextStyle(
            fontSize: 40,
            color: HexColor('#A0AEC0'),
            height: 2,
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)
          ),
        ),
        onChanged: (value) {
          if(value.isNotEmpty){
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.previousFocus()
                :FocusManager.instance.primaryFocus!.nextFocus();
            if(onFinished!=null)onFinished();
          }else{
            myLocale =='ar'
                ? FocusManager.instance.primaryFocus!.nextFocus()
                :FocusManager.instance.primaryFocus!.previousFocus();
          }
          },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}