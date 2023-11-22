import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stunting/models/imunisasi_model.dart';
import 'package:stunting/models/peserta_model.dart';
import 'package:stunting/models/posyandu_model.dart';
import 'package:stunting/models/resource_model.dart';

class ResourceService {
  String baseUrl = 'https://undikshasehat.com/api';

  // GET POSYANDU
  Future<List<PosyanduModel>> getPosyandu() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/puskesmas';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      var data = res['data'];
      List<PosyanduModel> posyandu = [];
      for (var item in data) {
        posyandu.add(PosyanduModel.fromJson(item));
      }

      return posyandu;
    } else {
      throw Exception('Gagal Mendapatkan Posyandu');
    }
  }

  // GET IMUNISASI
  Future<List<ImunisasiModel>> getImunisasi() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/imunisasi';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      var data = res['data'];
      List<ImunisasiModel> imunisasi = [];
      for (var item in data) {
        imunisasi.add(ImunisasiModel.fromJson(item));
      }

      return imunisasi;
    } else {
      throw Exception('Gagal Mendapatkan Imunisasi');
    }
  }

  // GET INFORMATION
  Future<ResourceModel> getInformation() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token').toString();

    var url = '$baseUrl/information';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      ResourceModel data = ResourceModel.fromJson(res['data']['data']);
      return data;
    } else {
      throw Exception('Gagal Mendapatkan Imunisasi');
    }
  }
}
