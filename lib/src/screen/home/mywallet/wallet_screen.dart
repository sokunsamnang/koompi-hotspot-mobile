import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/wallet_screen_body.dart';

class WalletScreen extends StatelessWidget {

  void initState(){}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // brightness: Brightness.light,
        title: Text('My Wallet', style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black, 
        ),
      ),
      body: Body(),
    );
  }
}
