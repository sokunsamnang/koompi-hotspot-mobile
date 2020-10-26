import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/plan_view.dart';
import 'package:koompi_hotspot/src/screen/home/topup/topup.dart';
import 'package:koompi_hotspot/src/screen/home/topup/transfer_credit.dart';

Widget bodyPage(BuildContext context) {
  
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: _nameBar(context),
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Wallet', style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
              _balanceTokens(context),
            ],
          ),
        ),
        SizedBox(height: 40),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Your Plans', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: 20),
        Expanded(child: PlanView()),
      ],
    ),
  );
}


  Widget _nameBar(context) {

    String name = mData.name;

    return Row(
      children: <Widget>[
        CircleAvatar(
          // backgroundImage: image == null ? AssetImage('assets/images/avatar.png') : NetworkImage(image),
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        SizedBox(width: 15),
        Text( 
          name ?? 'KOOMPI',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent)),
      ],
    );
  }

Widget _balanceTokens(context) {
  return Container(
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(40)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .27,
          color: Colors.blueGrey[900],
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Total Balance,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '0.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                        
                      ),
                      Text(
                        ' \៛',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                      width: 120,
                      padding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: Colors.white, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FlatButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) => bottomBar(context),
                              );
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                 SizedBox(width: 5),
                                Text("Top up",
                                  style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: -170,
                top: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.lightBlueAccent[50],
                ),
              ),
              Positioned(
                left: -160,
                top: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.lightBlue[300],
                ),
              ),
              Positioned(
                right: -170,
                bottom: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.deepOrangeAccent,
                ),
              ),
              Positioned(
                right: -160,
                bottom: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.orangeAccent,
                ),
              )
            ],
          ),
        ),
      ),
    );
}

  Widget bottomBar(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 25,
        title: Text('Top Up/Transfer', style: TextStyle(color: Colors.black),),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5.0),
            child: GestureDetector(
              child: IconButton(
                iconSize: 35.0,
                icon: Icon(
                  Icons.cancel,
                  color: Colors.black,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            Container(
              height: 180,
              padding: EdgeInsets.only(top: 4),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/topup_Payment.jpg',
                    height: 500,
                    width: 260,
                    fit: BoxFit.fitWidth
                  ),
                ]
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ListTile(
                onTap: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TopUp()));
                },
                title: Text('Top up for my account',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: ListTile(
                onTap: () async {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => TransferCredit()));
                },
                title: Text('Transfer to a friend',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
      ),
    );
  }