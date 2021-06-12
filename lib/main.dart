import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'ui/app.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  // AwesomeNotifications().initialize(
  //   'resource://drawable/ic_launcher',
  //   [
  //     NotificationChannel(
  //       channelKey: 'push_notification',
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic tests',
  //       defaultColor: Color(0xFF9D50DD),
  //       ledColor: Colors.white,
  //       importance: NotificationImportance.High,
  //       playSound: true,
  //       enableLights: true,
  //       enableVibration: true,
  //     )
  //   ]
  // );

  // AwesomeNotifications().createNotificationFromJsonData(mapData);

  runApp(App());

}
