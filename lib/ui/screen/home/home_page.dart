import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/core/models/model_notification.dart';
import 'package:koompi_hotspot/ui/screen/notification/notification_screen.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:koompi_hotspot/ui/utils/globals.dart' as globals;

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Future<void> configOneSignal() async {

    OneSignal.shared.setAppId("05805743-ce69-4224-9afb-b2f36bf6c1db");
    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
        print("Accepted permission: $accepted");
    });

    // Navigator Handler 
    OneSignal.shared.setNotificationOpenedHandler((openedResult) async{
      
      await Provider.of<NotificationProvider>(context, listen: false).fetchNotification();

      globals.appNavigator.currentState.push(
        PageTransition(type: PageTransitionType.rightToLeft, 
          child: NotificationScreen())
      );
    });
  }


  @override
  void initState() {
    configOneSignal();
    AppServices.noInternetConnection(globalKey);
    versionCheck(context);
    super.initState();
  }


  void dispose(){
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async{
                Navigator.push(
                  context, 
                  PageTransition(type: PageTransitionType.bottomToTop, 
                    child: MyAccount(),
                  )
                );
              },
              child: CircleAvatar(
                backgroundImage: mData.image == null
                  ? AssetImage('assets/images/avatar.png')
                  : NetworkImage("${ApiService.getAvatar}/${mData.image}"),
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'KOOMPI ',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Poppins-Bold",
                  fontSize: 18,
                  letterSpacing: 1.0),
                children: <TextSpan>[
                  TextSpan(text: 'Fi-Fi', style: TextStyle(color: Color(0xff0caddb),fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            // Badge(
            //   position: BadgePosition.topEnd(top: 10, end: 10),
            //   badgeContent: null,
            //   child: IconButton(
            //     icon: Icon(Icons.menu),
            //     onPressed: () {},
            //   ),
            // ),
            Badge(
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
                color: Colors.grey,
                onPressed: (){
                  Navigator.push(
                    context, 
                    PageTransition(type: PageTransitionType.rightToLeft, 
                      child: NotificationScreen()));
                }
              ),
            ),
            // Badge(
              // badgeContent: FlareActor( 
              //   'assets/animations/notification_badge.flr', 
              //   animation: 'hasNotification',
              // ),
              // child: IconButton(
              //   icon: Icon(Icons.notifications), 
              //   color: Colors.grey,
              //   onPressed: (){
              //     Navigator.push(
              //       context, 
              //       PageTransition(type: PageTransitionType.rightToLeft, 
              //         child: NotificationScreen()));
              //   }
              // ),
            // ),    
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          await Provider.of<GetPlanProvider>(context, listen: false).fetchHotspotPlan();
          await Provider.of<TrxHistoryProvider>(context, listen: false).fetchTrxHistory();
          await Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
          await Provider.of<NotificationProvider>(context, listen: false).fetchNotification();
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