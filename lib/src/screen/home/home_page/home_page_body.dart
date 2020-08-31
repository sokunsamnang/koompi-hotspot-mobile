import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/plan_view.dart';
import 'package:koompi_hotspot/src/screen/option_page/topup.dart';

Widget bodyPage(BuildContext context) {
  
  return Scaffold(
    body: SafeArea(
      child: Container(
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
      ),
    ),
  );
}


  Widget _nameBar(context) {

    String myName = mData.fullname;

    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/avatar.png'),
        ),
        SizedBox(width: 15),
        Text("Hello, ", 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text( 
          myName ?? 'KOOMPI',
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
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '6,354',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                        
                      ),
                      Text(
                        ' \$',
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
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TopUp()));
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
                  backgroundColor: Colors.lightBlueAccent,
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
                  backgroundColor: Colors.orange,
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
