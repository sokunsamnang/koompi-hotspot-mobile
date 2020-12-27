import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/home_page_body.dart';
import 'package:koompi_hotspot/src/screen/option_page/myaccount.dart';
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () async{
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccount()));
              },
              child: CircleAvatar(
                // backgroundImage: image == null ? AssetImage('assets/images/avatar.png') : NetworkImage(image),
                backgroundImage: AssetImage('assets/images/avatar.png'),
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
                  TextSpan(text: 'Wi-Fi', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.notifications), onPressed: null)
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: bodyPage(context),
          ),
        ),
    );   
  }
}