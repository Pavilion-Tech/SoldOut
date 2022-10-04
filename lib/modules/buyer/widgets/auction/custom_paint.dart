import 'package:flutter/material.dart';


class MCustomPaint extends StatelessWidget {
  const MCustomPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: CustomPaint(
        size: Size(40,(40*0.5833333333333334).toDouble()),
        painter: RPSCustomPainter(),
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
    path0.moveTo(size.width*0.5000000,0);
    path0.lineTo(size.width*0.499167,size.height*0.9942857);
    path0.lineTo(0,0);
    path0.lineTo(size.width,0);
    path0.moveTo(size.width*0.5000000,0);
    path0.close();

    canvas.drawPath(path0, paint0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
