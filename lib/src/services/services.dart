import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/app.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      await GetRequest().getUserProfile(_token);
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


class AppServices {

  static int myNumCount = 0;

  static Future noInternetConnection(GlobalKey<ScaffoldState> globalKey) async {
    try {
      Connectivity _connectivity = new Connectivity();
      final myResult = await _connectivity.checkConnectivity();
      _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          mySnackBar(globalKey, "Something wrong with your connection ");
        } else {
          globalKey.currentState.removeCurrentSnackBar();
        }
      });
      if (myResult == ConnectivityResult.none) {
        mySnackBar(globalKey, "Something wrong with your connection ");
      }
    } catch (e) {}
  }

  static void mySnackBar(GlobalKey<ScaffoldState> globalKey, String content) {
    globalKey.currentState.showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(days: 365),
      backgroundColor: Colors.red,
      content: Text(content,
        style: TextStyle(
          color: Colors.white,
        )
      ),
      action: SnackBarAction(
        label: "Close",
        textColor: Colors.white,
        onPressed: () {
          globalKey.currentState.removeCurrentSnackBar();
        },
      ),
    ));
  }

  static void clearStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  // Remove Zero At The Position Of Phone Number
  static String removeZero(String number){
    return number.replaceFirst("0", "", 0);
  }

  static double getRadienFromDegree(double degree){
    double unitRadien = 57.295779513;
    return degree / unitRadien;
  }

  static Timer appLifeCycle(Timer timer){
    return timer;
  }

  static Map<String, dynamic> emptyMapData(){
    return Map<String, dynamic>.unmodifiable({});
  }
  
  static void timerOutHandler(http.Response res, Function counter) async {
    Timer.periodic(Duration(seconds: 1), (Timer timer){
      if (timer.tick <= 10) counter(timer);
      else if (timer.tick > 10) timer.cancel();
    });
  }
  
}

