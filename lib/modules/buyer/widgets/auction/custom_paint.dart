import 'package:flutter/material.dart';

import '../../../../shared/components/constants.dart';

class MCustomPaint extends StatelessWidget {
  const MCustomPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Positioned(
      top: size!.height * .09,
      left:myLocale == 'ar'?0: size!.width * .82,
      child: Container(
        child: CustomPaint(
          size: Size(40,(40*0.5833333333333334).toDouble()),
          painter: RPSCustomPainter(),
        ),
      ),
    );
  }
}



class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(size.width,0);
    path0.lineTo(size.width,size.height);
    path0.lineTo(size.width*0.4175000,size.height);

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
