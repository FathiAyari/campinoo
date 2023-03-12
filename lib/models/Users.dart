class Cusers {
  String userName;
  String uid;
  String Gsm;

  String Role;
  String Email;
  String Url;
  List basket;

  /*


  * */
// from json to object cusers
  Cusers(
      {required this.uid,
      required this.userName,
      required this.Email,
      required this.Gsm,
      required this.Role,
      required this.basket,
      required this.Url});
  factory Cusers.fromJson(Map<String, dynamic> json) {
    return Cusers(
      uid: json["uid"],
      userName: json["userName"],
      Email: json["Email"],
      Role: json["Role"],
      Gsm: json["Gsm"],
      Url: json["Url"],
      basket: json["basket"],
    );
  }
// from object to json
  Map<String, dynamic> Tojson() {
    return {
      "uid": uid,
      "userName": userName,
      "Email": Email,
      "Role": Role,
      "Url": Url,
      "Gsm": Gsm,
      "basket": []
    };
  }
}
