import 'package:flutter/material.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/screen/home/hotspot/plan.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/my_wallet.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/wallet_choice.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/wallet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget bodyPage(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text('My Wallet', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 18)),
          SizedBox(height: 20),
          mBalance.data != null ? _balanceTokens(context) : startGetWallet(context),
          SizedBox(height: 40),
          Text('My Hotspot Plan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Image.asset('assets/images/icon_launcher.png', width: 25, height: 25,),
                             SizedBox(width: 10),
                             Text(
                              'SELENDRA',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ) 
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 50, right: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Asset',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Expanded(child: Container()),
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 50, ),
                        child: Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Image.asset('assets/images/icon_launcher.png', width: 20, height: 20,),
                                  SizedBox(width: 10),
                                  Text(
                                    'SEL',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(child: Container()),
                            mBalance.data != null ?
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                                child: Text(
                                  '${mBalance.data.balance}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ) : CircularProgressIndicator(),
                          ],
                        ),
                      ),
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

  Widget _noBalanceTokens(context) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.asset('assets/images/icon_launcher.png', width: 25, height: 25,),
                          SizedBox(width: 10),
                          Text(
                          'SELENDRA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ) 
                      ],
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Server in Maintanace',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
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

  Widget startGetWallet(context) {
      showAlertDialog(BuildContext context, String alertText) {
        Widget okButton = FlatButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        AlertDialog alert = AlertDialog(
          title: Text('Oops!'),
          content: Text(alertText),
          actions: [
            okButton,
          ],
        );
        showDialog(
          barrierDismissible: false,
          builder: (BuildContext context) {
            return alert;
          }, context: null,
        );
      }

      onGetWallet() async {
        String _token;
        SharedPreferences isToken = await SharedPreferences.getInstance();
        _token = isToken.get('token');
        if (_token == null) {
          String alertText = 'Please Sign up with Email or Phone to get wallet';
          showAlertDialog(context, alertText);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyWallet()),
          );
        }
      }
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
                     Container(
                        width: 140,
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
                                  MaterialPageRoute(builder: (context) => WalletChoice(onGetWallet, showAlertDialog)),
                                );
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.account_balance_wallet_outlined,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Get Wallet",
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
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .27,
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
                  '50 SEL',
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
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    ),
                  ],
                ),
              ),
            )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget noPlanView(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .27, 
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          color: Colors.blueGrey[900],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No Hotspot Plan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            ],
          ),
        ),
      ],
    
  );
}
