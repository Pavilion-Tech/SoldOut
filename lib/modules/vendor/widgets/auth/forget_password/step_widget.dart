import 'package:flutter/material.dart';

class StepWidget extends StatelessWidget {

  StepWidget({
    required this.title,
    required this.description,
});
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          description,
          style:const  TextStyle(
              fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}
