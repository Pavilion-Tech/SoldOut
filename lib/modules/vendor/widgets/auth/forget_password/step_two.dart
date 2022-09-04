import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_tree.dart';
import 'package:soldout/modules/vendor/widgets/auth/forget_password/step_widget.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../../shared/components/constants.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../widgets/my_container.dart';

class VerficationCode extends StatefulWidget {
   VerficationCode({Key? key}) : super(key: key);

  @override
  State<VerficationCode> createState() => _VerficationCodeState();
}

class _VerficationCodeState extends State<VerficationCode> {
  Timer? _timer;

  int _start = 59;

  bool _timerFinished = false;

  void startTimer() {
    const oneSec =  Duration(seconds: 1);
    _timer =  Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            _timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: myAppBar(
              context:context,
              title:tr('verification_code'),
              isArrowBack: true,
              arrowTap: (){
                _timer!.cancel();
                Navigator.pop(context);
              }
            ),
          ),
          MyContainer(
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  StepWidget(
                    title: tr('step_two_of_three'),
                    description:tr('enter_code'),
                  ),
              SizedBox(height: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  otpForm(),
                  const SizedBox(height: 30,),
                  defaultButton(onTap: (){
                    setState(() {
                      _timer!.cancel();
                      _timerFinished = true;
                      navigateTo(context, ResetPassword());
                    });
                  },text:tr('verify') ),
                  SizedBox(height: size!.height*.02,),
                  if(!_timerFinished)
                    Text('00:$_start', style: const TextStyle(color: defaultColor),),
                  if(_timerFinished)
                    TextButton(
                      onPressed: (){},
                      child: Text(tr('reset') , style:const TextStyle(color: defaultColor),
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
  }

  Widget otpForm() {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          otpField(),
          otpField(),
          otpField(),
          otpField(),
          otpField(),
          otpField(),
        ],
      ),
    );
  }

  Widget otpField(){
    return SizedBox(
      height: 50,
      width: 50,
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        decoration:  InputDecoration(
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
        onChanged: (value){
          FocusManager.instance.primaryFocus!.nextFocus();
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
