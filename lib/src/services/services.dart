import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:koompi_hotspot/src/services/jtw_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices{

  static String _decode;
  static SharedPreferences _preferences;
  bool status;


  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }

  checkUser(BuildContext context) async {
    SharedPreferences isToken = await SharedPreferences.getInstance();
    String token = isToken.getString('token');

    if(JwtDecoder.isExpired(token) == true || token == null){
      print('token expired');
      clear('token'); 
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/'),
      );
    }
    else if (JwtDecoder.isExpired(token) == false ) {
      print('token not expire');
      await GetRequest().getUserProfile(token);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Navbar()));
    }
    else{
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  // void checkUser(BuildContext context) {
  //   try {
  //     read('token').then(
  //       (value) async {
  //         String token = value;
  //         var resposne = await GetRequest().getUserProfile(token);
  //         print('Status Code Response: ${resposne.statusCode}');
  //         if(JwtDecoder.isExpired(token) == true || token == null){
  //           print('Failed: ${resposne.statusCode}');
  //           StorageServices().clear('token');
  //           Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => LoginPage()));
  //         }
  //         else if (resposne.statusCode == 200) {
            
  //           print('Success: ${resposne.statusCode}');
  //           Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => Navbar()));
  //         }
  //       },
  //     );
  //   } catch (e) {
  //   }
  // }
  
  void updateUserData(BuildContext context) {
    read('token').then(
      (value) async {
        String _token = value;
        if (_token != null) {
          await GetRequest().getUserProfile(_token);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Navbar()),
            ModalRoute.withName('/'),
          );
        }
      },
    );
  }



  static Future<SharedPreferences> setData(dynamic _data, String _path) async {
    _preferences = await SharedPreferences.getInstance();
    _decode = jsonEncode(_data);
    _preferences.setString(_path, _decode);
    return _preferences;
  }

  static Future<dynamic>fetchData(String _path) async {
    _preferences = await SharedPreferences.getInstance();
    var _data = _preferences.getString(_path);
    if ( _data == null ) return null;
    else {
      return json.decode(_data);
    }
  }



  Future<String> read(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String value = pref.getString(key);
    return value;
  }

  saveString(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  clear(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }
  
}


