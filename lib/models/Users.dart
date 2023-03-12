class Cusers {
  String userName;
  String uid;
  String Gsm;
  String role;
  String email;
  String imageUrl;
  List basket;

  Cusers(
      {required this.uid,
      required this.userName,
      required this.email,
      required this.Gsm,
      required this.role,
      required this.basket,
      required this.imageUrl});

  factory Cusers.fromJson(Map<String, dynamic> json) {
    return Cusers(
      uid: json["uid"],
      userName: json["userName"],
      email: json["email"],
      role: json["role"],
      Gsm: json["Gsm"],
      imageUrl: json["imageUrl"],
      basket: json["basket"],
    );
  }
  Map<String, dynamic> Tojson() {
    return {"uid": uid, "userName": userName, "email": email, "role": role, "imageUrl": imageUrl, "Gsm": Gsm, "basket": []};
  }
}
