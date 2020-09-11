import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/app.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageServices{

  static String _decode;
  static SharedPreferences _preferences;

  void clearPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('token');
  }

  void checkUser(BuildContext context) async {
    SharedPreferences isToken = await SharedPreferences.getInstance();

    String _token = isToken.getString('token');
    if (_token != null) {
      await GetRequest().getUserProfile(_token).then((value) {
        mData = value;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Navbar()));
    }
    else{
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
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

  Future<void> refreshUserData() async {
    SharedPreferences sharedUser = await SharedPreferences.getInstance();
      String jsonString;

      Map decodeOptions = jsonDecode(jsonString);
      String user = jsonEncode(ModelUserData.fromJson(decodeOptions));
      sharedUser.setString('user', user);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }
  
}