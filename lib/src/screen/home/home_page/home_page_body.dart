import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/home/home_page/promotion.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/plan.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/my_wallet.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/wallet_screen.dart';

Widget bodyPage(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).copyWith().size.height * 1,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          _nameBar(context),
          SizedBox(height: 30),
          Text('My Wallet', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 20),
          _balanceTokens(context),
          SizedBox(height: 40),
          Text('Your Plans', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 20),
          planView(context),
          // SizedBox(height: 40),
          // Text('Promotions', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18)),
          // SizedBox(height: 20),
          // Expanded(child: MyCarousel(),)
        ],
      ),
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
          borderRadius: BorderRadius.all(Radius.circular(12)),
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
                          '${mBalance.balance}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                          ),
                          
                        ),
                        Text(
                          ' SEL',
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
                        width: 110,
                        padding:
                          EdgeInsets.symmetric(horizontal: 1, vertical: 1),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => WalletScreen()),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.read_more,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Detail",
                                    style: TextStyle(
                                      fontFamily: "Medium",
                                      color: Colors.white),
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

Widget planView(BuildContext context) {
  return Container(
  width: MediaQuery.of(context).copyWith().size.width * 2,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12.0),
    color: Colors.grey[900],
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).copyWith().size.width * 2,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12.0),
            topRight: const Radius.circular(12.0),
          ),
          color: Colors.blueGrey[900],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Username: koompi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Medium'
                  ),
                ),
                Text(
                  '5000៛',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins-Medium'
                  ),
                ),
              ],
            ),
          ],
        )
      ),
      Container(
        // width: MediaQuery.of(context).copyWith().size.height / 2,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Device: 2 Devices',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Medium'
              ),
            ),
            SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expiration: 30 Days',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Medium'
                    ),
                  ),
                  FlatButton(
                    color: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Plan(),
                        )
                      );
                    },
                    child: Text("Detail",
                      style: TextStyle(color: Colors.lightBlue)
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
