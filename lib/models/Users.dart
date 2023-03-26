class Cusers {
  String userName;
  String uid;
  String gsm;
  String role;
  String email;
  String profileUrl;
  List basket;

  Cusers(
      {required this.uid,
      required this.userName,
      required this.email,
      required this.gsm,
      required this.role,
      required this.basket,
      required this.profileUrl});

  factory Cusers.fromJson(Map<String, dynamic> json) {
    return Cusers(
      uid: json["uid"],
      userName: json["userName"],
      email: json["email"],
      role: json["role"],
      gsm: json["gsm"],
      profileUrl: json["profileUrl"],
      basket: json["basket"],
    );
  }
  Map<String, dynamic> Tojson() {
    return {"uid": uid, "userName": userName, "email": email, "role": role, "profileUrl": profileUrl, "gsm": gsm, "basket": []};
  }
}
