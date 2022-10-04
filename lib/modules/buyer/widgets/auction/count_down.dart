import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../shared/styles/colors.dart';

class CountDown extends StatefulWidget {
  CountDown({
    required this.fontSize,
    required this.duration,
  });

  double fontSize;
  Duration duration;


  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {

  late Timer timer;




  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setCountDown();
    });
  }

  void setCountDown(){
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = widget.duration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer.cancel();
      } else {
        widget.duration = Duration(seconds: seconds);
      }
    });
  }

  @override
  void initState() {

   startTimer();

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(widget.duration.inHours.remainder(24));
    final minutes = strDigits(widget.duration.inMinutes.remainder(60));
    final seconds = strDigits(widget.duration.inSeconds.remainder(60));

    return  Text(
      '$hours:$minutes:$seconds',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style:TextStyle(color: defaultColor,fontSize: widget.fontSize,fontWeight: FontWeight.bold),
    );
  }
}
