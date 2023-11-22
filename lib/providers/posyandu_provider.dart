import 'package:flutter/material.dart';
import 'package:stunting/models/posyandu_model.dart';
import 'package:stunting/services/resource_service.dart';

class PosyanduProvider with ChangeNotifier {
  List<PosyanduModel> _posyandu = [];

  List<PosyanduModel> get posyandu => _posyandu;

  set posyandu(List<PosyanduModel> posyandu) {
    _posyandu = posyandu;
    notifyListeners();
  }

  Future<void> getPosyandu() async {
    try {
      List<PosyanduModel> posyandu = await ResourceService().getPosyandu();
      _posyandu = posyandu;
    } catch (e) {
      print(e);
    }
  }
}
