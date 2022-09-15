import 'package:flutter/material.dart';
import 'package:soldout/shared/styles/colors.dart';

class NotificationItem extends StatelessWidget {

  //late String time ;

  @override
  Widget build(BuildContext context) {
    //  time =DateFormat('',myLocale == 'ar'?'ar':'en')
    //     .add_yMMMMEEEEd()
    //     .format(DateTime.fromMillisecondsSinceEpoch(reviews.createdAt!));
    return Container(
      padding: const EdgeInsetsDirectional.only(
        top: 8,
        start: 8,
        bottom: 8,
        end: 16,
      ),
      decoration: BoxDecoration(
        color: defaultColorTwo,
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(color: Colors.grey.shade300)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notificaion Name',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'Lorem Ipsum Is Simply Dummy Text Of The Printing And Typesetting Industry. Lorem Ipsum Has Been The Industry\'s Standard Dummy Text Ever Since The 1500S, When An Unknown Printer Took A Galley Of Type And Scrambled It To Make A Type Specimen Book. It Has Survived Not Only Five Centuries, But Also The Leap Into Electronic Typesetting, Remaining Essentially Unchanged. It Was Popularised In The 1960S With The Release Of Letraset Sheets Containing Lorem Ipsum Passages, And More Recently With Desktop Publishing Software Like Aldus Pagemaker Including Versions Of Lorem Ipsum.',
              maxLines: 3,
              style: TextStyle(height: 2),
            ),
          ),
          Text(
            '19, May, 2020 - 01:20 AM',
            style: TextStyle(
                color: Colors.grey,
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
