class PosyanduModel {
  String? posyanduID;
  String? namaPosyandu;
  String? desa;

  PosyanduModel({
    required this.posyanduID,
    required this.namaPosyandu,
    required this.desa,
  });

  PosyanduModel.fromJson(Map<String, dynamic> json) {
    posyanduID = json['posyanduID'];
    namaPosyandu = json['namaPosyandu'];
    desa = json['desa']['namaDesa'];
  }

  Map<String, dynamic> toJson() {
    return {
      'posyanduID': posyanduID,
      'namaPosyandu': namaPosyandu,
      'desa': desa,
    };
  }
}
