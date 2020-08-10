import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/backend/get_request.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/home_page_body.dart';

class HomePage extends StatefulWidget{

  final String name;
  HomePage(this.name);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  String token;

  void iniState() {
    super.initState();
    GetRequest().getUserName(token);
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