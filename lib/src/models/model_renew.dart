// To parse this JSON data, do
//
//     final renewOption = renewOptionFromMap(jsonString);

import 'dart:convert';

class RenewOption {
    RenewOption({
        this.automatically,
    });

    bool automatically;

    factory RenewOption.fromJson(String str) => RenewOption.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RenewOption.fromMap(Map<String, dynamic> json) => RenewOption(
        automatically: json["automatically"],
    );

    Map<String, dynamic> toMap() => {
        "automatically": automatically,
    };
}
