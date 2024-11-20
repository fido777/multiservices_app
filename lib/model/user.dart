import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'user.g.dart'; // This part directive is necessary

@HiveType(typeId: 1) // Ensure the typeId is unique across models
class User {
  @HiveField(0)
  String uuid;

  @HiveField(1)
  String name;

  @HiveField(2)
  String email;

  @HiveField(3)
  String city;

  @HiveField(4)
  String? phone;

  @HiveField(5)
  String? profession;

  @HiveField(6)
  String? imageUrl;

  User({
    required this.uuid,
    required this.name,
    required this.email,
    required this.city,
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

  User copyWith({
    String? uuid,
    String? name,
    String? email,
    String? city,
    ValueGetter<String?>? phone,
    ValueGetter<String?>? profession,
    ValueGetter<String?>? imageUrl,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      email: email ?? this.email,
      city: city ?? this.city,
      phone: phone != null ? phone() : this.phone,
      profession: profession != null ? profession() : this.profession,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
      'email': email,
      'city': city,
      'phone': phone,
      'profession': profession,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uuid: map['uuid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      city: map['city'] ?? '',
      phone: map['phone'],
      profession: map['profession'],
      imageUrl: map['imageUrl'],
    );
  }


  @override
  String toString() {
    return 'User(uuid: $uuid, name: $name, email: $email, city: $city, phone: $phone, profession: $profession, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
      other.uuid == uuid &&
      other.name == name &&
      other.email == email &&
      other.city == city &&
      other.phone == phone &&
      other.profession == profession &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      city.hashCode ^
      phone.hashCode ^
      profession.hashCode ^
      imageUrl.hashCode;
  }
}
