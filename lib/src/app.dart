import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
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

  errorApp(){
    const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

    String selectedUrl = 'https://hotspot.koompi.pi/hotspotlogin.php?res=notyet&uamip=172.16.1.1&uamport=3990&challenge=f936c0e792ae3f1db35e6e06fc68cfd3&called=01&mac=1E-37-D9-31-D3-F1&ip=172.16.1.3&ssid=Koompi-wifi&nasid=nas01&sessionid=161337035000000002&userurl=http%3A%2F%2Fconnectivitycheck.gstatic.com%2Fgenerate_204&md=0FFDFBFEC402CDD0144EE653B79C7FD5';

    // ignore: prefer_collection_literals
    final Set<JavascriptChannel> jsChannels = [
      JavascriptChannel(
          name: 'Print',
          onMessageReceived: (JavascriptMessage message) {
            print('Logs: ${message.message}');
          }),
    ].toSet();
    final flutterWebViewPlugin = FlutterWebviewPlugin();
    return WillPopScope(
      onWillPop: () async{
        dispose();
        return Navigator.canPop(context);
      },
      child: WebviewScaffold(
        url: selectedUrl,
        withJavascript: true,
        javascriptChannels: jsChannels,
        userAgent: kAndroidUserAgent,
        withLocalUrl: true,
        allowFileURLs: true,
        withLocalStorage: true,
        hidden: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Hotspot Login', style: TextStyle(color: Colors.black, fontFamily: 'Medium')),
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  dispose();
                  Navigator.pop(context);
                });
          }),
        ),
        ignoreSSLErrors: true,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  flutterWebViewPlugin.goBack();
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  flutterWebViewPlugin.goForward();
                },
              ),
              IconButton(
                icon: const Icon(Icons.autorenew),
                onPressed: () {
                  flutterWebViewPlugin.reload();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future <void> startApp(BuildContext context) async{
    _networkStatus.connectivityResult != ConnectivityResult.none ? startTime() : errorApp();
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
      ) 
      : 
      errorApp(),  
    );
  }
}