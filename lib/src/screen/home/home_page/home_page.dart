import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/home_page_body.dart';
import 'package:koompi_hotspot/src/services/updater.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  void initState() {
    try {
      setState(() {
        Provider.of<BalanceProvider>(context, listen: false).fetchPortforlio();
      });
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