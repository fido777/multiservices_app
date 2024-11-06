class User {
  String uuid;
  String name;
  String email;
  String? city;
  String? phone;
  String? profession;
  String? imageUrl;

  User({
    required this.uuid,
    required this.name,
    required this.email,
    this.city,
    this.phone,
    this.profession,
    this.imageUrl,
  });

  User.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'],
        name = json['name'],
        email = json['email'],
        city = json['city'],
        phone = json['phone'],
        profession = json['profession'],
        imageUrl = json['imageUrl']
        ;

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "name": name,
        "email": email,
        "city": city,
        "phone": phone,
        "profession": profession,
        "imageUrl": imageUrl,
      };
}
