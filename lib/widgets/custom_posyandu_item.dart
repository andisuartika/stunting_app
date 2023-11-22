import 'dart:math';

import 'package:flutter/material.dart';

import '../theme.dart';

class CustomPosyanduItem extends StatelessWidget {
  final String posyanduName, alamat, tenagaMedis;
  const CustomPosyanduItem({
    Key? key,
    required this.posyanduName,
    required this.alamat,
    required this.tenagaMedis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 85,
            height: 85,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/hospital.png'), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  posyanduName,
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  alamat,
                  style: primaryTextStyle.copyWith(
                    fontSize: 12,
                    fontWeight: regular,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: SizedBox(height: 5),
                ),
                Text(
                  "Tenaga Medis ${Random().nextInt(16)}",
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
