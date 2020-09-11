import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';

class GetRequest{

  String messageAlert;

  Future<ModelUserData> getUserProfile(String _token) async {
    var response = await http.get("${ApiService.url}/dashboard", 
        headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + _token,
        //"token": _token,
    });
    var responseBody = json.decode(response.body);
    mData = ModelUserData.fromJson(responseBody);
    return mData;
  }


}