import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/app.dart';
import 'ui/utils/globals.dart' as globals;

Future <void> main() async{

  globals.appNavigator = GlobalKey<NavigatorState>();

  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp();


  runApp(App());

}
