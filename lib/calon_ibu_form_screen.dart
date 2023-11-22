import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:stunting/calon_ibu_screen.dart';
import 'package:stunting/main_screen.dart';
import 'package:stunting/models/periode_model.dart';
import 'package:stunting/models/peserta_model.dart';
import 'package:stunting/models/posyandu_model.dart';
import 'package:stunting/services/peserta_service.dart';
import 'package:stunting/services/resource_service.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_button.dart';
import 'package:stunting/widgets/custom_form_field.dart';
import 'package:stunting/widgets/custom_form_field_kesehatan.dart';
import 'package:stunting/widgets/loading_button.dart';

class CalonIbuFormScreen extends StatefulWidget {
  final PesertaModel ibu;
  const CalonIbuFormScreen({Key? key, required this.ibu}) : super(key: key);

  @override
  State<CalonIbuFormScreen> createState() => _CalonIbuFormScreenState();
}

class _CalonIbuFormScreenState extends State<CalonIbuFormScreen> {
  final formkey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController NIKController = TextEditingController(text: '');
  TextEditingController tglLhrController = TextEditingController(text: '');
  TextEditingController tekananDarahController =
      TextEditingController(text: '');
  TextEditingController BBController = TextEditingController(text: '');
  TextEditingController TBController = TextEditingController(text: '');
  TextEditingController LPController = TextEditingController(text: '');
  TextEditingController LBController = TextEditingController(text: '');
  TextEditingController LLController = TextEditingController(text: '');
  bool isLoading = false;

  @override
  final List<PeriodeModel> bulan = [
    PeriodeModel(id: '1', bulan: 'Januari'),
    PeriodeModel(id: '2', bulan: 'Februari'),
    PeriodeModel(id: '3', bulan: 'Maret'),
    PeriodeModel(id: '4', bulan: 'April'),
    PeriodeModel(id: '5', bulan: 'Mei'),
    PeriodeModel(id: '6', bulan: 'Juni'),
    PeriodeModel(id: '7', bulan: 'Juli'),
    PeriodeModel(id: '8', bulan: 'Agustus'),
    PeriodeModel(id: '9', bulan: 'September'),
    PeriodeModel(id: '10', bulan: 'Oktober'),
    PeriodeModel(id: '11', bulan: 'November'),
    PeriodeModel(id: '12', bulan: 'Desember'),
  ];

  String? selectedPeriode;
  String? selectedPosyandu;

  List<PosyanduModel> posyandus = [];

  @override
  void initState() {
    // TODO: implement initState
    getPosyandu();
    setState(() {
      namaController.text = widget.ibu.nama.toString();
      NIKController.text = widget.ibu.nik.toString();
      tglLhrController.text = widget.ibu.tanggalLahir.toString();
    });
    super.initState();
  }

  getPosyandu() async {
    var res = await ResourceService().getPosyandu();
    setState(() {
      posyandus = res.toList();
    });
  }

  // HANDLE INPUT
  handleInput() async {
    setState(() {
      isLoading = true;
    });

    if (await PesertaService().periksaIbu(
      pesertaID: widget.ibu.pesertaID.toString(),
      posyanduID: selectedPosyandu.toString(),
      periode: selectedPeriode.toString(),
      tekananDarah: tekananDarahController.text,
      lingkarPinggang: LPController.text,
      lingkarBokong: LBController.text,
      lingkarLengan: LLController.text,
      tinggiBadan: TBController.text,
      beratBadan: BBController.text,
    )) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(pageIndex: 2)),
          (route) => false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Data Kesehatan Berhasil disimpan!',
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

    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    // INFORMASI CALON IBU
    Widget calonIbu() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 325,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Calon Ibu",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 20),
            CustomFormField(
              readOnly: true,
              title: 'Nama',
              hint: 'Nama Calon Ibu',
              icon: 'assets/mom_icon.svg',
              controller: namaController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "Masukkan nama ibu";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: true,
              title: 'NIK',
              hint: 'NIK Calon Ibu',
              icon: 'assets/NIK_icon.svg',
              controller: NIKController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "Masukkan NIK";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: true,
              title: 'Tanggal Lahir',
              hint: 'Tanggal Lahir Calon Ibu',
              icon: 'assets/date_icon.svg',
              controller: tglLhrController,
              validator: (value) {
                // NULL
                if (value!.isEmpty) {
                  return "Masukkan tanggal lahir";
                }
                return null;
              },
            ),
          ],
        ),
      );
    }

    // KESEHATAN CALON IBU
    Widget kesehatan() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 550,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Form Kesehatan Calon Ibu",
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: semiBold,
                ),
              ),
              SizedBox(height: 20),
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
                  'Periode Periksa',
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
                items: bulan
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(
                            item.bulan.toString(),
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
                  selectedPeriode = value.toString();
                  print(selectedPeriode);
                },
                onSaved: (value) {
                  selectedPeriode = value.toString();
                  print(selectedPeriode);
                },
              ),
              SizedBox(height: 10),
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
                  'Posyandu',
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
                items: posyandus
                    .map((item) => DropdownMenuItem<String>(
                          value: item.posyanduID.toString(),
                          child: Text(
                            item.namaPosyandu.toString(),
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
                  selectedPosyandu = value.toString();
                  print('posyandu : $selectedPosyandu');
                },
              ),
              SizedBox(height: 10),
              CustomFormFieldKesehatan(
                hint: 'Tekanan Darah',
                suffix: 'mmHg',
                controller: tekananDarahController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomFormFieldKesehatan(
                hint: 'Berat Badan',
                suffix: 'kg',
                controller: BBController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomFormFieldKesehatan(
                hint: 'Tinggi Badan',
                suffix: 'cm',
                controller: TBController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomFormFieldKesehatan(
                hint: 'Lingkar Pinggang',
                suffix: 'cm',
                controller: LPController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomFormFieldKesehatan(
                hint: 'Lingkar Bokong',
                suffix: 'cm',
                controller: LBController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomFormFieldKesehatan(
                hint: 'Lingkar Lengan',
                suffix: 'cm',
                controller: LLController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
            ],
          ),
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

    // LOADING
    Widget loadingButton() {
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
          'Kesehatan Calon Ibu',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => MainScreen(pageIndex: 1)),
              ),
            );
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              calonIbu(),
              kesehatan(),
              isLoading ? loadingButton() : button(),
            ],
          ),
        ),
      ),
    );
  }
}
