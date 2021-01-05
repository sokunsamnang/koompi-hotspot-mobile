import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/services/services.dart';

class GetRequest with ChangeNotifier{

  String alertText;
  var _mData = new ModelUserData();
  ModelUserData get mUser => _mData;
  var _mBalance = new Balance();
  Balance get mBlanace => _mBalance;
  StorageServices _prefService = StorageServices();
  Backend _backend = Backend();


  Future<http.Response> getUserProfile(String _token) async {
    var response = await http.get("${ApiService.url}/dashboard", 
        headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + _token,
    });
    var responseBody = json.decode(response.body);
    mData = ModelUserData.fromJson(responseBody);

    _mData = ModelUserData.fromJson(responseBody);
    // _prefService.saveString('user', jsonEncode(responseBody));

    return response;
  }



  Future<http.Response> getWallet() async {
    /* Expired Token In Welcome Screen */
    await _prefService.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await http.get("${ApiService.url}/selendra/get-wallet",
      headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

  // Future<http.Response> getPortfolio(String _token) async {
  //    var response = await http.get("${ApiService.url}/selendra/portfolio", 
  //       headers: <String, String>{
  //       "accept": "application/json",
  //       "authorization": "Bearer " + _token,
  //   });
  //   var responseBody = json.decode(response.body);
  //   mBalance = Balance.fromJson(responseBody);

  //   _mBalance = Balance.fromJson(responseBody);
  //   return response;
  // }
  
  // Future<http.Response> getTrxHistory() async {
  //   String token = await StorageServices().read('token');
  //   if (token != null) {
  //     _backend.response = await http.get("${ApiService.url}/selendra/history",
  //       headers: _backend.conceteHeader("authorization", "Bearer $token"));
  //     return _backend.response;
  //   }
  //   return null;
  // }

  Future<http.Response> getTrxHistory() async {
    /* Expired Token In Welcome Screen */
    await _prefService.read('token').then((value) {
      _backend.token = Map<String, dynamic>.from({"token": value});
    });
    if (_backend.token != null) {
      _backend.response = await http.get("${ApiService.url}/selendra/history",
      headers: _backend.conceteHeader("authorization", "Bearer ${_backend.token['token']}"));
      return _backend.response;
    }
    return null;
  }

}