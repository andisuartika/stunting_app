import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final String hint;
  final String icon;
  final bool readOnly;
  final validator;
  final keyboardType;
  final TextEditingController controller;
  const CustomFormField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.icon,
      this.validator,
      this.keyboardType,
      required this.controller,
      required this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        Container(
          width: double.infinity,
          child: TextFormField(
            readOnly: readOnly,
            cursorColor: primaryTextColor,
            keyboardType: keyboardType,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            decoration: InputDecoration(
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              hintText: hint,
              // hintStyle: hintTextStyle.copyWith(
              //   fontSize: 12,
              //   fontWeight: regular,
              // ),
              // fillColor: backgorundFieldColor,
              // filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: primaryTextColor),
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              prefixIcon: SvgPicture.asset(
                icon,
                width: 10,
                height: 10,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
