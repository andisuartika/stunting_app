class ResourceModel {
  int? balita;
  int? ibu;

  ResourceModel({
    required this.balita,
    required this.ibu,
  });

  ResourceModel.fromJson(Map<String, dynamic> json) {
    balita = json['balita'];
    ibu = json['ibu'];
  }

  Map<String, dynamic> toJson() {
    return {
      'balita': balita,
      'ibu': ibu,
    };
  }
}
