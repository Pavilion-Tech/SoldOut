import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/modules/buyer/screens/auction/auction_cubit/auction_cubit.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../screens/check_out/auction_check_out.dart';

class AuctionDialog extends StatelessWidget {
  AuctionDialog(this.id);

  int id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      content: Container(
        height: size!.height >600?size!.height * .3:size!.height * .4,
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100,),
            Text(tr('congrats')),
            Text(tr('pay_for_product')),
            TextButton(
              onPressed: () {
                navigateTo(context, AuctionCheckOutScreen());
                AuctionCubit.get(context).getCheckOut(id);
              },
              child: Text(tr('payment')),
            ),
          ],
        ),
      ),
    );
  }
}
