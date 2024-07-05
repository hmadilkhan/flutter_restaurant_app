import 'package:flutter/material.dart';
import 'package:grocery_app/utils/tcolor.dart';

Widget bottomText() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "Didn't Received? ",
        style: TextStyle(
            color: TColor.secondaryText,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      Text(
        "Click Here",
        style: TextStyle(
            color: TColor.primary, fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ],
  );
}
