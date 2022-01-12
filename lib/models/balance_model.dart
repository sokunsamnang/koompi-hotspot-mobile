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
