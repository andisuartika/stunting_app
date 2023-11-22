import 'package:flutter/material.dart';
import 'package:stunting/calon_ibu_form_screen.dart';
import 'package:stunting/models/peserta_model.dart';

import '../theme.dart';

class PesertaListItem extends StatelessWidget {
  final PesertaModel peserta;
  final Function() press;
  const PesertaListItem({
    Key? key,
    required this.peserta,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      // width: 240,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            peserta.nama.toString(),
                            style: primaryTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          ),
                          Text(
                            peserta.nik.toString(),
                            style: secondaryTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: regular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              thickness: 0.7,
              color: secondaryTextColor,
            )
          ],
        ),
      ),
    );
  }
}
