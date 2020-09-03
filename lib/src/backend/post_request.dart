import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/component.dart';
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
        "gender": gender,
        "email": email,
        "birthdate": birthdate,
        "adress": address
        }
    );
    _backend.response = await http.post('${ApiService.url}/auth/complete-info', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);
    return _backend.response;
  }

  /*register account by email */
  Future<http.Response> register(String email, String password) async {
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

}