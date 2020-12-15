import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';

class TrxHistoryModel {

  int amount;
  double fee;
  String id;
  String sender;
  String destination;
  String memo;
  String createdAt;
  TrxHistoryModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data){
    amount = data['amount'];
    fee = data['fee'];
    id =  data['id'];
    sender = data['sender'];
    destination =  data['destination'];
    memo = data['memo'];
    createdAt = data['created_at'];
  }
}


class TrxHistoryProvider with ChangeNotifier {
  Backend _backend;

  GetRequest _getRequest;

  List<TrxHistoryModel> trxHistoryList = [];

  TrxHistoryProvider() {
    fetchTrxHistory();
  }

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
