import 'package:flutter/material.dart';

class CustomText extends Text{
  CustomText(String data, {color = Colors.white, textAlign = TextAlign.center, factor = 1.0}):
      super(
        data,
        style: TextStyle(color: color),
        textAlign: textAlign,
        textScaleFactor: factor
      );
}