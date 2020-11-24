import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
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

  // NetworkStatus _networkStatus = NetworkStatus();

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

  void navigationOnboardingScreen() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => OnboardingScreen())
    ); 
  }

  void isLoggedIn() async{
    StorageServices().checkUser(context);
  }
  

  @override
  void initState() {
    super.initState();
    setState(() {
      startTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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