import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/utils/tcolor.dart';

class RoundTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;
  final String? Function(String?)? validator;
  final String? Function(String)? onChanged;
  final String? Function(String?)? onSaved;
  final int? maxLines;
  final String? errorText;

  const RoundTextfield({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.bgColor,
    this.left,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.errorText,
    this.onSaved,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
          color: bgColor ?? TColor.textfield,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: left!,
            ),
          Expanded(
            child: TextFormField(
              autocorrect: false,
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              validator: validator,
              onChanged: onChanged,
              onSaved: onSaved,
              maxLines: maxLines,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorText: errorText,
                errorStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: TColor.placeholder,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundTitleTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String title;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? bgColor;
  final Widget? left;

  const RoundTitleTextfield(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.keyboardType,
      this.bgColor,
      this.left,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
          color: bgColor ?? TColor.textfield,
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          if (left != null)
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: left!,
            ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(
                    top: 8,
                  ),
                  alignment: Alignment.topLeft,
                  child: TextField(
                    autocorrect: false,
                    controller: controller,
                    obscureText: obscureText,
                    keyboardType: keyboardType,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: hintText,
                      hintStyle: TextStyle(
                          color: TColor.placeholder,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  height: 55,
                  margin: const EdgeInsets.only(top: 10, left: 20),
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: TextStyle(color: TColor.placeholder, fontSize: 11),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
