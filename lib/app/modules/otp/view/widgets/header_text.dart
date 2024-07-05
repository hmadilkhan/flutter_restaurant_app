import 'package:flutter/material.dart';
import 'package:grocery_app/utils/tcolor.dart';

Widget headerText() {
  return Column(
    children: [
      const SizedBox(
        height: 64,
      ),
      Text(
        "We have sent an OTP to your number",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: TColor.primaryText,
            fontSize: 30,
            fontWeight: FontWeight.w800),
      ),
      const SizedBox(
        height: 15,
      ),
      Text(
        "Enter the code that we sent to your number ",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: TColor.secondaryText,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        "+92 3112108156",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: TColor.primaryText,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
    ],
  );
}
