import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/home_page_body.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  void iniState() {
    super.initState();
    setState(() {
      AppService.noInternetConnection();
    });
  }
  
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: SafeArea(
          child: bodyPage(context),
        ),
      ),  
    );   
  }
}