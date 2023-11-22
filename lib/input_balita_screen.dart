import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:stunting/balita_form_screen.dart';
import 'package:stunting/services/peserta_service.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_button.dart';
import 'package:stunting/widgets/custom_form_field.dart';
import 'package:stunting/widgets/loading_button.dart';

import 'models/peserta_model.dart';

class InputBalitaScreen extends StatefulWidget {
  const InputBalitaScreen({Key? key}) : super(key: key);

  @override
  State<InputBalitaScreen> createState() => _InputBalitaScreenState();
}

class _InputBalitaScreenState extends State<InputBalitaScreen> {
  PesertaModel? peserta;
  final formkey = GlobalKey<FormState>();
  TextEditingController ibuController = TextEditingController(text: '');
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController NIKController = TextEditingController(text: '');
  TextEditingController tglLhrController = TextEditingController(text: '');
  TextEditingController tmpLhrController = TextEditingController(text: '');
  TextEditingController JKController = TextEditingController(text: '');

  @override
  final List<String> genderItems = [
    'Laki-laki',
    'Perempuan',
  ];

  // DATA PESERTA
  List<PesertaModel> ibu = [];
  List<PesertaModel> _search = [];

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    searching();
    super.initState();
  }

  void searching() async {
    setState(() {
      isLoading = true;
    });
    _search.clear();
    ibu.clear();
    print('tes');

    if (ibuController.text.isNotEmpty) {
      var users = await PesertaService().getIbu(search: ibuController.text);
      setState(() {
        ibu = users;
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String? selectedIbuID;
  bool isIbuSelected = false;

  String? selectedJK;

  // HANDLE INPUT
  handleInput() async {
    setState(() {
      isLoading = true;
    });

    peserta = await PesertaService().inputBalita(
        nama: namaController.text,
        nik: NIKController.text,
        tglLahir: tglLhrController.text,
        tmpLahir: tmpLhrController.text,
        jenisKelamin: selectedJK.toString(),
        ibuID: selectedIbuID.toString());

    print(peserta!.nik.toString());

    if (peserta!.toJson().isNotEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => BalitaFormScreen(balita: peserta!)),
          (route) => false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Data Peserta Berhasil ditambah',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Data Gagal disimpan!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    Widget inputIbu() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nama ibu",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 10),
            TypeAheadFormField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: this.ibuController,
                style: primaryTextStyle,
                decoration: InputDecoration(
                  errorStyle: TextStyle(height: 0),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryTextColor),
                    borderRadius: BorderRadius.circular(
                      8,
                    ),
                  ),
                  hintText: 'Masukkan nama ibu terlebih dahulu',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: primaryColor,
                    ),
                  ),
                  prefixIcon: SvgPicture.asset(
                    'assets/mom_icon.svg',
                    width: 10,
                    height: 10,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              suggestionsCallback: (pattern) async {
                return await PesertaService().getIbu(search: pattern);
              },
              itemBuilder: (context, PesertaModel ibu) {
                return ListTile(
                  title: Text(ibu.nama.toString()),
                  subtitle: Text(ibu.nik.toString()),
                );
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              onSuggestionSelected: (PesertaModel ibu) {
                setState(() {
                  this.ibuController.text = ibu.nama.toString();
                  selectedIbuID = ibu.pesertaID.toString();
                  isIbuSelected = true;
                });
                print(isIbuSelected);
              },
              noItemsFoundBuilder: (context) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text('Data tidak ditemukan!'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '';
                }
              },
            ),
          ],
        ),
      );
    }

    // INFORMASI BALITA
    Widget balita() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 480,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Form Data Balita",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: false,
              title: 'Nama',
              hint: 'Nama Balita',
              icon: 'assets/balita_icon.svg',
              controller: namaController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: false,
              title: '(Optional) NIK',
              hint: 'NIK balita',
              icon: 'assets/NIK_icon.svg',
              controller: NIKController,
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: false,
              title: 'Tempat Lahir',
              hint: 'Tempat lahir balita',
              icon: 'assets/posyandu.svg',
              controller: tmpLhrController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggal Lahir',
                  style: primaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    readOnly: true,
                    cursorColor: primaryTextColor,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          tglLhrController.text = formattedDate;
                          print(' tgl: ${tglLhrController.text}');
                        });
                      } else {}
                    },
                    validator: (value) {
                      // NULL
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    controller: tglLhrController,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(height: 0),
                      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                      hintText: 'Tanggal lahir peserta',
                      prefixIcon: SvgPicture.asset(
                        'assets/date_icon.svg',
                        width: 10,
                        height: 10,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Jenis Kelamin',
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            ),
            DropdownButtonFormField2(
              decoration: InputDecoration(
                errorStyle: TextStyle(height: 0),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
              isExpanded: true,
              hint: const Text(
                'Pilih Jenis Kelamin',
                style: TextStyle(fontSize: 14),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              items: genderItems
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return '';
                }
              },
              onChanged: (value) {
                setState(() {
                  if (value == 'Laki-laki') {
                    selectedJK = 'L';
                  } else {
                    selectedJK = 'P';
                  }
                });
              },
            ),
          ],
        ),
      );
    }

    // BUTTON
    Widget button() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomButton(
          text: 'Simpan',
          color: primaryColor,
          press: () {
            if (formkey.currentState!.validate()) {
              handleInput();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Silahkan Lengkapi Data!',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
        ),
      );
    }

    // BUTTON
    Widget loadingBtn() {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: LoadingButton());
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Tambah Balita',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      inputIbu(),
                      isIbuSelected
                          ? Column(
                              children: [
                                balita(),
                                isLoading ? loadingBtn() : button(),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
