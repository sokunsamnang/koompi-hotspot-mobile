import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/home_page_body.dart';
import 'package:koompi_hotspot/src/services/updater.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  void initState() {
    try {
      print('run version check');
      versionCheck(context);
    } catch (e) {
      print(e);
    }
    super.initState();
  }
  
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: bodyPage(context),
          ),
        ),
    );   
  }
}