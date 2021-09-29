import 'package:koompi_hotspot/all_export.dart';

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
    _backend = Backend();
    _getRequest = GetRequest();
    trxHistoryList = [];

    // Fetch History
    await _getRequest.getTrxHistory().then((value) {
      _backend.listData = json.decode(value.body);
      if (_backend.listData.isEmpty)
        trxHistoryList = null;
      else {
        for (var l in _backend.listData) {
          trxHistoryList.add(TrxHistoryModel(l));
        }
      }
    });

    notifyListeners();
  }
}
