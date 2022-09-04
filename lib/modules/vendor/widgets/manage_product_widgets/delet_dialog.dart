import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';

class DeletDialog extends StatelessWidget {
  const DeletDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return AlertDialog(
     insetPadding: const EdgeInsets.symmetric(horizontal: 20),
     contentPadding:const  EdgeInsets.symmetric(vertical: 20,horizontal: 10),
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadiusDirectional.circular(20),
     ),
     content: Container(
       height: size!.height*.3,
       alignment: AlignmentDirectional.center,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
         children:  [
           const Icon(Icons.delete_forever,color: Colors.red,size: 50,),
            Text(
             tr('delete_sure'),
             textAlign: TextAlign.center,
             style:const TextStyle(
                 fontWeight: FontWeight.bold,
                 height: 2,
                 fontSize: 16
             ),
           ),
           defaultButton(onTap: (){}, text: tr('delete_product')),
           TextButton(
             onPressed: (){},
             child: Text(
               tr('discard'),
               style:const TextStyle(fontWeight: FontWeight.w900,color: Colors.red),
             ),
           ),
         ],
       ),
     ),
   );
  }
}
