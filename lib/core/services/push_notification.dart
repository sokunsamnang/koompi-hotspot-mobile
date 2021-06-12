// import 'package:koompi_hotspot/all_export.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationApp extends StatefulWidget {
//   const NotificationApp({ Key key }) : super(key: key);

//   @override
//   _NotificationAppState createState() => _NotificationAppState();
// }

// class _NotificationAppState extends State<NotificationApp> {

//   FlutterLocalNotificationsPlugin localNotification;

//   @override 
//   void initState(){
//     super.initState();
//     var androidInitialize = new AndroidInitializationSettings('ic_launcher');

//     // IOS
//     var iOSInitialize = new IOSInitializationSettings();
//     var initializationSettings = new InitializationSettings(
//       android: androidInitialize, iOS: iOSInitialize
//     );

//     localNotification = new FlutterLocalNotificationsPlugin();

//     localNotification.initialize(initializationSettings);


//   }


//   void _showNotification() async{
//     var androidDetails = new AndroidNotificationDetails(
//       'channelId', 
//       'title', 
//       'description',
//       importance: Importance.high
//     );

//     var iosDetails = new IOSNotificationDetails();
//     var generalNotificationDetails = new NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails
//     );
//     await localNotification.show(0, 'KOOMPI E13', 'Discount 30%', generalNotificationDetails);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('Click the button to alert Notification'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async{ 
//           _showNotification();
//          },
//         child: Icon(Icons.notifications),
//       )
//     );
//   }
// }
