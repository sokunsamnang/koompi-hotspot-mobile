import 'package:koompi_hotspot/all_export.dart';
import 'package:http/http.dart' as http;

class TrxHistoryModel {
  String id;
  String hash;
  String sender;
  String destination;
  String amount;
  String fee;
  String symbol;
  String memo;
  String datetime;
  TrxHistoryModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data) {
    id = data['tx_id'];
    hash = data['hash'];
    sender = data['sender'];
    destination = data['destination'];
    amount = data['amount'];
    fee = data['fee'];
    symbol = data['symbol'];
    memo = data['memo'];
    datetime = data['datetime'];
  }
}

class TrxHistoryProvider with ChangeNotifier {
  Backend _backend;

  GetRequest _getRequest;

  List<TrxHistoryModel> trxHistoryList = [];

  // TrxHistoryProvider() {
  //   fetchTrxHistory();
  // }


  Future<void> fetchTrxHistory() async {
    StorageServices _prefService = StorageServices();

    _backend = Backend();
    _getRequest = GetRequest();
    trxHistoryList = [];

    try {
      await _prefService.read('token').then((onValue) async {
        http.Response response = await http.get(
            Uri.parse('${ApiService.url}/selendra/history'),
            headers: <String, String>{
              "accept": "application/json",
              "authorization": "Bearer " + onValue,
            });

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);
          _backend.listData = responseBody;
          if (_backend.listData.isEmpty)
            trxHistoryList = null;
          else {
            for (var l in _backend.listData) {
              trxHistoryList.add(TrxHistoryModel(l));
            }
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

  }
  
  // Future<void> fetchTrxHistory() async {
  //   _backend = Backend();
  //   _getRequest = GetRequest();
  //   trxHistoryList = [];

  //   // Fetch History
  //   await _getRequest.getTrxHistory().then((value) {
  //     _backend.listData = json.decode(value.body);
      // if (_backend.listData.isEmpty)
      //   trxHistoryList = null;
      // else {
      //   for (var l in _backend.listData) {
      //     trxHistoryList.add(TrxHistoryModel(l));
      //   }
      // }
  //   });

  //   notifyListeners();
  // }
}
