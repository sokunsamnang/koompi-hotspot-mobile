import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/component.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'api_service.dart';

class PostRequest with ChangeNotifier{

  Backend _backend = Backend();
  var _mUser = new ModelUserData();
  ModelUserData get mUser => _mUser;
  String alertText;
  StorageServices _storageServices = StorageServices();

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

  /* Change password user account */
  // Future<http.Response> changePassword(String email, String oldPassword, String newPassword) async {
  //   _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
  //     {
  //       "email": email,
  //       "old_password": oldPassword,
  //       "new_password": newPassword,
  //       }
  //   );
  //   _backend.response = await http.put('${ApiService.url}/reset-password/account', 
  //   headers: _backend.conceteHeader(null, null), 
  //   body: _backend.bodyEncode);
  //   return _backend.response;
  // }

  // Future<http.Response> changePassword(String oldPassword, String newPassword) async {
  //   _backend.bodyEncode = json.encode(/* Convert to Json Data ( String ) */
  //     {
  //       "old_password": oldPassword,
  //       "new_password": newPassword,
  //       }
  //   );
  //   _backend.response = await http.put('${ApiService.url}/change-password/account', 
  //   headers: <String, String>{
  //     "accept": "application/json",
  //     "content-type": "application/json",
  //     "authorization": "Bearer " + "${StorageServices.readToken()}",
  //   },
  //   body: _backend.bodyEncode);
  //   return _backend.response;
  // }

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

  /*Forgot Password Verification */
  Future<http.Response> forgotPasswordByEmail(String email) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
    });

    _backend.response = await http.post('${ApiService.url}/forgot-password', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  Future<http.Response> confirmCodeResetPassword(String email, String vCode) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
      "vCode": vCode
    });

    _backend.response = await http.post('${ApiService.url}/confirm-forgot-code', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  Future<http.Response> resetPassword(String email, String password) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
      "email": email,
      "new_password": password
    });

    _backend.response = await http.put('${ApiService.url}/reset-password', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  //Hotspot Plan

  Future<http.Response> buyHotspotPlan(String username, String password, String value) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
        "username": username,
        "password": password,
        "simultaneous": "2",
        "value": value,
    });

    _backend.response = await http.post('${ApiService.url}/hotspot/set-plan', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  Future<http.Response> resetHotspotPlan(String username, String value) async {
    _backend.bodyEncode = json.encode({ /* Convert to Json String */
        "username": username,
        "simultaneous": "2",
        "value": value,
    });

    _backend.response = await http.put('${ApiService.url}/hotspot/reset-plan', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  Future<http.Response> getWallet(String email) async {
    _backend.bodyEncode = json.encode({
      "email": email,
    });

    _backend.response = await http.post('${ApiService.url}/selendra/get-wallet', 
    headers: _backend.conceteHeader(null, null), 
    body: _backend.bodyEncode);

    print(_backend.response.body);
    return _backend.response;
  }

  // Future<String> getWallet(String email) async {
  //   await _storageServices.read('token').then((value) async {
  //     var response = await http.post('${ApiService.url}/selendra/get-wallet',
  //       headers: <String, String>{
  //         "accept": "application/json",
  //         "authorization": "Bearer " + value,
  //         "Content-Type": "application/json"
  //       },
  //       body: _backend.bodyEncode);
  //     var responseBody = json.decode(response.body);
  //     if (response.statusCode == 200) {
  //       try {
  //         alertText = responseBody['message'];
  //       } catch (e) {
  //         //var wallet = WalletResponse.fromJson(responseBody);
  //         print(e);
  //       }
  //     } else {
  //       alertText = responseBody['error']['message'];
  //     }
  //   });
  //   return alertText;
  // }

}

