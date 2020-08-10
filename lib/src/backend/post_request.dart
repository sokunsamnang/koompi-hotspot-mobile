import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/component.dart';
import 'api_service.dart';

class PostRequest {

  Backend _backend = Backend();

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
}