class PesertaModel {
  int? pesertaID;
  String? nik;
  String? nama;
  String? tanggalLahir;
  String? tempatLahir;
  String? jenisKelamin;
  String? golonganDarah;
  String? ibuID;

  PesertaModel({
    required this.pesertaID,
    required this.nik,
    required this.nama,
    required this.tanggalLahir,
    required this.tempatLahir,
    required this.jenisKelamin,
    required this.golonganDarah,
    required this.ibuID,
  });

  PesertaModel.fromJson(Map<String, dynamic> json) {
    pesertaID = json['pesertaID'];
    nik = json['NIK'];
    nama = json['nama'];
    tanggalLahir = json['tanggalLahir'];
    tempatLahir = json['tempatLahir'];
    jenisKelamin = json['jenisKelamin'];
    golonganDarah = json['golonganDarah'];
    ibuID = json['ibuID'];
  }

  Map<String, dynamic> toJson() {
    return {
      'pesertaID': pesertaID,
      'NIK': nik,
      'nama': nama,
      'tanggalLahir': tanggalLahir,
      'tempatLahir': tempatLahir,
      'jenisKelamin': jenisKelamin,
      'golonganDarah': golonganDarah,
      'ibuID': ibuID,
    };
  }
}
