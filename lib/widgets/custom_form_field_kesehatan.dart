import 'package:flutter/material.dart';

import '../theme.dart';

class CustomFormFieldKesehatan extends StatelessWidget {
  final String hint;
  final String suffix;
  final validator;
  final keyboardType;
  final TextEditingController controller;
  const CustomFormFieldKesehatan(
      {Key? key,
      required this.hint,
      this.validator,
      this.keyboardType,
      required this.controller,
      required this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: TextFormField(
            cursorColor: primaryTextColor,
            keyboardType: keyboardType,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validator,
            decoration: InputDecoration(
              suffixText: suffix,
              suffixStyle: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
              errorStyle: TextStyle(height: 0),
              contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              hintText: hint,
              hintStyle: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: regular,
              ),
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
            ),
          ),
        ),
      ],
    );
  }
}
