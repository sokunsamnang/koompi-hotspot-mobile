import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/index.dart';
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/models/model_wallet.dart';
import 'package:koompi_hotspot/src/services/services.dart';

class Balance{

  String timestamp;
  String balance = '';
  String otherassets;

  Map<String, dynamic> userBalance;
  
  Balance({
    this.timestamp,
    this.balance,
    this.otherassets,
  });

  Balance.fromJson(Map<String,dynamic> parseJson){
    timestamp= parseJson['timestamp'];
    balance = parseJson['balance'];
    otherassets = parseJson['otherassets'];
  }

}
  
Balance mBalance = Balance();

class BalanceProvider with ChangeNotifier{
  StorageServices _prefService = StorageServices();
  String alertText;

  
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
            if (mBalance.userBalance != null) mBalance.balance = '';
            mBalance = Balance.fromJson(responseBody);

            // Check Balance Retrieve NULL
            if (mBalance.userBalance != null)
              wallets[0].amount = mBalance.balance;
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