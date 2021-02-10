import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/models/lang.dart';
import 'package:provider/provider.dart';


class App extends StatelessWidget{
  Widget build (context){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LangProvider>(
          create: (context) => LangProvider(),
        ),
        ChangeNotifierProvider<BalanceProvider>(
          create: (context) => BalanceProvider(),
        ),
        ChangeNotifierProvider<TrxHistoryProvider>(
          create: (context) => TrxHistoryProvider()
        ),
        ChangeNotifierProvider<GetPlanProvider>(
          create: (context) => GetPlanProvider(),
        ),
      ],
      child: Consumer<LangProvider>(
        builder: (context, value, child) => MaterialApp(
          builder: (context, child) => ScrollConfiguration(
            behavior: ScrollBehavior()
              ..buildViewportChrome(context, child, AxisDirection.down),
            child: child,
          ),

          locale: value.manualLocale,
          supportedLocales: [
              const Locale('en', 'US'),
              const Locale('km', 'KH'),
            ],
          localizationsDelegates: [
            AppLocalizeService.delegate,
            //build-in localization for material wiidgets
            GlobalWidgetsLocalizations.delegate,

            GlobalMaterialLocalizations.delegate,
          ],
          initialRoute: '/',
          routes: {
            '/navbar': (context) => Navbar(),
            '/plan': (context) => UserPlan(),
            '/loginEmail':(context) => LoginPage(),
            '/loginPhone': (context) => LoginPhone(),
            '/welcome': (context) => WelcomeScreen(),
          },
          title: 'Koompi Hotspot',
          home: Splash(),
        ),
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

    // var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {// Not first time
      return isLoggedIn();
    } 
    else {// First time
      prefs.setBool('first_time', false);
      return navigationOnboardingScreen();
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

  void setDefaultLang() {
    var _lang = Provider.of<LangProvider>(context, listen: false);
    StorageServices().read('lang').then(
      (value) {
        _lang.setLocal(value, context);
      },
    );
  }

  void internet() async {
    _networkStatus.connectivityResult = await Connectivity().checkConnectivity();
    // _networkStatus.connectivitySubscription = _networkStatus.connectivity.onConnectivityChanged.listen((event) {
    //   setState(() {
    //     _networkStatus.connectivityResult = event;
    //   });
    // });
  }

  void errorApp() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You may lost the internet connect nor Error server or Server in maintenance'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => App()),
                  ModalRoute.withName('/'),
                );
              },
            ),
          ],
        );
      }
    );
  }

  Future <void> startApp(BuildContext context) async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Internet connected');
        startTime();
      }
    } on SocketException catch (_) {
      Navigator.pop(context);
      print('not connected');
      errorApp();
    }
  }
  
  @override
  void initState() {
    super.initState();

    setState(() {
      internet();
      startApp(context);
    });
  
    //Set Language
    setDefaultLang();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _networkStatus.connectivityResult != ConnectivityResult.none ? Center(
        child: FlareActor( 
          'assets/animations/koompi.flr', 
          animation: 'Splash_Loop',
        ),
      ) : _networkStatus.restartApp(context),
    );
  }
}