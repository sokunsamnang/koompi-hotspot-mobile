import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  // Future<void> configOneSignal() async {

  //   OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  //   /// Set App Id.
  //   OneSignal.shared.setAppId("05805743-ce69-4224-9afb-b2f36bf6c1db");

  //   /// Get the Onesignal userId and update that into the firebase.
  //   /// So, that it can be used to send Notifications to users later.̥
  //   final status = await OneSignal.shared.getDeviceState();
  //   final String osUserID = status.userId;
  //   // We will update this once he logged in and goes to dashboard.
  //   ////updateUserProfile(osUserID);
  //   // Store it into shared prefs, So that later we can use it.
  //   // Preferences.setOnesignalUserId(osUserID);

  //   print(osUserID);

  //   // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //   await OneSignal.shared.promptUserForPushNotificationPermission(
  //     fallbackToSettings: true,
  //   );

  //   // // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  //   // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   //     print("Accepted permission: $accepted");
  //   // });

  //   // // Navigator Handler
  //   // OneSignal.shared.setNotificationOpenedHandler((openedResult) async{

  //   //   await Provider.of<NotificationProvider>(context, listen: false).fetchNotification();

  //   //   globals.appNavigator.currentState.push(
  //   //     PageTransition(type: PageTransitionType.rightToLeft,
  //   //       child: NotificationScreen())
  //   //   );
  //   // });
  // }

  @override
  void initState() {
    super.initState();
    // configOneSignal();
    AppServices.noInternetConnection(globalKey);
    versionCheck(context);
  }

  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(LineIcons.bars),
          color: primaryColor,
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: RichText(
          text: TextSpan(
            text: 'KOOMPI ',
            style: GoogleFonts.nunito(
                fontSize: 18,
                letterSpacing: 1.0,
                textStyle: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700)),
            children: <TextSpan>[
              TextSpan(
                text: 'Fi-Fi',
                style: GoogleFonts.nunito(
                    textStyle: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w700)),
              )
            ],
          ),
        ),
        actions: [
          InkWell(
            child: Badge(
              elevation: 0,
              badgeColor: Colors.transparent,
              toAnimate: false,
              position: BadgePosition.topEnd(top: 0, end: -2.5),
              // animationDuration: Duration(milliseconds: 300),
              // animationType: BadgeAnimationType.slide,
              badgeContent: Container(
                height: 20,
                width: 20,
                child: FlareActor(
                  'assets/animations/notification_badge.flr',
                  animation: 'hasNotification',
                ),
              ),
              child: IconButton(
                  icon: Icon(Icons.notifications),
                  color: primaryColor,
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: NotificationScreen()));
                  }),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: NotificationScreen()));
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<GetPlanProvider>(context, listen: false)
              .fetchHotspotPlan();
          await Provider.of<TrxHistoryProvider>(context, listen: false)
              .fetchTrxHistory();
          await Provider.of<BalanceProvider>(context, listen: false)
              .fetchPortfolio();
          await Provider.of<NotificationProvider>(context, listen: false)
              .fetchNotification();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: bodyPage(context),
          ),
        ),
      ),
    );
  }
}
