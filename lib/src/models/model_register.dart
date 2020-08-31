// To parse this JSON data, do
//
//     final registerModel = registerModelFromMap(jsonString);

import 'dart:convert';

RegisterModel registerModelFromMap(String str) => RegisterModel.fromMap(json.decode(str));

String registerModelToMap(RegisterModel data) => json.encode(data.toMap());

class RegisterModel {
    RegisterModel({
        this.name,
        this.gender,
        this.email,
        this.password,
        this.birthdate,
        this.address,
    });

    String name;
    String gender;
    String email;
    String password;
    String birthdate;
    String address;

    factory RegisterModel.fromMap(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        gender: json["gender"],
        email: json["email"],
        password: json["password"],
        birthdate: json["birthdate"],
        address: json["address"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "gender": gender,
        "email": email,
        "password": password,
        "birthdate": birthdate,
        "address": address,
    };
}
