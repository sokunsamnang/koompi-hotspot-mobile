import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:koompi_hotspot/src/components/reuse_widget.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';
import 'package:koompi_hotspot/src/screen/option_page/myaccount.dart';
import 'package:koompi_hotspot/src/screen/login/login_page.dart';
import 'package:koompi_hotspot/src/services/services.dart';
import 'package:line_icons/line_icons.dart';
import 'change_password.dart';
import 'package:koompi_hotspot/src/screen/speedtest/speedtest.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  String name = mData.name;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: ListTile(
                  onTap: () async {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyAccount()));
                  },
                  title: Text(
                    name ?? 'KOOMPI',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  leading: CircleAvatar(
                    backgroundImage: mData.image == null ? AssetImage('assets/images/avatar.png') : NetworkImage("https://api-hotspot.koompi.org/uploads/${mData.image}"),
                  ),
                  trailing: Icon(LineIcons.edit),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 4.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(LineIcons.key),
                        title: Text("Change Password"),
                        trailing: Icon(LineIcons.angle_right),
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                        }),
                    // _buildDivider(),
                    // ListTile(
                    //   leading: Icon(LineIcons.money),
                    //   title: Text("Quick Top Up"),
                    //   trailing: Icon(LineIcons.angle_right),
                    //   onTap: () async {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(builder: (context) => ReceiveRequest()),
                    //     );
                    //   },
                    // ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.wifi,
                        size: 20.0,
                      ),
                      title: Text("Speed Test"),
                      trailing: Icon(LineIcons.angle_right),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SpeedTestNet()),
                        );
                      },
                    ),
                    _buildDivider(),
                    ListTile(
                      leading: Icon(LineIcons.sign_out),
                      title: Text("Sign Out"),
                      onTap: () async {
                        showLogoutDialog(context);
                      },
                    ),
                    _buildDivider(),
                    Text('Alpha Version 0.1.0'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}

showLogoutDialog(context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'SIGN OUT',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to sign out?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () async {
                dialogLoading(context);
                await StorageServices().clearToken('token');
                Future.delayed(Duration(seconds: 2), () {
                  Timer(Duration(milliseconds: 500), () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    ModalRoute.withName('/'),
                  ));
                });
              },
            ),
          ],
        );
      });
}
