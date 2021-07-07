import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/all_export.dart';

class Balance {
  Balance({
    this.token,
    this.symbol,
    this.message
  });

  double token;
  String symbol;
  String message;

  factory Balance.fromJson(String str) => Balance.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Balance.fromMap(Map<String, dynamic> json) => Balance(
        token: json["token"].toDouble(),
        symbol: json["symbol"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "token": token,
        "symbol": symbol,
        "message": message,
      };
}

Balance mBalance = Balance();

class BalanceProvider with ChangeNotifier {
  StorageServices _prefService = StorageServices();
  String alertText;

  var _mData = new ModelUserData();
  ModelUserData get mData => _mData;

  Future<String> fetchPortforlio() async {
    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(
            Uri.parse('${ApiService.url}/selendra/portfolio'),
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          if (mBalance.token != null) mBalance.token.toString();
          mBalance = Balance.fromMap(responseBody);

          // Check Balance Retrieve NULL
          if (mBalance != null) wallets[0].amount = mBalance.token.toString();

          alertText = response.statusCode.toString();
        } else {
          mBalance = Balance();
          alertText = response.body;
          print('Error portfolio status: ${response.statusCode}');
        }
      });
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    return alertText ?? '';
  }
}
