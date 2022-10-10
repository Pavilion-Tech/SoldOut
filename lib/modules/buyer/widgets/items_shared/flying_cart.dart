import 'package:flutter/material.dart';


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
                      widget.isGrid ? biggest.width * .844: biggest.width*.65,
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
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                    errorBuilder: (c, Object o, s) {
                      return const Icon(Icons.info);
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes !=
                              null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )
              ),
            ),
          ],
        );
      },
    );
  }
}
