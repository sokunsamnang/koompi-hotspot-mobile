import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/services/services.dart';

class GetRequest with ChangeNotifier{

  String messageAlert;
  var _mData = new ModelUserData();
  ModelUserData get mUser => _mData;
  StorageServices _prefService = StorageServices();


  Future<void> getUserProfile(String _token) async {
    var response = await http.get("${ApiService.url}/dashboard", 
        headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + _token,
        //"token": _token,
    });
    var responseBody = json.decode(response.body);
    mData = ModelUserData.fromJson(responseBody);

    _mData = ModelUserData.fromJson(responseBody);
    _prefService.saveString('user', jsonEncode(responseBody));

    notifyListeners();
  }


}