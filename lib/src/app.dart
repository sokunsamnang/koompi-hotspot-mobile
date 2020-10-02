import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:koompi_hotspot/src/screen/onboarding/onboarding_screen.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget{
  Widget build (context){
    return MaterialApp(
      initialRoute: '/',
      title: 'Koompi Hotspot',
      home: Splash(),
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

    var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {// Not first time
      return new Timer(_duration, isLoggedIn);
    } 
    else {// First time
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationOnboardingScreen);
    }
  }

  // void navigationLoginPage() {
  //   Navigator.pushReplacement(context,
  //     MaterialPageRoute(builder: (context) => LoginPage())
  //   ); 
  // }

  void navigationOnboardingScreen() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => OnboardingScreen())
    ); 
  }

  void isLoggedIn() {
    StorageServices().checkUser(context);
  }

  @override
  void initState() {
    super.initState();
    startTime();
    //StorageServices().checkUser(context);
  }

  @override
  Widget build(BuildContext context) {
      return new Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: FlareActor( 
            'assets/animations/splash_screen.flr', 
            animation: 'Splash_Loop',
        ),
      ),
    );
  }
}