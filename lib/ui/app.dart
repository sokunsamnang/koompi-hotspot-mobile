import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/lang.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/core/models/vote_result.dart';
import 'package:koompi_hotspot/ui/utils/shortcut.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:koompi_hotspot/ui/screen/web_view/captive_portal_web.dart';
import 'package:koompi_hotspot/ui/utils/auto_login_hotspot_constants.dart'
    as global;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:koompi_hotspot/ui/utils/globals.dart' as globals;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  Widget build(context) {
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
            create: (context) => TrxHistoryProvider()),
        ChangeNotifierProvider<GetPlanProvider>(
          create: (context) => GetPlanProvider(),
        ),
        ChangeNotifierProvider<NotificationProvider>(
          create: (context) => NotificationProvider(),
        ),
        ChangeNotifierProvider<VoteResultProvider>(
          create: (context) => VoteResultProvider(),
        ),
      ],
      child: Consumer<LangProvider>(
        builder: (context, value, child) => MaterialApp(
          // builder: (context, child) => ScrollConfiguration(
          //   behavior: ScrollBehavior()
          //     ..buildViewportChrome(context, child, AxisDirection.down),
          //   child: child,
          // ),
          builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget),
            maxWidth: 2460,
            minWidth: 425,
            defaultScale: true,
            breakpoints: [
              ResponsiveBreakpoint.autoScale(425, name: MOBILE),
              ResponsiveBreakpoint.autoScale(800, name: TABLET),
              ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
              ResponsiveBreakpoint.autoScale(2460, name: '4K'),
            ],
          ),
          locale: value.manualLocale,
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('km', 'KH'),
          ],
          localizationsDelegates: [
            AppLocalizeService.delegate,
            //build-in localization for material widgets
            GlobalWidgetsLocalizations.delegate,

            GlobalMaterialLocalizations.delegate,
          ],
          initialRoute: '/',
          navigatorKey: globals.appNavigator,
          routes: {
            '/navbar': (context) => Navbar(0),
            '/plan': (context) => HotspotPlan(),
            // '/loginEmail':(context) => LoginPage(),
            '/loginPhone': (context) => LoginPhone(),
            // '/welcome': (context) => WelcomeScreen(),
            '/walletScreen': (context) => WalletScreen(),
          },
          title: 'KOOMPI Fi-Fi',
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
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    // var _duration = new Duration(seconds: 3);

    if (firstTime != null && !firstTime) {
      // Not first time
      return isLoggedIn();
    } else {
      // First time
      prefs.setBool('first_time', false);
      return navigationOnboardingScreen();
    }
  }

  void navigationOnboardingScreen() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: IntroScreen(),
      ),
    );

    // Navigator.pushReplacement(context,
    //   MaterialPageRoute(builder: (context) => IntroScreen())
    // );
  }

  void isLoggedIn() async {
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
    configOneSignal();
    setState(() {
      isInternet();
      getValue();
      startTime();
    });
    initQuickActions();

    //Set Language
    setDefaultLang();
  }

  final quickActions = QuickActions();

  void initQuickActions() {
    quickActions.initialize((type) {
      if (type == null) return;

      if (type == ShortcutItems.actionCaptivePortal.type) {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: CaptivePortalWeb(),
          ),
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => CaptivePortalWeb()),
        // );
      }
    });

    quickActions.setShortcutItems(ShortcutItems.items);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void configOneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    /// Set App Id.
    OneSignal.shared.init("05805743-ce69-4224-9afb-b2f36bf6c1db", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
  }

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        print('Mobile data detected & internet connection confirmed.');
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        print('Mobile data detected but no internet connection found.');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      print(
          'I am connected to a WIFI network, make sure there is actually a net connection.');
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        print('Wifi detected & internet connection confirmed.');
        return true;
      } else {
        // Wifi detected but no internet connection found.
        print('Wifi detected but no internet connection found.');

        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: CaptivePortalWeb(),
          ),
        );

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => CaptivePortalWeb()),
        // );
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      print(
          'Neither mobile data or WIFI detected, not internet connection found.');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0caddb),
      body: Center(
        child: FlareActor(
          'assets/animations/koompi_splash_screen.flr',
          animation: 'Splash_Loop',
        ),
      ),
    );
  }
}
