class User {
  String uuid;
  String name;
  String email;
  String password;

  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        email = json['email'],
        password = json['password'];

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "email": email,
        "password": password,
      };
}
