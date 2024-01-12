import 'package:flutter/material.dart';
import 'package:soldout/modules/widgets/image_net.dart';
import 'package:soldout/shared/components/constants.dart';


class FlyingCart extends StatefulWidget {

  FlyingCart(this.currentHeight,this.currentWidth,this.image,{this.isGrid = true});

  double currentHeight;
  double currentWidth;
  bool isGrid;
  String image;

  @override
  State<FlyingCart> createState() => _FlyingCartState();
}

class _FlyingCartState extends State<FlyingCart>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: Duration(seconds: 4), vsync: this)
      ..forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double smallLogo = 50;
    const double bigLogo = 100;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size biggest = constraints.biggest;
        return Stack(
          children: <Widget>[
            PositionedTransition(
              rect: RelativeRectTween(
                begin: RelativeRect.fromSize(
                     Rect.fromLTWH(
                         widget.currentWidth - smallLogo,
                         widget.currentHeight - smallLogo,
                         bigLogo,
                         bigLogo
                    ), biggest),
                end: RelativeRect.fromSize(
                    Rect.fromLTWH(
                      widget.isGrid ? biggest.width * .844: myLocale =='en'?biggest.width*.65:biggest.width*.25,
                      widget.isGrid ? biggest.height * .05:biggest.height*.93,
                      smallLogo,
                      smallLogo,
                    ),
                    biggest),
              ).animate(CurvedAnimation(
                parent: _controller,
                curve: Curves.elasticInOut,
              )),
              child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: ImageNet(image: widget.image,),
                  )
              ),
            ),
          ],
        );
      },
    );
  }
}
