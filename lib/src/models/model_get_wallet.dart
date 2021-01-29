// To parse this JSON data, do
//
//     final getWallet = getWalletFromMap(jsonString);

import 'package:koompi_hotspot/all_export.dart';

class GetWallet {
    GetWallet({
        this.error,
    });

    Error error;

    factory GetWallet.fromJson(String str) => GetWallet.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetWallet.fromMap(Map<String, dynamic> json) => GetWallet(
        error: Error.fromMap(json["error"]),
    );

    Map<String, dynamic> toMap() => {
        "error": error.toMap(),
    };
}

class Error {
    Error({
        this.message,
    });

    String message;

    factory Error.fromJson(String str) => Error.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Error.fromMap(Map<String, dynamic> json) => Error(
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
    };
}
