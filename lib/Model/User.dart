class User{
  int? id;
  String name;
  String eMail;
  String pass;
  bool yetgi;

  User({
    this.id,
    required this.name,
    required this.eMail,
    required this.pass,
    required this.yetgi
    });
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json["id"]!=null? int.parse(json["id"]): 0,
      name: json["name"] as String,
      eMail: json["eMail"] as String,
      yetgi: json["yetgi"]??false,
      pass: '',
    );
  }

  Map<String, dynamic> toJson() => {
    'eMail': eMail,
    'pass': pass,
    'name': name
  };

}