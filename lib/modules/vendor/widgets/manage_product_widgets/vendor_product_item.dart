import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:soldout/shared/components/components.dart';
import 'package:soldout/shared/images/images.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../screens/manage_product/vendor_edit_product.dart';
import '../../screens/manage_product/vendor_product_screen.dart';

class VProductItem extends StatelessWidget {


  VProductItem({
    required this.title,
    required this.id,
    required this.price,
    required this.rate,
  });

  String? title;
  String? id;
  double? price;
  double? height;
  double? rate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context, VProductScreen());
      },
      child: Container(
        height: size!.height * .15,
        width: size!.width * .5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: defaultColorTwo,
            borderRadius: BorderRadiusDirectional.circular(14),
            border: Border.all(
                color: Colors.blue.shade100.withOpacity(.5)
            )
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: size!.height * .11,
                    width: size!.width * .5,
                    child: Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',fit: BoxFit.cover,)),
                Positioned(
                    top: -size!.height * .010,
                    right: -size!.width * .03  ,
                    left: size!.width * .35,
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border_sharp,color: Colors.blue,size: 18,)))
              ],
            ),
            SizedBox(height: size!.height*.009,),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: size!.height*.05,
                        width: size!.width*.15,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: rate!,
                              itemSize: 10,
                              direction: Axis.horizontal,
                              ignoreGestures: true,
                              itemCount: 5,
                              allowHalfRating: true,
                              unratedColor: HexColor('#FFE000'),
                              itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, index)  {
                                if(rate! > index){
                                  return Image.asset(BuyerImages.fullStar);
                                }else {
                                  return Icon(
                                    Icons.star_border,
                                    size: 16,
                                  );
                                }
                              },
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              '$price SAR',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: defaultColor,fontSize: 11,fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: ()=>navigateTo(context, VendorEditProductScreen()),
                        child: SizedBox(
                          height: size!.height * .05,
                          width: size!.width * .11,
                          child: ClipPolygon(
                            sides: 4,
                            borderRadius: 15,
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                color: defaultColor,
                                child: Icon(Icons.edit,color: defaultColorTwo,size: 12,)),
                          ),
                        ),
                      )
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
