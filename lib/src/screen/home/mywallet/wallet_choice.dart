import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koompi_hotspot/src/backend/post_request.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_balance.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/home/mywallet/my_wallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletChoice extends StatefulWidget {
  final Function onGetWallet;
  final Function showAlertDialog;

  WalletChoice(this.onGetWallet, this.showAlertDialog);

  @override
  _WalletChoiceState createState() => _WalletChoiceState();
}

class _WalletChoiceState extends State<WalletChoice> {
  String alertText;

  Future checkFirstSeen() async {
    SharedPreferences isSeen = await SharedPreferences.getInstance();
    bool _seen = (isSeen.getBool('seen') ?? false);
    if (_seen != true && mBalance.data == null) {
      isSeen.setBool('seen', true);
      alertText = 'Look like you don\'t have a wallet yet!';
      widget.showAlertDialog(context, alertText);
    }
  }

  @override
  void initState() {
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/images/undraw_wallet.svg',
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.height * 0.2,
                placeholderBuilder: (context) => Center(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: InkWell(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF6078ea).withOpacity(.3),
                            offset: Offset(0.0, 8.0),
                            blurRadius: 8.0)
                      ]),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      var response = await PostRequest().getWallet(mData.email);
                      if(response.statusCode == 200){
                        dialogLoading(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyWallet()),
                        );
                      }
                      else{
                        return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(response.body),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }
                        );
                      }
                    },
                    child: Center(
                      child: Text("Get Wallet",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Bold",
                            fontSize: 18,
                            letterSpacing: 1.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
