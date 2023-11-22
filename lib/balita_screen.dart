import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stunting/balita_form_screen.dart';
import 'package:stunting/input_balita_screen.dart';
import 'package:stunting/services/peserta_service.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_button.dart';
import 'package:stunting/widgets/custom_form_field.dart';
import 'package:stunting/widgets/custom_form_field_kesehatan.dart';
import 'package:stunting/widgets/peserta_list_item.dart';

import 'models/peserta_model.dart';

class BalitaScreen extends StatefulWidget {
  const BalitaScreen({Key? key}) : super(key: key);

  @override
  State<BalitaScreen> createState() => _BalitaScreenState();
}

class _BalitaScreenState extends State<BalitaScreen> {
  final formkey = GlobalKey<FormState>();
  // TEXTEDITING CONTROLLER
  TextEditingController searchController = TextEditingController(text: '');

  // DATA PESERTA
  List<PesertaModel> peserta = [];
  List<PesertaModel> _search = [];

  bool isLoading = false;

  @override
  void searching(String search) async {
    setState(() {
      isLoading = true;
    });
    _search.clear();
    peserta.clear();

    if (searchController.text.isNotEmpty) {
      var users =
          await PesertaService().getBalita(search: searchController.text);
      setState(() {
        peserta = users;
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  bool _onSearch = false;

  Widget build(BuildContext context) {
    // HEADER
    Widget header() {
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 290,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xFFECF0F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.search_normal,
                    color: primaryTextColor,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      style: primaryTextStyle,
                      // controller: searchController,
                      onTap: () {
                        setState(() {
                          _onSearch = true;
                          print(_onSearch);
                        });
                      },
                      controller: searchController,
                      onChanged: searching,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Cari nama balita',
                        hintStyle: secondaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputBalitaScreen(),
                  ),
                );
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Iconsax.add_circle,
                  color: whiteColor,
                ),
              ),
            )
          ],
        ),
      );
    }

    // RESULT
    Widget Peserta() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _onSearch ? 'Hasil pencarian' : 'Peserta',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: peserta.length,
                      itemBuilder: (context, index) => PesertaListItem(
                        peserta: peserta[index],
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BalitaFormScreen(balita: peserta[index]),
                            ),
                          );
                        },
                      ),
                    ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            header(),
            _onSearch ? Expanded(child: Peserta()) : SizedBox()
          ],
        ),
      ),
    );
  }
}
