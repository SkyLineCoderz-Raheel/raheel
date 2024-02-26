import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
String name;
  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/$name.png");

  }

CustomImage({
    required this.name,
  });
}
