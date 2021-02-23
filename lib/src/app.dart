import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/src/models/lang.dart';
import 'package:koompi_hotspot/src/utils/shortcut.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:koompi_hotspot/src/screen/web_view/captive_portal_web.dart';
import 'package:koompi_hotspot/src/utils/constants.dart' as global;

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
            '/walletScreen': (context) => WalletScreen(),
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
    _networkStatus.connectivitySubscription = _networkStatus.connectivity.onConnectivityChanged.listen((event) {
      setState(() {
        _networkStatus.connectivityResult = event;
      });
    });
  }

  errorApp() async{
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
    _networkStatus.connectivityResult != ConnectivityResult.none ? startTime() : errorApp();
  }

  getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      global.phone = prefs.getString('phone');
      global.password = prefs.getString('password');
    });
    print('${global.phone}');
    print('${global.password}');
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      getValue();
      internet();
      startApp(context);
    });
    initQuickActions();

    //Set Language
    setDefaultLang();
  }

  bool connectionStatus = false;

  Future check() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) 
      connectionStatus = true;
      print("connected $connectionStatus");
        }
      on SocketException catch (_) {
      connectionStatus = false;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CaptivePortalWeb()),
      );
    }
  }

  final quickActions = QuickActions();
  
  void initQuickActions() {
    quickActions.initialize((type) {
      if (type == null) return;

      if (type == ShortcutItems.actionCaptivePortal.type) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CaptivePortalWeb()),
        );
      }
    });

    quickActions.setShortcutItems(ShortcutItems.items);
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _networkStatus.connectivityResult == ConnectivityResult.wifi ? CaptivePortalWeb()
      :
      Center(
        child: FlareActor( 
          'assets/animations/koompi.flr', 
          animation: 'Splash_Loop',
        ),
      ) 
    );
  }
}