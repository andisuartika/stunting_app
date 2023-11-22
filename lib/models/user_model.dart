class UserModel {
  int? id;
  String? name;
  String? email;
  String? posyanduID;
  String? access;
  String? profilePhotoPath;
  String? profilePhotoUrl;
  String? token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.posyanduID,
    required this.access,
    required this.profilePhotoPath,
    required this.profilePhotoUrl,
    required this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    posyanduID = json['posyanduID'];
    access = json['access'];
    profilePhotoPath = json['profile_photo_path'];
    profilePhotoUrl = json['profile_photo_url'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'posyanduID': posyanduID,
      'access': access,
      'profile_photo_path': profilePhotoPath,
      'profile_photo_url': profilePhotoUrl,
      'token': token,
    };
  }
}
