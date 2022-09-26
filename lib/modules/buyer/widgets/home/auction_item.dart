import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/widgets/auction/count_down.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../models/buyer_model/home_model/new_auctions_model.dart';
import '../../../../shared/components/constants.dart';
import '../../screens/auction/auction_screen.dart';

class AuctionItem extends StatelessWidget {


  AuctionItem({
    this.isHome = false,
    this.model

  });


  NewAuction? model;
  bool isHome;


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        navigateTo(context, AuctionScreen());
      },
      child: Container(
        height: size!.height*.20,
        width: isHome ? size!.width*.9: size!.width*.45,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10),
        ),
        child: Column(
          children: [
            SizedBox(
                height: size!.height*.12,
                width:isHome ? size!.width*.9: size!.width*.45,
                child: Image.network(
                  model!.images![0].image!,
                  fit: BoxFit.cover,
                  errorBuilder: (c,o,s)=>const Icon(Icons.info),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model!.auctionName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      if(isHome)
                        const Icon(Icons.timer,color: Colors.black,size: 18,),
                        CountDown(fontSize: 12,endAt:model!.remainingTime!),
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

