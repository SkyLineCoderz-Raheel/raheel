import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
 String text;
 Color textColor;


  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
      color: Colors.black ?? textColor ,
      fontSize: 26,
      fontWeight: FontWeight.w800
    ),);
  }

 SmallText({
    required this.text,
    required this.textColor,
  });
}
