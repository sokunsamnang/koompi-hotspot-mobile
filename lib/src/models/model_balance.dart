import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/index.dart';
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/models/model_wallet.dart';
import 'package:koompi_hotspot/src/services/services.dart';

// class Balance {
//   Balance({this.data});

//   Data data;

//   factory Balance.fromMap(Map<String, dynamic> json) => Balance(
//         data: Data.fromMap(json["data"]),
//       );
// }

// class Data {
//   Data({
//     this.timestamp,
//     this.balance,
//     this.otherassets,
//   });

//   String timestamp;
//   String balance = '';
//   String otherassets;

//   factory Data.fromMap(Map<String, dynamic> json) => Data(
//         timestamp: json["timestamp"],
//         balance: json["balance"],
//         otherassets: json["otherassets"],
//       );

//   Map<String, dynamic> toMap() => {
//         "timestamp": timestamp,
//         "balance": balance,
//         "otherassets": otherassets,
//       };
// }

// To parse this JSON data, do
//
//     final balance = balanceFromMap(jsonString);

class Balance {
    Balance({
        this.token,
        this.symbol,
    });

    double token;
    String symbol;

    factory Balance.fromJson(String str) => Balance.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Balance.fromMap(Map<String, dynamic> json) => Balance(
        token: json["token"].toDouble(),
        symbol: json["symbol"],
    );

    Map<String, dynamic> toMap() => {
        "token": token,
        "symbol": symbol,
    };
}


Balance mBalance = Balance();

class BalanceProvider with ChangeNotifier{
  StorageServices _prefService = StorageServices();
  String alertText;

  var _mData = new ModelUserData();
  ModelUserData get mData => _mData;
  
  Future<String> fetchPortforlio() async {
    // mBalance = Balance();
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response =
            await http.get('${ApiService.url}/selendra/portfolio', headers: <String, String>{
          "accept": "application/json",
          "authorization": "Bearer " + onValue,
        });

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          if (responseBody.containsKey('error')) {
            alertText = responseBody['error']['message'];
          } else {
            if (mBalance != null) mBalance.token.toString();
            mBalance = Balance.fromMap(responseBody);

            // Check Balance Retrieve NULL
            if (mBalance != null)
              wallets[0].amount = mBalance.token.toString();
            // notifyListeners();
          }

          alertText = response.statusCode.toString();
        } else {
          throw HttpException("${response.statusCode}");
        }
      });
    } catch (e) {
      // print(e.toString());
    }

    notifyListeners();
    return alertText ?? '';
  }
}