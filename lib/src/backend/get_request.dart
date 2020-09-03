import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';

class GetRequest{

  String messageAlert;
  Backend _backend = Backend();

  Future<void> getUserName(String _token) async {
    var response = await http.get("${ApiService.url}/dashboard", 
        headers: <String, String>{
        "accept": "application/json",
        "authorization": "Bearer " + _token,
        //"token": _token,
    });
    var responseBody = json.decode(response.body);
    mData = ModelUserData.fromJson(responseBody);
  }

  // Confirm User Account By Phone Number
  Future<http.Response> confirmAccount(String email, String vCode) async {

    _backend.bodyEncode = json.encode({
      "email": email,
      "vCode": vCode
    });
    _backend.response = await http.get(
      "${ApiService.url}/auth/confirm-code",
      headers: _backend.conceteHeader(null, null),
    );
    return _backend.response;
  }
}