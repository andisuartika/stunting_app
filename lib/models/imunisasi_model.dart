class ImunisasiModel {
  String? imunisasiID;
  String? imunisasi;
  String? type;

  ImunisasiModel({
    required this.imunisasiID,
    required this.imunisasi,
    required this.type,
  });

  ImunisasiModel.fromJson(Map<String, dynamic> json) {
    imunisasiID = json['imunisasiID'];
    imunisasi = json['imunisasi'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'imunisasiID': imunisasiID,
      'imunisasi': imunisasi,
      'type': type,
    };
  }
}
