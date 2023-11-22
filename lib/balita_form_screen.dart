import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:stunting/main_screen.dart';
import 'package:stunting/models/imunisasi_model.dart';
import 'package:stunting/services/peserta_service.dart';
import 'package:stunting/services/resource_service.dart';
import 'package:stunting/theme.dart';
import 'package:stunting/widgets/custom_button.dart';
import 'package:stunting/widgets/custom_form_field.dart';
import 'package:stunting/widgets/custom_form_field_kesehatan.dart';
import 'package:stunting/widgets/loading_button.dart';

import 'models/periode_model.dart';
import 'models/peserta_model.dart';
import 'models/posyandu_model.dart';

class BalitaFormScreen extends StatefulWidget {
  final PesertaModel balita;
  const BalitaFormScreen({Key? key, required this.balita}) : super(key: key);

  @override
  State<BalitaFormScreen> createState() => _BalitaFormScreenState();
}

class _BalitaFormScreenState extends State<BalitaFormScreen> {
  final formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController(text: '');
  TextEditingController NIKController = TextEditingController(text: '');
  TextEditingController tglLhrController = TextEditingController(text: '');
  TextEditingController tmpLhrController = TextEditingController(text: '');
  TextEditingController JKController = TextEditingController(text: '');
  TextEditingController umurController = TextEditingController(text: '');
  TextEditingController BBController = TextEditingController(text: '');
  TextEditingController PBController = TextEditingController(text: '');
  TextEditingController LLController = TextEditingController(text: '');
  TextEditingController LKController = TextEditingController(text: '');
  @override
  final List<String> asiEkslusif = [
    'Ya',
    'Tidak',
  ];

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

  List<PosyanduModel> posyandus = [];
  List<ImunisasiModel> imunisasis = [];

  String? selectedJK;
  String? selectedPeriode;
  String? selectedPosyandu;
  String? selectedAsiEkslusif;
  List<String> selectedImunisasi = [];

  void initState() {
    // TODO: implement initState
    getPosyandu();
    getImunisasi();
    setState(() {
      namaController.text = widget.balita.nama.toString();
      NIKController.text = widget.balita.nik.toString();
      tglLhrController.text = widget.balita.tanggalLahir.toString();
      tmpLhrController.text = widget.balita.tanggalLahir.toString();
      if (widget.balita.jenisKelamin.toString() == 'P') {
        JKController.text = 'Perempuan';
      } else {
        JKController.text = 'Laki-laki';
      }
    });
    super.initState();
  }

  getPosyandu() async {
    var res = await ResourceService().getPosyandu();
    setState(() {
      posyandus = res.toList();
    });
  }

  getImunisasi() async {
    var res = await ResourceService().getImunisasi();
    setState(() {
      imunisasis = res.toList();
    });
  }

  bool isLoading = false;

  // HANDLE INPUT
  handleInput() async {
    setState(() {
      isLoading = true;
    });

    if (await PesertaService().periksaBalita(
      pesertaID: widget.balita.pesertaID.toString(),
      posyanduID: selectedPosyandu.toString(),
      periode: selectedPeriode.toString(),
      beratBadan: BBController.text,
      panjangBadan: PBController.text,
      lingkarKepala: LKController.text,
      lingkarLengan: LLController.text,
      asiEksklusif: selectedAsiEkslusif.toString(),
      imunisasiID: selectedImunisasi.toString(),
    )) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(
                    pageIndex: 2,
                  )),
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
    // INFORMASI BALITA
    Widget balita() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Informasi Balita",
              style: primaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 20),
            CustomFormField(
              readOnly: true,
              title: 'Nama',
              hint: 'Nama Balita',
              icon: 'assets/balita_icon.svg',
              controller: namaController,
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: true,
              title: 'NIK',
              hint: 'NIK balita',
              icon: 'assets/NIK_icon.svg',
              controller: NIKController,
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: true,
              title: 'Tanggal Lahir',
              hint: 'Tanggal Lahir Balita',
              icon: 'assets/date_icon.svg',
              controller: tglLhrController,
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: true,
              title: 'Tempat Lahir',
              hint: 'Tempat Lahir Balita',
              icon: 'assets/posyandu.svg',
              controller: tmpLhrController,
            ),
            SizedBox(height: 10),
            CustomFormField(
              readOnly: true,
              title: 'Jenis Kelamin',
              hint: 'Jenis Kelamin',
              icon: 'assets/jk-icon.svg',
              controller: JKController,
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    // KESEHATAN BALITA
    Widget kesehatan() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        width: double.infinity,
        height: 625,
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
                "Form Kesehatan Balita",
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
                hint: 'Panjang Badan',
                suffix: 'cm',
                controller: PBController,
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
              CustomFormFieldKesehatan(
                hint: 'Lingkar Kepala',
                suffix: 'cm',
                controller: LKController,
                validator: (value) {
                  // NULL
                  if (value!.isEmpty) {
                    return "";
                  }
                  return null;
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
                  'Asi Ekslusif',
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
                items: asiEkslusif
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
                  print(value);
                  if (value == 'Ya') {
                    selectedAsiEkslusif = 'true';
                  } else {
                    selectedAsiEkslusif = 'false';
                  }
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField2(
                decoration: InputDecoration(
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
                  'Jenis Imunisasi',
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
                items: imunisasis.map((item) {
                  return DropdownMenuItem<String>(
                    value: item.imunisasiID.toString(),
                    //disable default onTap to avoid closing menu when selecting an item
                    enabled: false,
                    child: StatefulBuilder(
                      builder: (context, menuSetState) {
                        final _isSelected = selectedImunisasi
                            .contains(item.imunisasiID.toString());
                        return InkWell(
                          onTap: () {
                            _isSelected
                                ? selectedImunisasi
                                    .remove(item.imunisasiID.toString())
                                : selectedImunisasi
                                    .add(item.imunisasiID.toString());
                            //This rebuilds the StatefulWidget to update the button's text
                            setState(() {});
                            //This rebuilds the dropdownMenu Widget to update the check mark
                            menuSetState(() {});
                          },
                          child: Container(
                            height: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                _isSelected
                                    ? const Icon(Icons.check_box_outlined)
                                    : const Icon(Icons.check_box_outline_blank),
                                const SizedBox(width: 16),
                                Text(
                                  item.imunisasi.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
                value:
                    selectedImunisasi.isEmpty ? null : selectedImunisasi.last,
                onChanged: (value) {},
                buttonWidth: double.infinity,
                itemHeight: 40,
                itemPadding: EdgeInsets.zero,
                selectedItemBuilder: (context) {
                  return imunisasis.map(
                    (item) {
                      return Container(
                        // alignment: AlignmentDirectional.topStart,
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Jenis Imunisasi',
                          style: const TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      );
                    },
                  ).toList();
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
    Widget loadingBtn() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: LoadingButton(),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          'Kesehatan Balita',
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    balita(),
                    kesehatan(),
                    isLoading ? loadingBtn() : button(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
