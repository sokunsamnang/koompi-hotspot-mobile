import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class PostRequest {

  Backend _backend = Backend();

  /*Login Account */
  Future<http.Response> userLogIn(String email, String password) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
      "password": password
    });

    _backend.response = await http.post('${ApiService.url}/auth/login', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  /* complete User Information */
  Future<http.Response> completeInfoUser(String email, String name, String gender, String birthdate, String address) async {
    _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
      {
        "name": name,
        "email": email,
        "gender": gender,
        "birthdate": birthdate,
        "address": address
        }
    );
    _backend.response = await http.put('${ApiService.url}/auth/complete-info', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);
    return _backend.response;
  }

  /*register account by email */
  Future<http.Response> signUpWithEmail(String email, String password) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
      "password": password
    });

    _backend.response = await http.post('${ApiService.url}/auth/register', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  // Confirm User Account By Phone Number
  Future<http.Response> confirmAccount(String email, String vCode) async {

    _backend.bodyEncode = json.encode({
      "email": email,
      "vCode": vCode
    });
    _backend.response = await http.post('${ApiService.url}/auth/confirm-email',
      headers: _backend.conceteHeader(null, null),
    );
    print(_backend.response.body);
    return _backend.response;
  }

}