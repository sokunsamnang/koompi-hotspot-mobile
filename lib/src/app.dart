import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:koompi_hotspot/src/components/navbar.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_trx_history.dart';
import 'package:koompi_hotspot/src/screen/onboarding/onboarding_screen.dart';
import 'package:koompi_hotspot/src/services/network_status.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget{
  Widget build (context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BalanceProvider>(
          create: (context) => BalanceProvider(),
        ),
        ChangeNotifierProvider<TrxHistoryProvider>(
          create: (context) => TrxHistoryProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/navbar': (context) => Navbar(),
        },
        title: 'Koompi Hotspot',
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
    @override
    _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {

  NetworkStatus _networkStatus = NetworkStatus();

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
    setState(() {
      StorageServices().checkUser(context);
    });
  }
  
  void internet() async {
    _networkStatus.connectivityResult = await Connectivity().checkConnectivity();
    // _networkStatus.connectivitySubscription = _networkStatus.connectivity.onConnectivityChanged.listen((event) {
    //   setState(() {
    //     _networkStatus.connectivityResult = event;
    //   });
    // });
  }
  
  @override
  void initState() {
    setState(() {
      internet();
      startTime();
    });
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
    // setState(() {
    //   Provider.of<BalanceProvider>(context, listen: false).dispose();
    //   Provider.of<TrxHistoryProvider>(context, listen: false).dispose();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _networkStatus.connectivityResult != ConnectivityResult.none ? Center(
        child: FlareActor( 
          'assets/animations/splash_screen.flr', 
          animation: 'Splash_Loop',
        ),
      ) : _networkStatus.restartApp(context),
    );
  }
}