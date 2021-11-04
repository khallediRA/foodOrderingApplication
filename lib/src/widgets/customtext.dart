import 'package:flutter/material.dart';

import '../helpers/commons.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final bool designedtext;
  final FontWeight fontweight;
  final bool underline;

  const CustomText(
      {Key key,
      this.text,
      this.size,
      this.designedtext = false,
      this.color,
      this.fontweight,
      this.underline = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          letterSpacing: designedtext ? 3.0 : 0.0,
          fontFamily: designedtext ? "Ostrich" : null,
          fontSize: size ?? 18,
          color: color ?? black,
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
          fontWeight: fontweight ?? FontWeight.bold),
    );
  }
}
