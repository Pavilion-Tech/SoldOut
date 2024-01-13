import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import 'package:soldout/modules/buyer/widgets/auction/count_down.dart';
import 'package:soldout/shared/components/components.dart';
import '../../../../models/buyer_model/home_model/new_auctions_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../widgets/image_net.dart';
import '../../auth/sign_in/sign_in_screen.dart';
import '../../screens/auction/auction_screen.dart';

class AuctionItem extends StatelessWidget {


  AuctionItem({
    this.isHome = false,
    required this.model

  });


  AuctionModel model;
  bool isHome;

  late CountDown countDown;


  @override
  Widget build(BuildContext context) {
    print(model.dateTo!.substring(11,13));
    print(convertTo12HourFormat(model.dateTo!.substring(11,13)));
    countDown = CountDown(fontSize: 12,duration: Duration(milliseconds: model.remainingTime!),);
    return InkWell(
      onTap: (){
        if(token!=null)
        {
          if(model.status == 'processing')
          {
            AuctionCubit.get(context).subscribePusher(model.id!);
          }
          AuctionCubit.get(context).auctionModel = model;
          AuctionCubit.get(context).duration = countDown.duration;
          navigateTo(context, AuctionScreen());
        }else
          {
            navigateTo(context, SignInScreen());
          }

      },
      child: Container(
        height: size!.height*.23,
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
                child: ImageNet(image:model.images!.isNotEmpty? model.images![0].image!:'',)
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          model.auctionName??'',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Column(
                        children: [
                          Text(
                            "${model.dateFrom?.substring(0,11)??''} ${convertTo12HourFormat(model.dateFrom!.substring(11,13))}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                          ),
                          Text(
                           "${model.dateTo?.substring(0,11)??''} ${convertTo12HourFormat(model.dateTo!.substring(11,13))}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${tr('${model.status??''}')}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      if(isHome&&model.status == 'processing')
                        const Icon(Icons.timer,color: Colors.black,size: 18,),
                      if(model.status == 'processing')
                        countDown,
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
  String convertTo12HourFormat(String time) {
    int hour = int.parse(time);
    String period = (hour >= 12) ? tr('pm') : tr('am');
    hour = hour % 12;
    if (hour == 0) {
      hour = 12;
    }
    return '$hour $period';
  }
}