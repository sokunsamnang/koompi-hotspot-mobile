class Balance {
  Balance({this.data});

  Data data;

  factory Balance.fromMap(Map<String, dynamic> json) => Balance(
        data: Data.fromMap(json["data"]),
      );
}

class Data {
  Data({
    this.timestamp,
    this.balance,
    this.otherassets,
  });

  String timestamp;
  String balance = '';
  String otherassets;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        timestamp: json["timestamp"],
        balance: json["balance"],
        otherassets: json["otherassets"],
      );

  Map<String, dynamic> toMap() => {
        "timestamp": timestamp,
        "balance": balance,
        "otherassets": otherassets,
      };
}

Balance mBalance = Balance();
