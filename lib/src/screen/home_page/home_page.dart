import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/home_page/home_page_body.dart';

class HomePage extends StatefulWidget{
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

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