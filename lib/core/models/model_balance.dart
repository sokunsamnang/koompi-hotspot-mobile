import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class BalanceModel {
  
  String id;
  String token;
  String symbol;

  BalanceModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data) {
    id = data['id'];
    token = data['token'];
    symbol = data['symbol'];
  }
}

class BalanceProvider with ChangeNotifier {
  Backend _backend;

  GetRequest _getRequest;

  List<BalanceModel> balanceList = [];


  Future<void> fetchPortfolio() async {
    StorageServices _prefService = StorageServices();

    _backend = Backend();
    _getRequest = GetRequest();
    balanceList = [];

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
          _backend.listData = responseBody;
          for (var l in _backend.listData) {
            balanceList.add(BalanceModel(l));
          }
        } else {
          var responseBody = json.decode(response.body);
          return responseBody;
        }
      });
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();


  //   // Fetch Balance
  //   await _getRequest.getPortfolio().then((value) {
  //     _backend.listData = json.decode(value.body);
  //     // _backend.listData = List<dynamic>.from(
  //     //   balanceList.map<dynamic>(
  //     //     (dynamic item) => value.body,
  //     //   ),
  //     // );
  //     if (_backend.listData.isEmpty)
  //       balanceList = null;
  //     else {
  //       for (var l in _backend.listData) {
  //         balanceList.add(BalanceModel(l));
  //       }
  //     }
  //   });

  //   notifyListeners();
  }
}
