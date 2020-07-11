import 'dart:async';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:koompi_hotspot/src/screen/onboarding/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget{
  Widget build (context){
    return MaterialApp(
      title: 'Koompi Hotspot',
      home: new Splash(),
    );
  }
}

class Splash extends StatefulWidget {
    @override
    _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    var _duration = new Duration(milliseconds: 200);

    if (firstTime != null && !firstTime) {// Not first time
      return new Timer(_duration, navigationLoginPage);
    } else {// First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationOnboardingScreen);
    }
  }

  void navigationLoginPage() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => LoginPage())
      ); 
  }

  void navigationOnboardingScreen() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => OnboardingScreen())
      ); 
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
      body: new Center(
          child: new Text('LOADING....!!!!'),
      ),
    );
  }
}