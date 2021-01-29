// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromMap(jsonString);

import 'package:koompi_hotspot/all_export.dart';

ModelLogin modelLoginFromMap(String str) => ModelLogin.fromMap(json.decode(str));

String modelLoginToMap(ModelLogin data) => json.encode(data.toMap());

class ModelLogin {
    ModelLogin({
        this.email,
        this.password,
    });

    String email;
    String password;

    factory ModelLogin.fromMap(Map<String, dynamic> json) => ModelLogin(
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
    };
}
