import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stunting/models/peserta_model.dart';

class PesertaService {
  String baseUrl = 'https://undikshasehat.com/api';

  // GET IBU
  Future<List<PesertaModel>> getIbu({required String search}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/getIbu?nama=$search';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      var data = res['data'];
      List<PesertaModel> ibu = [];
      for (var item in data) {
        ibu.add(PesertaModel.fromJson(item));
      }

      return ibu;
    } else {
      throw Exception('Gagal Mendapatkan Data Ibu');
    }
  }

  // INPUT IBU
  Future<PesertaModel> inputIbu({
    required String nama,
    required String nik,
    required String tglLahir,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/inputIbu';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'nama': nama,
      'NIK': nik,
      'tanggalLahir': tglLahir,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      PesertaModel peserta = PesertaModel.fromJson(data['peserta']);
      return peserta;
    } else {
      throw Exception('Gagal Menyimpan Data');
    }
  }

  // INPUT IBU
  Future<bool> periksaIbu({
    required String pesertaID,
    required String posyanduID,
    required String periode,
    required String tekananDarah,
    required String lingkarPinggang,
    required String lingkarBokong,
    required String lingkarLengan,
    required String tinggiBadan,
    required String beratBadan,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/periksaIbu';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'pesertaID': pesertaID,
      'posyanduID': posyanduID,
      'periode': periode,
      'tekananDarah': tekananDarah,
      'lingkarPinggang': lingkarPinggang,
      'lingkarBokong': lingkarBokong,
      'lingkarLengan': lingkarLengan,
      'tinggiBadan': tinggiBadan,
      'beratBadan': beratBadan,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
      throw Exception('Gagal Menyimpan Data');
    }
  }

  // GET BALITA
  Future<List<PesertaModel>> getBalita({required String search}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/getBalita?nama=$search';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      var data = res['data'];
      List<PesertaModel> balita = [];
      for (var item in data) {
        balita.add(PesertaModel.fromJson(item));
      }

      return balita;
    } else {
      throw Exception('Gagal Mendapatkan Data Balita');
    }
  }

  // INPUT BALITA
  Future<PesertaModel> inputBalita({
    required String nama,
    required String nik,
    required String tglLahir,
    required String tmpLahir,
    required String jenisKelamin,
    required String ibuID,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/inputBalita';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'nama': nama,
      'NIK': nik,
      'tanggalLahir': tglLahir,
      'tempatLahir': tmpLahir,
      'jenisKelamin': jenisKelamin,
      'ibuID': ibuID,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      PesertaModel peserta = PesertaModel.fromJson(data['peserta']);
      return peserta;
    } else {
      throw Exception('Gagal Menyimpan Data');
    }
  }

  // PERIKSA BALITA
  Future<bool> periksaBalita({
    required String pesertaID,
    required String posyanduID,
    required String periode,
    required String beratBadan,
    required String panjangBadan,
    required String lingkarKepala,
    required String lingkarLengan,
    required String asiEksklusif,
    required String imunisasiID,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/periksaBalita';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'pesertaID': pesertaID,
      'posyanduID': posyanduID,
      'periode': periode,
      'beratBadan': beratBadan,
      'panjangBadan': panjangBadan,
      'lingkarKepala': lingkarKepala,
      'lingkarLengan': lingkarLengan,
      'asiEksklusif': asiEksklusif,
      'imunisasiID': imunisasiID,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(body);
    print('status code: ${response.statusCode} ');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
      throw Exception('Gagal Menyimpan Data');
    }
  }
}
