import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:stunting/calon_ibu_form_screen.dart';
import 'package:stunting/models/peserta_model.dart';
import 'package:stunting/services/peserta_service.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_button.dart';
import 'package:stunting/widgets/custom_form_field.dart';
import 'package:stunting/widgets/custom_form_field_kesehatan.dart';
import 'package:stunting/widgets/custom_text_form_field.dart';
import 'package:stunting/widgets/loading_button.dart';
import 'package:stunting/widgets/peserta_list_item.dart';

class InputIbuScreen extends StatefulWidget {
  const InputIbuScreen({Key? key}) : super(key: key);

  @override
  State<InputIbuScreen> createState() => _InputIbuScreenState();
}

class _InputIbuScreenState extends State<InputIbuScreen> {
  PesertaModel? peserta;
  final formkey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController NIKController = TextEditingController(text: '');
  TextEditingController tglLhrController = TextEditingController(text: '');
  bool isLoading = false;

  // HANDLE INPUT
  handleInput() async {
    setState(() {
      isLoading = true;
    });

    peserta = await PesertaService().inputIbu(
      nama: namaController.text,
      nik: NIKController.text,
      tglLahir: tglLhrController.text,
    );

    print(peserta!.nik.toString());

    if (peserta!.toJson().isNotEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => CalonIbuFormScreen(ibu: peserta!)),
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

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  bool _onSearch = false;

  Widget build(BuildContext context) {
    // INFORMASI CALON IBU
    Widget calonIbu() {
      return Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Input Data Calon Ibu",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 20),
            CustomFormField(
              readOnly: false,
              title: 'Nama',
              hint: 'Nama Calon Ibu',
              icon: 'assets/mom_icon.svg',
              controller: namaController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "Masukkan nama peserta";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: false,
              keyboardType: TextInputType.number,
              title: 'NIK',
              hint: 'NIK peserta',
              icon: 'assets/NIK_icon.svg',
              controller: NIKController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "Masukkan NIK";
                }
                if (value!.length > 16) {
                  return "NIK tidak boleh dari 16 digit";
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
                        return "Masukkan tanggal lahir";
                      }
                      return null;
                    },
                    controller: tglLhrController,
                    decoration: InputDecoration(
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
          ],
        ),
      );
    }

    // BUTTON
    Widget button() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: CustomButton(
          text: 'Simpan',
          color: primaryColor,
          press: () {
            if (formkey.currentState!.validate()) {
              handleInput();
            }
          },
        ),
      );
    }

    // LOADING
    Widget loadingBtn() {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 20), child: LoadingButton());
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Tambah Calon Ibu',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                calonIbu(),
                isLoading ? loadingBtn() : button(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
