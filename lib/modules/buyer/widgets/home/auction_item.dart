import 'dart:async';

import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../screens/auction/auction_screen.dart';

class AuctionItem extends StatefulWidget {


  AuctionItem({
    required this.title,
    required this.state,
    required this.time,
    this.isHome = false
  });

  String? title;
  String? state;
  String? time;
  bool isHome;


  @override
  State<AuctionItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<AuctionItem> {
  String? id;

  Timer? timer;
  Duration duration = const Duration(hours: 10,minutes: 30,seconds: 22);




  // void startTimer(){
  //   timer = Timer.periodic(Duration(seconds: 1), (timer) {
  //     setCountDown();
  //   });
  // }
  // void stopTimer(){
  //   setState(() => timer!.cancel());
  // }
  // void setCountDown(){
  //   final reduceSecondsBy = 1;
  //   setState(() {
  //     final seconds = duration.inSeconds - reduceSecondsBy;
  //     if (seconds < 0) {
  //       timer!.cancel();
  //     } else {
  //       duration = Duration(seconds: seconds);
  //     }
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {


    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(duration.inHours.remainder(24));
    final minutes = strDigits(duration.inMinutes.remainder(60));
    final seconds = strDigits(duration.inSeconds.remainder(60));
    return InkWell(
      onTap: (){
        navigateTo(context, AuctionScreen());
      },
      child: Container(
        height: size!.height*.20,
        width: size!.width*.45,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Column(
          children: [
            Container(
                height: size!.height*.12,
                width: size!.width*.45,
                child: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',fit: BoxFit.cover,)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.state!,
                        style:const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if(widget.isHome)
                        Icon(Icons.timer,color: Colors.black,size: 18,),
                      Text(
                        '$hours:$minutes:$seconds',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: defaultColor,fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
