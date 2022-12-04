import 'dart:convert';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? telephone;
  String? cpf;
  String? password;
  String? zipCode;
  String? publicPlace;
  String? number;
  String? complement;
  String? city;
  String? district;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.cpf,
    this.password,
    this.zipCode,
    this.publicPlace,
    this.number,
    this.complement,
    this.city,
    this.district,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'telephone': telephone,
      'cpf': cpf,
      'password': password,
      'zip_code': zipCode,
      'public_place': publicPlace,
      'number': number,
      'complement': complement,
      'city': city,
      'district': district,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      name: map['name'],
      email: map['email'],
      telephone: map['telephone'],
      cpf: map['cpf'],
      password: map['password'],
      zipCode: map['zip_code'],
      publicPlace: map['public_place'],
      number: map['number'],
      complement: map['complement'],
      city: map['city'],
      district: map['district'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, telephone: $telephone, cpf: $cpf, password: $password, zipCode: $zipCode, publicPlace: $publicPlace, number: $number, complement: $complement, city: $city, district: $district)';
  }
}
