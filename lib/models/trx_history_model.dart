class TrxHistoryModel {
  String hash;
  String sender;
  String destination;
  String amount;
  String fee;
  String symbol;
  String memo;
  String datetime;
  String from;
  String to;
  TrxHistoryModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data) {
    hash = data['hash'];
    sender = data['sender'];
    destination = data['destination'];
    amount = data['amount'];
    fee = data['fee'];
    symbol = data['symbol'];
    memo = data['memo'];
    datetime = data['datetime'];
    from = data['fromname'];
    to = data['toname'];
  }
}
